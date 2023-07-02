from airflow.providers.slack.hooks.slack_webhook import SlackWebhookHook

def upload_success_callback(context):
    ti = context['task_instance']
    counts = ti.xcom_pull(key='return_value', task_ids=ti.task_id)['counts']
    csv_name = ti.xcom_pull(key='return_value', task_ids=ti.task_id)['csv_name']

    hook = SlackWebhookHook(slack_webhook_conn_id='recruit_slack')
    
    payload =  { "attachments" : [
            {
                "color": "#9733EE",
                'fields':[
                    {
                        "title": "스케줄러 알림:satellite:",
                        "value": f"파일({counts}개 데이터)이 성공적으로 적재되었습니다."
                    }
                ]
            }
    ]}

    hook.send_dict(payload, headers = {'content-type': 'application/json'})


def failure_callback(context):
    task = context['task_instance'].task_id
    dag = context['dag'].dag_id
    exec_time = context['task_instance'].execution_date
    detail = "```" + str(context.get('exception')) + "```"

    hook = SlackWebhookHook(slack_webhook_conn_id='recruit_slack')
    payload =  { "attachments" : [
            {
                "color": "#9733EE",
                'fields':[
                    {
                        "title": "ERROR!!:scream:",
                        "value": f"""
dag : {dag}
task : {task}
time : {exec_time}
*detail*{detail}"""
                    }
                ]
            }
    ]}
    hook.send_dict(payload, headers = {'content-type': 'application/json'})


def no_data_upload(context):
    hook = SlackWebhookHook(slack_webhook_conn_id='recruit_slack')
    payload =  { "attachments" : [
            {
                "color": "#9733EE",
                'fields':[
                    {
                        "title": ":sleeping:스케줄러 알림",
                        "value": f"업로드할 채용 공고가 없습니다."
                    }
                ]
            }
    ]}

    hook.send_dict(payload, headers = {'content-type': 'application/json'})