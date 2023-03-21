resource "aws_instance" "example_instance" {
  ami = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"
  key_name      = "test"
  monitoring    = true
  subnet_id = aws_subnet.example_subnet.id
  vpc_security_group_ids = [aws_security_group.example_security_group.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  user_data = <<-EOF
                #!/usr/bin/bash
                sudo yum update -y
                sudo yum install -y python3-devel python3-pip
                sudo pip3 install boto3
                sudo yum install -y awslogs
                sudo service awslogsd restart
                EOF

  provisioner "file" {
    source      = "./script.py"
    destination = "/home/ec2-user/script.py"
  }
  
  provisioner "file" {
    source      = "./test.pem"
    destination = "/home/ec2-user/test.pem"
  }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("./test.pem")}"
    host = self.public_ip
  }

  tags = {
    Name = "example-instance"
  }
}

# attach cloudwatch full access to ec2
data "aws_iam_policy_document" "cloudwatch_policy" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "cloudwatch" {
  name = "cloudwatch-policy"
  policy = data.aws_iam_policy_document.cloudwatch_policy.json
}




resource "aws_iam_role" "ec2_instance_role" {
  name = "ec2-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ec2_instance_role.name
}



resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"

 
}























