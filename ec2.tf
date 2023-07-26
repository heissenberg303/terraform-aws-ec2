resource "aws_instance" "web" {
  ami           = "ami-0df7a207adb9748c7"
  instance_type = "t2.micro"
  count = 1

    # Authorise
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  key_name = "tf-webserver" #ssh

    # Bootstrap
  user_data = file("script.sh")

  tags = {
    Name = "WebServer"
  }
}

# security group using Terraform
resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-0513dc2f0f24b05b0"

  lifecycle {
    create_before_destroy = true 
  }

    # inbound rules
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Anywhere
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Anywhere
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # Anywhere
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