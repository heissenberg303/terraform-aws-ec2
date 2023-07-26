resource "aws_instance" "web" {
  ami           = "ami-0df7a207adb9748c7"
  instance_type = "t2.micro"
  count = 1

  tags = {
    Name = "WebServer"
  }
}