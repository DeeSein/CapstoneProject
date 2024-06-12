# create a Terraform configureation for ELB
resource "aws_lb_target_group" "target-group" { 
    name     = "target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.dev_vpc.id
    tags = {
        Name = "target-group"
    }
  
    health_check {
        enabled             = true
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 5
        interval            = 10
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
    }
}

# create a application load balancer
resource "aws_lb" "load-balancer" {
    name               = "load-balancer"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.sg_vpc.id]
    subnets            = [aws_subnet.public-1.id,aws_subnet.public-2.id]
    ip_address_type = "ipv4"
    tags = {
        Name = "load-balancer"
    }
}

# create a listener for load balancer
resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.load-balancer.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.target-group.arn
    }
}

# create a target group for load balancer
resource "aws_lb_target_group_attachment" "target-group-attachment" {
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = aws_instance.instance[count.index].id
    count = length(aws_instance.instance)
}