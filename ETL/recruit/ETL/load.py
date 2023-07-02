from datetime import datetime
from airflow.providers.google.cloud.hooks.gcs import GCSHook
import pandas as pd
import json


def check_rawdata(**kwargs):
    """
        데이터 추출의 결과로 데이터가 있었는지 확인
        return : 다음 진행할 task 이름
    """
    ti = kwargs['task_instance']
    crawl_result = ti.xcom_pull(key="return_value", task_ids='extract_rawdata')
    if len(crawl_result['data']) == 0:
        return "no_data_found"
    else:
        return "load_rawdata"

def load_rawdata(**kwargs):
    """
        원시데이터, 데이터 적재 시간을 gcs에 업로드
    """
    # xcom pull
    ti = kwargs['task_instance']
    crawl_result = ti.xcom_pull(key="return_value", task_ids='extract_rawdata')
    gcs_hook = GCSHook(gcp_conn_id='gcs_conn')
    
    # data
    data = crawl_result['data']
    history = crawl_result['history']
    data_json = json.dumps(data)

    # set time format
    now = datetime.strptime(history[-1], '%Y-%m-%d %H:%M:%S')
    filenow = now.strftime('%Y-%m-%d__%H-%M-%S')

    time = '\n'.join(history)

    # upload json
    bucket_name = 'hale-posting-bucket'
    object_name = f'recruit/recruit_info{filenow}.json'
    mime_type = "application/json"
    gcs_hook.upload(bucket_name=bucket_name, object_name=object_name, data=data_json, mime_type=mime_type)

    # upload execution time
    gcs_hook.delete(bucket_name, object_name='recruit/env/time.txt')
    gcs_hook.upload(bucket_name=bucket_name, object_name='recruit/env/time.txt', data=time, mime_type='text/plain')


def load_csv(**context):
    """
        csv형식으로 전처리된 채용공고를 GCS에 업로드
    """
    ti = context['task_instance']
    filenow = ti.xcom_pull(key='return_value', task_ids='pull_rawdata')['time']
    data = ti.xcom_pull(key='return_value', task_ids='json_to_dataframe')['postings']
    gcs_hook = GCSHook(gcp_conn_id="gcs_conn")

    df = pd.DataFrame(data)

    data_csv = df.to_csv(index=False).encode('utf-8')
    # upload csv
    bucket_name = 'hale-posting-bucket'
    object_name = f'recruit/recruit_info{filenow}.csv'
    mime_type = "text/csv"
    gcs_hook.upload(bucket_name=bucket_name, object_name=object_name, data=data_csv, mime_type=mime_type)
    
    return {'counts' : len(data), 'csv_name' : f'recruit_info{filenow}.csv'}