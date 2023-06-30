import pandas as pd
from google.cloud import storage
import time
from google.auth.exceptions import RefreshError
import requests
from pathlib import Path
from google.cloud.exceptions import Conflict, NotFound
import pytz
from datetime import datetime
from pytrends.request import TrendReq
from airflow.models import Variable
import logging
import os
from google.oauth2.credentials import Credentials
from airflow.hooks.base import BaseHook
from google.oauth2 import service_account
import json
import tempfile
from slack_jw import send_slack_notification, send_slack_error_notification
from requests.exceptions import RequestException

# 로거 설정
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# 로그 파일 핸들러 설정
log_path = os.path.join(os.getcwd(), "google_trends_data_pipeline.log")

file_handler = logging.FileHandler(log_path)
file_handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)

# 로그 파일 핸들러 추가
logger.addHandler(file_handler)

df_list = []
search_start_date = "2018-05-01"

cnt = 0

def build_payload_and_retry(pytrends, keyword, start_date):
    """ PyTrends 객체를 초기화하고 요청에 대해 stable한 응답을 받을 때까지 retry """

    end_date = datetime.now().strftime("%Y-%m-%d")
    timeframe = f"{start_date} {end_date}"

    MAX_TRIES = 5
    delay = 10
    for i in range(MAX_TRIES):
        try:
            pytrends.build_payload(keyword, timeframe=timeframe, geo='KR')
            time.sleep(delay) # 안정적인 응답을 위한 대기 시간 추가
            break
        except Exception as e:
            print(f"Failed to build payload, retrying in {delay} seconds, {MAX_TRIES - i - 1} tries left")
            time.sleep(delay)
    if i == MAX_TRIES - 1:
        raise ValueError("Failed to build payload after {MAX_TRIES} tries")

# def collect_data(ti, **kwargs):
def collect_data(request_str, req_time, hour, **kwargs):
    """ 데이터 수집 함수 """
    global cnt

    try:
        # 데이터 수집 함수 구현
        keyword_groups = [
            ['정보처리'],
            ['인공지능'],
            ['빅데이터'],
            ['백준'],
            ['부트캠프'],
            ['데이터베이스'],
            ['데이터 마이닝'],
            ['데이터 엔지니어'],
            ['데이터 분석가'],
            ['데이터 아키텍처'],
            ['데이터 사이언티스트'],
            ['devops'],
            ['ETL'],
            ['data lake'],
            ['data warehouse'],
            ['Docker'],
            ['Kafka'],
            ['Spark'],
            ['AWS'],
            ['Kubernetes'],
            # 추후 추가 키워드 ['Microsoft Azure', 'dbt', 'BigQuery', 'Cassandra', 'Airflow',]
        ]




        keyword_translation = {
            '정보처리': 'info',
            '인공지능': 'ai',
            '빅데이터': 'bigdata',
            '백준': 'boj',
            '부트캠프': 'bootcamp',
            '데이터베이스': 'db',
            '데이터 마이닝': 'dm',
            '데이터 아키텍처': 'datearch',
            '데이터 엔지니어': 'de',
            '데이터 분석가': 'da',
            '데이터 사이언티스트': 'ds'
        }

        pytrends = TrendReq(hl='ko-KR', tz=540)

        json_df_list = []

        for keywords in keyword_groups:
            try:
                build_payload_and_retry(pytrends, keywords, search_start_date)
                df = pytrends.interest_over_time()
                df.reset_index(inplace=True)
                df.drop(columns=['isPartial'], inplace=True)
                if cnt > 0:
                    df.drop(columns=['date'], inplace=True)

                # 데이터 프레임의 열 이름 변경
                df.rename(columns=keyword_translation, inplace=True)

                # 데이터 프레임을 JSON 문자열로 변환
                json_df = df.to_json(orient="split")
                json_df_list.append(json_df)
                cnt += 1

            except ValueError as e:
                print(e)

            except Exception as e:
                send_slack_error_notification(f"An error occurred while collecting data for '{keywords}': {e}")
                continue

        # 성공적으로 수집되었을 때 슬랙 알림
        send_slack_notification(f"{request_str} 데이터가 성공적으로 수집되었습니다.")

        # XCom에 결과를 저장함
        kwargs['ti'].xcom_push(key='collected_data', value=json_df_list)

    except RequestException as e:
        logger.error(f"Failed to fetch data for '{request_str}': {e}")
        send_slack_error_notification(f"Failed to fetch data for '{request_str}': {e}")



# def merge_and_upload_data(ti, project_id, bucket_name, **kwargs):
def merge_and_upload_data(bucket_name, gcp_conn_id, **kwargs):
    """ 전체 결과를 만들기 위한 함수 """


    ti = kwargs['ti']
    # collect_data의 결과를 XCom에서 가져옴
    json_df_list = ti.xcom_pull(task_ids='collect_data', key='collected_data')
    # JSON 문자열을 다시 데이터 프레임으로 변환
    df_list = [pd.read_json(json_df, orient="split") for json_df in json_df_list]

    # project_id 및 bucket_name 값 확인
    logger.info(f"Project ID: {gcp_conn_id}")
    logger.info(f"Bucket Name: {bucket_name}")

    try:

        # DataFrame 리스트를 생성하여 데이터 프레임에 추가하기
        merged_df = pd.concat(df_list, axis=1)

        # CSV 형식의 문자열로 저장하기
        csv_string = merged_df.to_csv(index=False)

        # KST 타임존으로 변경
        KST = pytz.timezone('Asia/Seoul')
        now = datetime.now(KST).strftime('%Y-%m-%d %H:%M:%S.%f')

        directory_blob = "google_trend/"
        blob_name = f"{directory_blob}result_{now}.csv"

        # BaseHook을 사용하여 connection 정보를 가져옵니다.
        gcp_connection = BaseHook.get_connection("gcp_connection")

        # Connection에서 제공한 extra 필드에서 JSON 키 파일 내용을 가져옵니다.
        extra = json.loads(gcp_connection.extra)
        keyfile_dict = json.loads(extra['keyfile_dict']) # JSON 문자열을 사전 딕셔너리로 변환

        # JSON 키 파일 내용으로부터 인증 정보를 생성합니다.
        credentials = service_account.Credentials.from_service_account_info(keyfile_dict)
        logger.info(f"credentials: {credentials}")

        with tempfile.NamedTemporaryFile(mode='w', delete=False) as temp_file:
            temp_file.write(csv_string)
            temp_file.flush()

            storage_client = storage.Client(credentials=credentials)  # assumes you're App Default Credentials.
            bucket = storage_client.get_bucket(bucket_name)
            blob = bucket.blob(blob_name)

            with open(temp_file.name, "rb") as file_obj:
                blob.upload_from_file(file_obj, content_type="text/csv")

            # Clean up the temp file once the upload is complete
            os.remove(temp_file.name)

        print(f"Data uploaded to {blob_name} in {bucket_name}")

        # Slack에 알림 메시지 전송
        num_data = len(df_list)
        send_slack_notification("Google Trend 데이터 GCS 업로드 완료되었습니다.", num_data)

    except Exception as e:
        print(f"An error occurred while uploading to {bucket_name}")
        logger.error(f"An error occurred while uploading to hale-posting-bucket: {e}")
        print(str(e))
