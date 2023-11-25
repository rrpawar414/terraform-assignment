provider "aws" {
  region = "us-east-1"  
}
# IAM User
resource "aws_iam_user" "s3_user" {
  name = "s3-full-access-user"
}

resource "aws_iam_user_policy" "s3_user_policy" {
  name   = "s3-full-access-policy"
  user   = aws_iam_user.s3_user.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}
# S3 Bucket
resource "aws_s3_bucket" "mybucket"{
  bucket = "rahulassignment1133"  
  
}

# EC2 Instances
resource "aws_instance" "ec2_instance" {
  count         = 2
  ami           = "ami-0230bd60aa48260c6"  
  instance_type = "t2.micro"  

 vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Project    = "CLOD1003"
    "Created by" = "RahulPawar"
  }
}
# Security Group
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group1133"
  description = "Allow inbound connections on port 80 and 443"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project    = "CLOD1003"
    "Created by" = "RahulPawar"
  }
}