from datetime import timedelta
from datetime import datetime
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils.dates import days_ago
from airflow.models import Variable
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from google_trends_pipeline import collect_data, merge_and_upload_data
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s:%(levelname)s:%(name)s:%(message)s')
file_handler = logging.FileHandler('google_trends_dag.log')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)
sys.path.append(os.path.abspath(os.path.dirname(__file__)))

# DAG 인수 정의
default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=10),
    'start_date': datetime(2021,6,25),
}

# DAG 객체 생성
dag = DAG(
    dag_id = 'google_trends_to_gcs',
    default_args=default_args,
    description='A DAG to collect Google Trends data and upload to Google Cloud Storage',
    schedule_interval='30 * * * *',   # 매 시각 정각 30분마다 실행
    catchup=False,
    tags=['ETL', 'google_trends'],  # 태그 추가
)

# 번들(PythonOperator와 연결되는) 수집 데이터 작업
collect_data_task = PythonOperator(
    task_id='collect_data',
    python_callable=collect_data,
    op_args=['Google Trend', 'my_req_time', 'my_hour'],
    provide_context=True,
    dag=dag,

)

# 번들 저장 데이터 작업
merge_and_upload_data_task = PythonOperator(
    task_id='merge_and_upload_data',
    op_args=['hale-posting-bucket', 'gcp_connection'],
    python_callable=merge_and_upload_data,
    provide_context=True,
    dag=dag,
)

# 의존성 정의
collect_data_task >> merge_and_upload_data_task
