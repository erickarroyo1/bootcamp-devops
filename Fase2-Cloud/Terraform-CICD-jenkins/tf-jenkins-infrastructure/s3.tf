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

#kms key for bucket encryption

resource "aws_kms_key" "tf-security-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  tags = {
    Name      = "kms-bootcamp-testing-2022"
    Terraform = "True"
    Owner     = "Erick Arroyo - Cybersecurity"
  }
  #define provider
  provider = aws.bootcamp-tlz-account
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.this_s3_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tf-security-key.arn
      sse_algorithm     = "aws:kms"
    }
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


#S3 bucket Policy

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid = "1"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket-name}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        aws_cloudfront_origin_access_identity.s3_origin_access.iam_arn,
      ]
    }
  }
  provider = aws.bootcamp-tlz-account
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket   = aws_s3_bucket.this_s3_bucket.id
  policy   = data.aws_iam_policy_document.s3_bucket_policy.json
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


