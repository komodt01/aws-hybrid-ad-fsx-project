# Create a Security Group for the Jumpbox
resource "aws_security_group" "jumpbox_sg" {
  name        = "jumpbox-sg"
  description = "Allow RDP access from a trusted IP"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "RDP from trusted IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jumpbox-sg"
  }
}

# Create the Jumpbox EC2 Instance
resource "aws_instance" "jumpbox" {
  ami                         = var.jumpbox_ami_id
  instance_type               = var.jumpbox_instance_type
  subnet_id                   = data.aws_subnet.private1.id
  vpc_security_group_ids      = [aws_security_group.jumpbox_sg.id]
  associate_public_ip_address = true

  key_name = var.jumpbox_key_pair

  tags = {
    Name = "Hybrid-AD-Jumpbox"
  }

  depends_on = [aws_directory_service_directory.ad]
}