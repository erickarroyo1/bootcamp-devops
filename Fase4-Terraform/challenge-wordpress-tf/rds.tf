resource "aws_db_subnet_group" "sub" {
    name = "${var.app}-subnet-group"
    subnet_ids = [ module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
}

resource "aws_db_instance" "wordpressdb" {
    allocated_storage           = 20
    engine                      = "mysql"
    engine_version              = "5.7"
    db_name                     = var.db_name
    username                    = var.db_user
    password                    = var.db_pass
    skip_final_snapshot         = true
    vpc_security_group_ids      = ["${aws_security_group.privada.id}"]
    db_subnet_group_name        = aws_db_subnet_group.sub.name
    instance_class              = var.instance_class

    tags = local.common_tags
}

