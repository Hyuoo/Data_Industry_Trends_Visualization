import requests
import json
from airflow.models import Variable


def send_slack_notification(message, num_data=None):
    webhook_url = 'https://hooks.slack.com/services/' + Variable.get("jungwoo_slack_url")
    if num_data is not None:
        message += f"\n{num_data}개의 데이터가 처리되었습니다."
    slack_data = {'text': message}
    response = requests.post(webhook_url, data=json.dumps(slack_data), headers={'Content-Type': 'application/json'})

    if response.status_code != 200:
        print(f"Slack message sending failed: {response.text}")


def send_slack_error_notification(error_message):
    error_message = f"Error! {error_message}"
    send_slack_notification(error_message)