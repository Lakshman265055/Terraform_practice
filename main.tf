resource "aws_security_group" "ec2_sg" {
  name = "ec2-sg"

  ingress {
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
}
resource "aws_instance" "ec2_instance" {
  ami                    = data.aws_ami.redhat9_devops.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

#   user_data = <<-EOF
#     #!/bin/bash
#     yum update -y
#     yum install -y nginx
#     systemctl start nginx
#     systemctl enable nginx
#   EOF
user_data = file("userdata.sh")

  tags = {
    Name = var.instance_name
  }
}