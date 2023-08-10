# New resources for Application Load Balancer
resource "aws_lb" "public" {
  name               = "tf-public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public.id]
  subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

  tags = {
    Name = "Public_LB"
  }
}

# --------------------- Target Group ------------------------------
resource "aws_lb_target_group_attachment" "webservers" {
  target_group_arn = aws_lb_target_group.backend.arn
  count = 2
  target_id        = aws_instance.webserver[count.index].id
  port             = 80
}

resource "aws_lb_target_group" "backend" {
  name     = "tf-backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
}

resource "aws_lb_listener" "forward" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}
