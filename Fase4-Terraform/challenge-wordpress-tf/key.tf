resource "aws_key_pair" "server_key" {
    key_name = "${var.app}-key"
    public_key = file("keys/aws_terraform.pub")
}