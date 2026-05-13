# Nginx server
resource "aws_instance" "nginx_server" {
  subnet_id = aws_subnet.public_subnet.id
  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.nginx_sg.id ]
  associate_public_ip_address = true
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt install nginx -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "nginx_server"
  }
}