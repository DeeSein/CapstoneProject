locals {
  # The name of the EC2 instance
  name = "awsrestartproject"
  owner = "david"
}

### Select the newest AMI

data "aws_ami" "latest_linux_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}


### Create an EC2 instance

resource "aws_instance" "instance" {
  ami                         = data.aws_ami.latest_linux_ami.id
  #ami = var.AMIs[var.AWS_REGION]
  instance_type               = "t2.micro"
  availability_zone           = "us-west-2a"
  associate_public_ip_address = true
  key_name                    = "vockey"
  vpc_security_group_ids      = [aws_security_group.sg_vpc.id]
  subnet_id                   = aws_subnet.public-1.id
  #iam_instance_profile        = "deham14_ec2"
  count = 1
  tags = {
    Name = "EC2-DEHAM14"
  }
  user_data = file("userdata.tpl")
  #user_data = "${base64encode(data.template_file.ec2userdatatemplate.rendered)}"

  provisioner "local-exec" {
    command = "echo Instance Type = ${self.instance_type}, Instance ID = ${self.id}, Public IP = ${self.public_ip}, AMI ID = ${self.ami} >> metadata"
  }
}


data "template_file" "ec2userdatatemplate" {
  template = "${file("userdata.tpl")}"
}

output "ec2rendered" {
  value = "${data.template_file.ec2userdatatemplate.rendered}"
}

output "public_ip" {
  value = aws_instance.instance[0].public_ip
}  

/* #create an security group
resource "aws_security_group" "sg_vpc" {
  name        = "sg_vpc"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_vpc"
  }
} */