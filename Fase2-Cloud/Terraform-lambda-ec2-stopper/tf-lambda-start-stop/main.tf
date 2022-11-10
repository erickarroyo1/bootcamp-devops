#Reource s3 bucket

resource "aws_s3_bucket" "lambda_functions_bootcamp_erick" {
  bucket = var.bucket-name
  # Enable versioning so we can see the full revision history of our
  # state files
  tags = var.tagging
  #define provider
  provider = aws.bootcamp-tlz-account
}

#enable versioning for s3
resource "aws_s3_bucket_versioning" "tf-security-s3-versioning" {
  depends_on = [aws_s3_bucket.lambda_functions_bootcamp_erick]
  bucket = var.bucket-name
  versioning_configuration {
    status = "Enabled"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

#S3 Bucket ACL

resource "aws_s3_bucket_acl" "b_acl" {
  depends_on = [aws_s3_bucket.lambda_functions_bootcamp_erick]
  bucket   = var.bucket-name
  acl      = "private"
  provider = aws.bootcamp-tlz-account
}

#s3 Objects into buckets

resource "aws_s3_object" "lambda_start_ec2" {
  depends_on = [aws_s3_bucket.lambda_functions_bootcamp_erick]
  bucket = var.bucket-name
  key    = "start_ec2.zip"
  source = "../lambda-python-ec2_resources/start_ec2.zip"
  provider = aws.bootcamp-tlz-account
}

resource "aws_s3_object" "lambda_stop_ec2" {
  depends_on = [aws_s3_bucket.lambda_functions_bootcamp_erick]
  bucket = var.bucket-name
  key    = "stop_ec2.zip"
  source = "../lambda-python-ec2_resources/stop_ec2.zip"
  provider = aws.bootcamp-tlz-account
}

#Lambda Bootcamp

resource "aws_iam_role" "lab_role_start_stop_ec2" {
  name     = "lab_role_start_stop_ec2"
  provider = aws.bootcamp-tlz-account
  #this is the trusted policy into the role
  tags               = var.tagging
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
  role     = aws_iam_role.lab_role_start_stop_ec2.id
  provider = aws.bootcamp-tlz-account
  #this is the inline policy into the role
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow", 
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Start*",
        "ec2:Stop*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

#Lambda ec2_start Bootcamp

resource "aws_lambda_function" "ec2_start_lambda" {
  depends_on = [aws_iam_role.lab_role_start_stop_ec2, aws_s3_object.lambda_start_ec2]
  s3_bucket  = var.bucket-name
  s3_key     = "start_ec2.zip"
  function_name = "start_ec2"
  role          = aws_iam_role.lab_role_start_stop_ec2.arn
  handler       = "start_ec2.lambda_handler"
  source_code_hash = filebase64sha256("../lambda-python-ec2_resources/start_ec2.zip")
  tags             = var.tagging
  runtime          = "python3.9"
  provider = aws.bootcamp-tlz-account
}


#Lambda ece_stop Bootcamp

resource "aws_lambda_function" "ec2_stop_lambda" {
  depends_on = [aws_iam_role.lab_role_start_stop_ec2, aws_s3_object.lambda_stop_ec2]
  s3_bucket  = var.bucket-name
  s3_key     = "stop_ec2.zip"
  function_name = "stop_ec2"
  role          = aws_iam_role.lab_role_start_stop_ec2.arn
  handler       = "stop_ec2.lambda_handler"
  source_code_hash = filebase64sha256("../lambda-python-ec2_resources/stop_ec2.zip")
  tags             = var.tagging
  runtime          = "python3.9"
  provider = aws.bootcamp-tlz-account
}

# #adding lambda permission to allow s3 invoke the lambda
# resource "aws_lambda_permission" "allow_bucket_to_invokeLambda" {
#   statement_id  = "AllowExecutionFromS3Bucket1"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.bootcamp_s3_dynamo_lambda.id
#   principal     = "s3.amazonaws.com"
#   source_arn    = aws_s3_bucket.this_s3_bucket[0].arn
#   provider      = aws.bootcamp-tlz-account
# }

# Event rule to start instances

resource "aws_cloudwatch_event_rule" "start_instances" {
  name        = "start_ec2_instances"
  description = "start_ec2_instances"
  schedule_expression = "cron(0 12 ? * MON-FRI *)"
  provider = aws.bootcamp-tlz-account
}

resource "aws_cloudwatch_event_target" "lambda_start_instances" {
  rule      = aws_cloudwatch_event_rule.start_instances.name
  target_id = "ec2_start_schedulle"
  arn       = aws_lambda_function.ec2_start_lambda.arn
  provider = aws.bootcamp-tlz-account
}


resource "aws_cloudwatch_event_rule" "stop_instances" {
  name                = "stop_ec2_instances"
  description         = "stop_ec2_instances nightly"
  schedule_expression = "cron(0 0 * * ? *)"
  provider = aws.bootcamp-tlz-account
}

resource "aws_cloudwatch_event_target" "lambda_stop_instances" {
  rule      = aws_cloudwatch_event_rule.stop_instances.name
  target_id = "ec2_stop_schedulle"
  arn       = aws_lambda_function.ec2_stop_lambda.arn
  provider = aws.bootcamp-tlz-account
}