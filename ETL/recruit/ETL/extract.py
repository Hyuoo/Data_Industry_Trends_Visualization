from airflow.providers.google.cloud.hooks.gcs import GCSHook
from airflow.models import Variable
from datetime import datetime

import requests
import pandas as pd
import json

def pull_time():
    """
        gcs에 저장된 데이터 추출 시점을 불러오는 함수
        return : 데이터 추출 시점을 담은 list
    """
    gcs_hook = GCSHook(gcp_conn_id='gcs_conn')
    bucket_name = 'hale-posting-bucket'
    object_name = 'recruit/env/time.txt'
    file_content = gcs_hook.download(bucket_name=bucket_name, object_name=object_name)
    history = file_content.decode('utf-8')
    return history.split('\n')

def extract_rawdata():
    """
        api request로 데이터 호출. 반환값에서 채용공고 데이터만을 json으로 변환해서 반환
        return : json, execution time history
    """
    # load airflow variable parameters
    url = Variable.get("recruit_url")
    params = {'access-key' : Variable.get("api_key"), 'ind_cd' : '3', 'fields': 'posting-date,expiration-date,keyword-code,count', 'count':110, 'start':0}
    
    # load last execution time, time now
    history = pull_time()
    timefrom = history[-1]
    ts = datetime.now()
    timeto = ts.strftime('%Y-%m-%d %H:%M:%S')

    # set time range
    params['published_min'] = timefrom
    params['published_max'] = timeto

    # api request to init
    try:
        res = requests.get(url, params=params)
    except (requests.exceptions.RequestException) as e:
        print('api 접근 실패 :', e)
        raise
    
    # check if data exists
    data_json = res.json()
    data = data_json['jobs']['job']
    if data_json['jobs']['total'] == 0:
        print('새로 업로드된 채용공고가 없습니다.')
        return {"data":[]}
    
    # total pages
    pages = (int(data_json['jobs']['total']) - 1) // 110

    # api requests
    for page in range(1, pages+1):
        params['start'] = page
        res = requests.get(url, params=params)
        data_json = res.json()
        data += data_json['jobs']['job']

    # add execution time
    history.append(timeto)
    return {'data' : data, "history" : history}

def pull_rawdata():
    """
        GCS로부터 새로 추가된 json파일을 반환
        return : dict
    """
    exectime = pull_time()[-1]
    now = datetime.strptime(exectime, '%Y-%m-%d %H:%M:%S')
    filenow = now.strftime('%Y-%m-%d__%H-%M-%S')

    gcs_hook = GCSHook(gcp_conn_id="gcs_conn")

    # download json
    bucket_name = 'hale-posting-bucket'
    object_name = f'recruit/recruit_info{filenow}.json'
    rawdata = gcs_hook.download(bucket_name=bucket_name, object_name=object_name)

    return {"rawdata":json.loads(rawdata), "time":filenow}