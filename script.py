#!/usr/bin/env python3

import boto3
import os

# Set up AWS credentials
session = boto3.Session(
    aws_access_key_id='<YOUR AWS_ACCESS_KEY_ID>',
    aws_secret_access_key=' <YOUR AWS_SECRET_ACCESS_KEY> ',
    region_name='<YOUR_REGION>'
)

# Set up connection parameters for the EC2 instance
ec2 = session.client('ec2')
response = ec2.describe_instances(InstanceIds=['YOUR_INSTANCE_ID'])
ip_address = response['Reservations'][0]['Instances'][0]['PublicIpAddress']
key_path = './<Your Key Path File Name>'

# Connect to the EC2 instance using SSH
ssh_command = f'ssh -i {key_path} ec2-user@{ip_address} sudo cat /var/log/messages'
local_log_path = 'messages'
os.system(f'{ssh_command} > {local_log_path}')

# Upload the log file to S3
s3_bucket = '<YOUR_S3_BUCKET_NAME>'
s3_object_key = 'messages'
s3 = session.resource('s3')
s3.Bucket(s3_bucket).upload_file(local_log_path, s3_object_key)

# Remove the local log file after uploading to S3
os.remove(local_log_path)



















