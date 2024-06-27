# Set up security group for SSH access
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow-ssh-"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description     = "Allow SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "allow-ssh"
  }
}

# Set up security group for HTTP access
resource "aws_security_group" "allow_http" {
  name_prefix = "allow-http-"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description     = "Allow HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-http"
  }
}

# Set up security group for HTTPS access
resource "aws_security_group" "allow_https" {
  name_prefix = "allow-https-"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description     = "Allow HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-https"
  }
}

# Set up security group for MySQL access
resource "aws_security_group" "allow_mysql" {
  name_prefix = "allow-mysql-"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    description     = "Allow MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-mysql"
  }
}