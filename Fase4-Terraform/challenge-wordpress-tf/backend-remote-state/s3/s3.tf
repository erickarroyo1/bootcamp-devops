resource "aws_s3_bucket" "terraform_bucket_state" {
  bucket = "${var.app}-bucket-state"
  versioning {
    enabled = true
  }
  tags = {
    Name = "${var.app}-bucket-state"
  }
}

resource "aws_s3_bucket_acl" "terraform_bucket_acl" {
    bucket = aws_s3_bucket.terraform_bucket_state.id
    acl = "private"
}