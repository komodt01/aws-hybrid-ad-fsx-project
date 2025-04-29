provider "aws" {
  region = "us-east-1"
}

# Existing VPC and Subnets (from previous data blocks)
data "aws_vpc" "selected" {
  id = "vpc-048419934f19ab96f"
}

data "aws_subnet" "private1" {
  id = "subnet-0c632f83e076fdbf8"
}

data "aws_subnet" "private2" {
  id = "subnet-0b2729053cc414f7d"
}

data "aws_security_group" "fsx_ds_sg" {
  id = "sg-07ef50dc0fde98b4f"
}

# Create AWS Managed Microsoft AD
resource "aws_directory_service_directory" "ad" {
  name     = var.ad_domain_name
  password = var.ad_admin_password
  size     = "Standard"
  type     = "MicrosoftAD"
  vpc_settings {
    vpc_id     = data.aws_vpc.selected.id
    subnet_ids = [data.aws_subnet.private1.id, data.aws_subnet.private2.id]
  }
}

# Create FSx for Windows File Server
resource "aws_fsx_windows_file_system" "fsx" {
  subnet_ids         = [data.aws_subnet.private1.id, data.aws_subnet.private2.id]
  security_group_ids = [data.aws_security_group.fsx_ds_sg.id]
  storage_capacity   = 300
  throughput_capacity = 32
  preferred_subnet_id = data.aws_subnet.private1.id
  deployment_type    = "MULTI_AZ_1"
  storage_type       = "SSD"

  windows_configuration {
    active_directory_id               = aws_directory_service_directory.ad.id
    deployment_type                   = "MULTI_AZ_1"
    preferred_subnet_id               = data.aws_subnet.private1.id
    throughput_capacity               = 32
    weekly_maintenance_start_time     = "7:06:00"
    daily_automatic_backup_start_time = "05:00"
    automatic_backup_retention_days   = 7
  }

  depends_on = [aws_directory_service_directory.ad]
}