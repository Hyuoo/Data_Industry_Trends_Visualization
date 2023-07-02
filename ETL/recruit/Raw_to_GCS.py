from datetime import datetime
from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator, BranchPythonOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.dagrun_operator import TriggerDagRunOperator
from recruit.ETL.extract import extract_rawdata
from recruit.ETL.load import check_rawdata, load_rawdata
from recruit.alarm.slack import no_data_upload, failure_callback


dag = DAG(
    dag_id="Raw_to_GCS",
    tags=['ETL', 'recruit'],
    start_date=datetime(2023,6,25),
    schedule = '0 * * * *',
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

extract_rdata = PythonOperator(
    task_id = 'extract_rawdata',
    python_callable = extract_rawdata,
    dag = dag
)

check_rawdata = BranchPythonOperator(
    task_id = 'check_rawdata',
    python_callable = check_rawdata,
    dag = dag
)

no_data_found = DummyOperator(
    task_id = 'no_data_found',
    dag = dag,
    on_success_callback = no_data_upload
)

load_rdata = PythonOperator(
    task_id = 'load_rawdata',
    python_callable = load_rawdata,
    dag = dag
)

trigger_csv = TriggerDagRunOperator(
    task_id = 'trigger_csv',
    trigger_dag_id = 'Raw_to_csv',
    trigger_run_id=None, 
    execution_date=None, 
    reset_dag_run=False, 
    wait_for_completion=False, 
    poke_interval=60, 
    allowed_states=["success"], 
    failed_states=['failed', 'skipped'], 
)

start_task >> extract_rdata >> check_rawdata
check_rawdata >> [no_data_found, load_rdata]
load_rdata >> trigger_csv >> end_task
