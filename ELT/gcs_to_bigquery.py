from airflow import DAG
from airflow.contrib.operators.bigquery_operator import BigQueryOperator
from airflow.contrib.operators.gcs_to_bq import GoogleCloudStorageToBigQueryOperator
from airflow.contrib.operators.bigquery_check_operator import BigQueryCheckOperator
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime, timedelta
import pandas as pd
import logging
from elt_slack import on_failure_callback, on_success_callback
from airflow.providers.google.cloud.hooks.gcs import GCSHook
from airflow.providers.google.cloud.hooks.bigquery import BigQueryHook

default_args = {
    'owner': 'airflow',
    'depends_on_past' : False,
    'email': ['taejun3305@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=3), 
}

## GCP information
project_id = "job-posting-api-388303"
staging_dataset = 'staging'
dwh_dataset = 'external'
# bucket detail information
gs_bucket_recruit = 'hale-posting-bucket/recruit'
gs_bucket_google_trend = 'hale-posting-bucket/google_trend'
gs_bucket_certification = 'hale-posting-bucket/certification'

# define DAG
with DAG(
    dag_id='GCS_to_Bigquery',
    start_date=datetime(2023,5,31),
    catchup=False,
    default_args=default_args,
    description='Data load from GCS to Bigquery',
    schedule_interval='0 */3 * * *'
) as dag:

    gcs_hook = GCSHook(gcp_conn_id = 'gcp_airflow_conn_id')
    bigquery_hook = BigQueryHook(gcp_conn_id = 'gcp_airflow_conn_id')

    start_pipeline = DummyOperator(
        task_id = 'start_pipeline'
    )
    # Loading data from GCS to Bigquery
    load_recruit = GoogleCloudStorageToBigQueryOperator(
        dag = dag,
        task_id = 'load_recruit',
        bucket = gs_bucket_recruit,
        source_objects = ['recruit_info20*.csv'],
        destination_project_dataset_table = f'{project_id}:{staging_dataset}.recruit',
        schema_object = 'gs://hale-posting-bucket/schema/recruit_schema.json',
        write_disposition = 'WRITE_APPEND',
        source_format = 'CSV',
        field_delimiter = ',',
        encoding = 'UTF-8',
        on_failure_callback = on_failure_callback, 
    )

    load_google_trend = GoogleCloudStorageToBigQueryOperator(
        dag = dag,
        task_id = 'load_google_trend',
        bucket = gs_bucket_google_trend,
        source_objects = ['result_20*.csv'],
        destination_project_dataset_table = f'{project_id}:{staging_dataset}.google_trend',
        schema_object='gs://hale-posting-bucket/schema/google_trend_schema.json',
        write_disposition = 'WRITE_APPEND',
        source_format = 'CSV',
        encoding = 'UTF-8',
        on_failure_callback = on_failure_callback, 
    )

    # Check load data not null and data schema
    check_recruit = BigQueryCheckOperator(
        dag = dag,
        task_id = 'check_recruit',
        # schema detect
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback, 
        # checking rows_count in staging
        sql = f"SELECT COUNT(*) FROM {project_id}.{staging_dataset}.recruit"
    )

    check_google_trend = BigQueryCheckOperator(
        dag = dag,
        task_id = 'check_google_trend',
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback,
        # checking rows_count in staging
        sql = f"SELECT COUNT(*) FROM {project_id}.{staging_dataset}.google_trend"
    )
    
    # load dimensions data from filed directly DW table
    load_certification = GoogleCloudStorageToBigQueryOperator(
        dag = dag,
        task_id = 'load_certification',
        bucket = gs_bucket_certification,
        source_objects = ['certificate_info.csv'],
        destination_project_dataset_table = f'{project_id}:{dwh_dataset}.certification',
        source_format = 'CSV',
        write_disposition = 'WRITE_TRUNCATE',
        autodetect = True,
        encoding = 'UTF-8',
        on_failure_callback = on_failure_callback,
        schema_fields = [
            {'name': '시험구분', 'type': 'STRING', 'mode': 'REQUIRED'},
            {'name': '검정연도', 'type': 'INT', 'mode': 'REQUIRED'},
            {'name': '자격등급', 'type': 'STRING', 'mode': 'REQUIRED'}, 
            {'name': '응시자수', 'type': 'INT', 'mode': 'REQUIRED'},
            {'name': '취득자수', 'type': 'INT', 'mode': 'REQUIRED'}
        ]
    )
    
    loaded_data_to_staging = DummyOperator(
        task_id = 'loaded_data_to_staging'
    )

    # create & check fact data
    create_recruit = BigQueryOperator(
        dag = dag,
        task_id = 'create_recruit',
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback, 
        params = {
            'project_id': project_id,
            'staging_dataset': staging_dataset,
            'dwh_dataset': dwh_dataset
        },
        # CTAS 구문으로 external_recruit 생성
        sql = 'taejun3305/instance-1/ELT_GCP/sql/Dimension_recruit.sql'
    )
    check_dim_recruit = BigQueryCheckOperator(
        dag = dag,
        task_id = 'check_dim_recruit',
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback, 
        params = {
            'project_id': project_id,
            'staging_dataset': staging_dataset,
            'dwh_dataset': dwh_dataset
        },
        sql = f'SELECT COUNT(*) FROM {project_id}.{dwh_dataset}.external.recruit'
    )
    create_google_trend = BigQueryOperator(
        dag = dag,
        task_id = 'create_google_trend',
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback, 
        params = {
            'project_id': project_id,
            'staging_dataset': staging_dataset,
            'dwh_dataset': dwh_dataset
        },
        # CTAS 구문으로 external_google_trend 생성
        sql = 'taejun3305/instance-1/ELT_GCP/sql/Dimension_google_trend.sql'
    )

    check_dim_google_trend = BigQueryCheckOperator(
        dag = dag,
        task_id = 'check_dim_google_trend',
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback, 
        params = {
            'project_id': project_id,
            'staging_dataset': staging_dataset,
            'dwh_dataset': dwh_dataset
        }, 
        sql = f'SELECT COUNT(*) FROM {project_id}.{dwh_dataset}.external.google_trend'
    )

    check_certification = BigQueryCheckOperator(
        dag = dag,
        task_id = 'check_certification',
        use_legacy_sql = True,
        on_failure_callback = on_failure_callback, 
        params = {
            'project_id': project_id,
            'staging_dataset': staging_dataset,
            'dwh_dataset': dwh_dataset
        }, 
        sql = f'SELECT COUNT(*) FROM `{project_id}.{dwh_dataset}.external.certification`'
    )


    finish_pipeline = DummyOperator(
        task_id = 'finish_pipeline'
    )


    # If tasks are successfully finished, them will be executed
    load_google_trend.on_success_callback = on_success_callback
    load_recruit.on_success_callback = on_success_callback
    check_google_trend.on_success_callback = on_success_callback
    check_recruit.on_success_callback = on_success_callback
    load_certification.on_success_callback = on_success_callback
    check_certification.on_success_callback = on_success_callback
    create_google_trend.on_success_callback = on_success_callback
    check_dim_google_trend.on_success_callback = on_success_callback
    create_recruit.on_success_callback = on_success_callback
    check_dim_recruit.on_success_callback = on_success_callback

    # define task dependencies
    start_pipeline >> [load_google_trend, load_recruit, load_certification]

    load_google_trend >> check_google_trend 
    load_recruit >> check_recruit

    [check_recruit, check_google_trend, load_certification] >> loaded_data_to_staging

    loaded_data_to_staging >> [create_recruit, create_google_trend, check_certification]

    create_recruit >> check_dim_recruit
    create_google_trend >> check_dim_google_trend

    [check_dim_recruit, check_dim_google_trend, check_certification] >> finish_pipeline