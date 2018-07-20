# -*- coding: utf-8 -*-

import boto3
import json
import os
import subprocess

TOPIC_ARN = os.environ['TOPIC_ARN']

def _(cmd):
    return subprocess.check_output(cmd)

def lambda_handler(event, context):
    client = boto3.client('sns')
    msg = ""

    try:
        json_string = _(['./login_re_net.sh'])
        result = json.loads(json_string)
    except:
        print("except:", json_string)
        result = {'result':False}

    request = {
        'TopicArn': TOPIC_ARN,
        'Message': str(result['result']),
        'Subject': 'Login Re Net Result'
    }

    if not result['result']:
        return client.publish(**request)
    else:
        return {'result':True}
