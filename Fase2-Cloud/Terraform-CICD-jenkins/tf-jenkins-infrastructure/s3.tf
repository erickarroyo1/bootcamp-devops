#remote state s3 bucket

resource "aws_s3_bucket" "this_s3_bucket" {
  bucket = var.bucket-name
  # Enable versioning so we can see the full revision history of our
  # state files

  tags = {
    Name      = "S3-Bootcamp-Testing-erick-2022"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

#enable versioning
resource "aws_s3_bucket_versioning" "tf-security-s3-versioning" {
  bucket = aws_s3_bucket.this_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

#S3 Bucket ACL

resource "aws_s3_bucket_acl" "b_acl" {
  bucket   = aws_s3_bucket.this_s3_bucket.id
  acl      = "private"
  provider = aws.bootcamp-tlz-account
}

data "aws_iam_policy_document" "s3_policy" {
  version = "2008-10-17"

  statement {
    sid       = "AllowCloudFrontServicePrincipal"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this_s3_bucket.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${aws_cloudfront_distribution.s3_distribution.arn}"]
    }
  }
  provider = aws.bootcamp-tlz-account
}

resource "aws_s3_bucket_policy" "mybucket" {
  bucket   = aws_s3_bucket.this_s3_bucket.id
  policy   = data.aws_iam_policy_document.s3_policy.json
  provider = aws.bootcamp-tlz-account
}

resource "aws_s3_bucket_public_access_block" "mybucket" {
  bucket = aws_s3_bucket.this_s3_bucket.id

  block_public_acls   = true
  block_public_policy = true
  //ignore_public_acls      = true
  //restrict_public_buckets = true
  provider = aws.bootcamp-tlz-account
}

resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.this_s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  provider = aws.bootcamp-tlz-account
}


