## Overview
Create an EC2 instance, Private S3 bucket and python script to get logs from EC2 instance then send them to S3 bucket daily.

## Required action:
 - Create a free tier AWS account
 - Create a t2.micro EC2 instance
 - Create S3 bucket
 - S3 bucket can’t be public access
 - Create a Python or Base script to get logs from EC2 and achieve it.
 - Logs should be sent daily to your S3 bucket.

## Steps:

### Starting with terraform resources creation
 #### In terraform directory:
 ```bash
 $ terraform init  
 $ terraform plan
 $ terraform apply
```
#### SSH to the created EC2 instance to add instance id

 ```bash
 # to add needed parameters
 $ sudo vim script.py

 $ chmod 400 test.pem
 
 # to run the script
 $ python3 script.py
 ```
 #### Navigate to s3 bucket and vioalaa, the logs appered in a compressed file, you can download it

 #### Finally to make it runs daily:
 ```bash
 $ sudo crontab -e
```
 - and add this line to the file: 0 0 * * * /usr/bin/python3 ./script.py



 #### Now you can take deep breath and destroy your resources if you need
 ```bash
 $ terraform destroy
```
 

 


