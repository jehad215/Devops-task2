resource "aws_s3_bucket" "jee-task-bucket" {
  bucket = "jee-task-bucket"

  tags = {
    Name = "jee-task-bucket"
  }

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# To block public access
resource "aws_s3_bucket_public_access_block" "example_public_access_block" {
  bucket = aws_s3_bucket.jee-task-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# policy to access s3 and write to it
resource "aws_iam_policy" "s3_write_policy" {
  name = "s3_write_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::jee-task-bucket",
          "arn:aws:s3:::jee-task-bucket/*",
          "arn:aws:s3:::jee-task-bucket/logs/*"
        ]
      }
    ]
  })
}
