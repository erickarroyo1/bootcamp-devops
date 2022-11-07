#Reource s3 bucket

resource "aws_s3_bucket" "this_s3_bucket" {
  count  = length(var.buckets)
  bucket = var.buckets[count.index].bucket-name
  # Enable versioning so we can see the full revision history of our
  # state files

  tags = var.tagging
  #define provider
  provider = aws.bootcamp-tlz-account
}

#enable versioning for s3
resource "aws_s3_bucket_versioning" "tf-security-s3-versioning" {
  count  = length(var.buckets)
  bucket = var.buckets[count.index].bucket-name
  versioning_configuration {
    status = "Enabled"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

#S3 Bucket ACL

resource "aws_s3_bucket_acl" "b_acl" {
  count    = length(var.buckets)
  bucket   = var.buckets[count.index].bucket-name
  acl      = "private"
  provider = aws.bootcamp-tlz-account
}

#Resource Dynamodb 

resource "aws_dynamodb_table" "bootcamp_dynamodb" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "CustomerID"
  attribute {
    name = "CustomerID"
    type = "S"
  }

  tags = merge(
    var.tagging,
    {
      Name = var.dynamodb_table_name
    },
  )
  #define provider
  provider = aws.bootcamp-tlz-account
}

#Lambda Bootcamp

resource "aws_iam_role" "lab_role" {
  name     = "lab_role"
  provider = aws.bootcamp-tlz-account
  #this is the trusted policy into the role
  tags = var.tagging
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lab_role_iam_policy" {
  name     = "lab_role_iam_policy"
  role     = aws_iam_role.lab_role.id
  provider = aws.bootcamp-tlz-account 
  #this is the inline policy into the role
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Action": [
                "autoscaling:*",
                "cloudformation:*",
                "cloudshell:*",
                "cloudtrail:*",
                "cloudwatch:*",
                "dynamodb:*",
                "ec2:*",
                "ec2-instance-connect:Send*",
                "elasticbeanstalk:*",
                "elasticloadbalancing:*",
                "events:*",
                "lambda:*",
                "logs:*",
                "s3:*",
                "sns:*",
                "tag:*"
            ],
            "Resource": "*",
            "Effect": "Allow",
            "Sid": "AllowAllActions"
        }
  ]
}
EOF
}

resource "aws_lambda_function" "bootcamp_s3_dynamo_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  depends_on    = [aws_iam_role.lab_role]
  filename      = "../lambda-python-resources/lambda_function.zip"
  function_name = "educacionit_s3toDynamonCSVImport"
  role          = aws_iam_role.lab_role.arn
  handler       = "index.test"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("../lambda-python-resources/lambda_function.zip")
  tags = var.tagging
  runtime = "python3.9"

  # environment {
  #   variables = {
  #     foo = "bar"
  #   }
  # }
  provider = aws.bootcamp-tlz-account
}

#adding lambda permission to allow s3 invoke the lambda
resource "aws_lambda_permission" "allow_bucket_to_invokeLambda" {
  statement_id  = "AllowExecutionFromS3Bucket1"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.bootcamp_s3_dynamo_lambda.id
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.this_s3_bucket[0].arn
  provider = aws.bootcamp-tlz-account
}

# Adding S3 bucket as trigger to my lambda and giving the permissions
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
  bucket   = aws_s3_bucket.this_s3_bucket[0].id
  provider = aws.bootcamp-tlz-account
  lambda_function {
    lambda_function_arn = aws_lambda_function.bootcamp_s3_dynamo_lambda.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_suffix       = ".csv"
  }
}