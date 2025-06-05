resource "aws_security_group" "sg_frontend" {
  vpc_id = var.vpc_id_for_vm

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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
    Name = "${var.sg_name}-frontend"
  }

}

resource "aws_security_group" "sg_backend" {
  vpc_id = var.vpc_id_for_vm
  ingress {
    description     = "Allow from frontend"
    from_port       = 8081
    to_port         = 8081
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_frontend.id]
  }

  ingress {
    description     = "SSH from frontend"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.sg_name}-backend"
  }

}

resource "aws_instance" "vm_frontend" {

  ami                    = var.ami_image
  instance_type          = var.vm_type
  subnet_id              = var.public_subnet[0]
  vpc_security_group_ids = [aws_security_group.sg_frontend.id]
  iam_instance_profile = var.instance_profile_ec2_ecr
  key_name               = "my-keypair"

  tags = {
    Name = "${var.vm_name}-frontend"
  }

}

resource "aws_instance" "vm_backend" {

  ami                    = var.ami_image
  instance_type          = var.vm_type
  subnet_id              = var.private_subnet[0]
  vpc_security_group_ids = [aws_security_group.sg_backend.id]
  iam_instance_profile = var.instance_profile_ec2_ecr
  key_name               = "my-keypair"
  tags = {
    Name = "${var.vm_name}-backend"
  }

}
