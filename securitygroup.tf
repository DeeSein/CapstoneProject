#set up security groups 
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = allow_ssh
  }
}

#set up security group ingress for http
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = allow_http
  }
}

#set up security group ingress for https
resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "Allow HTTPS inbound traffic"
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = allow_https
  }
}

#set up security group ingress for mysql
resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow MySQL inbound traffic"
  ingress {
    description = "Allow MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = allow_mysql
  }
}

