resource "aws_instance" "webserver" {
  ami           = "ami-0df7a207adb9748c7" #ubuntu
  instance_type = "t2.micro"
  count = 2
   associate_public_ip_address = true

    # Authorise
  vpc_security_group_ids = [aws_security_group.public.id]
  subnet_id              = count.index == 0 ? aws_subnet.subnet1.id : aws_subnet.subnet2.id
  key_name = "tf-webserver" #ssh

    # Bootstrap
  user_data = file("script.sh")

  tags = {
    Name = "WebServer ${count.index}"
  }
}

# security group using Terraform
resource "aws_security_group" "public" {
  name        = "security group using Terraform"
  description = "allow all rules fron anywhere"
  vpc_id = aws_vpc.main.id

  lifecycle {
    create_before_destroy = true 
  }

    # inbound rules
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


    # outbound rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # all traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
}