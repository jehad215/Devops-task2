## Overview
Create an EC2 instance, Private S3 bucket and python script to get logs from EC2 instance then send them to S3 bucket daily.

## Required action:
 - Create a free tier AWS account
 - Create a t2.micro EC2 instance
 - Create S3 bucket
 - S3 bucket can’t be public access
 - Create a Python or Base script to get logs from EC2 and achieve it.
 - Logs should be sent daily to your S3 bucket.

***

## Steps:

## Starting with terraform resources creation
 #### In terraform directory:
 ```bash
 $ terraform init  
 $ terraform plan
 $ terraform apply
```
## SSH to the created EC2 instance to add instance id

 ```bash
 # to add needed parameters
 $ sudo vim script.py
 
 $ chmod 400 test.pem
 
 # to run the script
 $ python3 script.py
 ```
 
 #### Navigate to s3 bucket and vioalaa, the logs appered in a compressed file, you can download it

***

## Or you can run the script from your local machine
 
```bash
 # Edit the script with your credintials, Instance_Id, Your_bucket_name
 
 # Make sure you have this prerequists in your local machine
 $ sudo apt install -y python3-dev python3-pip
 $ sudo pip3 install boto3

 # On the test.pem directory
 $ chmod 400 test.pem
 
 # Run the script
 $ python3 script.py
 ```
 #### And again vioalaa, the logs appered in the s3 bucket

***

 #### Now you can take deep breath and destroy your resources if you need
 ```bash
 $ terraform destroy
```

***

## Note: You don't have to worry about runnig the script daily, the This is a user_data on ec2 word do it for you using cronetab 
