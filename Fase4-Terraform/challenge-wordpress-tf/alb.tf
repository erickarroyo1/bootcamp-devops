#load balancer

resource "aws_lb" "alb" {
    load_balancer_type = "application"
    name = "${var.app}-alb"
    security_groups = [ aws_security_group.alb.id ]
    subnets = [ module.vpc.public_subnets[0], module.vpc.public_subnets[1] ]
    tags = local.common_tags
}

resource "aws_lb_target_group" "tg" {
    name = "${var.app}-tg"
    port = 80
    vpc_id = module.vpc.vpc_id
    protocol = "HTTP"

    health_check {
      enabled = true
      port = 80
      path = "/"
      protocol = "HTTP"
      matcher = "200-399"
    } 
}

# attachement para el servidor 1

resource "aws_lb_target_group_attachment" "server1" {
    target_group_arn = aws_lb_target_group.tg.arn
    target_id = aws_instance.wp_server.id
    port = 80
}


#listener para el alb
resource "aws_lb_listener" "listen" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80

    default_action {
      target_group_arn = aws_lb_target_group.tg.arn
      type = "forward"
    }
  
}