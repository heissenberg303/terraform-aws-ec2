# New resources for Application Load Balancer
resource "aws_lb" "public" {
  name               = "tf-public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.TF_SG_NEW.id]
#   subnets            = ["subnet-0da989951c02c6842", "subnet-06178af2d600f7f52", "subnet-04b6bf5b4a49f69a8"]
  subnets = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  enable_deletion_protection = false

  tags = {
    Name = "TF_Public_LB"
  }
}

# --------------------- Target Group ------------------------------
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.backend.arn
  count = 2
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

resource "aws_lb_target_group" "backend" {
  name     = "tf-backend-tg"
  port     = 80
  protocol = "HTTP"
#   vpc_id   = "vpc-0513dc2f0f24b05b0"
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
