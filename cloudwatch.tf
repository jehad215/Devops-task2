
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/var/log/messages"
 
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "stream" {
  name            = aws_instance.example_instance.id
  log_group_name  = aws_cloudwatch_log_group.log_group.name
}


#### policies
resource "aws_iam_policy" "logs_policy" {
  name = "your-logs-policy-name"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:GetLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::jee-task-bucket",
          "arn:aws:s3:::jee-task-bucket/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "logs_role" {
  name = "your-logs-role-name"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Terraform   = "true"
  }
}

resource "aws_iam_role_policy_attachment" "logs_attachment" {
  policy_arn = aws_iam_policy.logs_policy.arn
  role       = aws_iam_role.logs_role.name
}
