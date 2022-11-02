// ssh keypair

resource "aws_key_pair" "ssh-key" {
  key_name   = var.keyname
  public_key = file(var.pathpublickey)
  provider   = aws.bootcamp-tlz-account
}


