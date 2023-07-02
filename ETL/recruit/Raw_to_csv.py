from datetime import datetime
from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator
from recruit.ETL.extract import pull_rawdata
from recruit.ETL.transform import json_to_dataframe
from recruit.ETL.load import load_csv
from recruit.alarm.slack import upload_success_callback, failure_callback

dag = DAG(
    dag_id="Raw_to_csv",
    tags=['ETL', 'recruit'],
    start_date=datetime(2023,6,25),
    schedule = '@once',
    max_active_runs = 1,
    catchup = False,
    default_args = {
        'retries' : 1,
        'retry_delay' : timedelta(minutes=1),
        'on_failure_callback' : failure_callback
    }
)

start_task = DummyOperator(
    task_id = 'start_task',
    dag = dag
)

end_task = DummyOperator(
    task_id = 'end_task',
    dag = dag
)

pull_rdata = PythonOperator(
    task_id = 'pull_rawdata',
    python_callable = pull_rawdata,
    dag = dag
)

json_to_df = PythonOperator(
    task_id = 'json_to_dataframe',
    python_callable = json_to_dataframe,
    dag = dag
)

upload_csv = PythonOperator(
    task_id = 'load_csv',
    python_callable = load_csv,
    dag = dag,
    on_success_callback = upload_success_callback
)

start_task >> pull_rdata >> json_to_df >> upload_csv >> end_task