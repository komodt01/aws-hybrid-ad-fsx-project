variable "ad_domain_name" {
  description = "Fully Qualified Domain Name for the Active Directory (e.g., corp.example.com)"
  type        = string
}

variable "ad_admin_password" {
  description = "Admin password for Active Directory (must meet AWS complexity requirements)"
  type        = string
  sensitive   = true
}variable "jumpbox_ami_id" {
  description = "AMI ID for Windows Server base image (e.g., Windows Server 2022)"
  type        = string
}

variable "jumpbox_instance_type" {
  description = "Instance type for the Jumpbox (e.g., t3.medium)"
  type        = string
}

variable "admin_cidr_block" {
  description = "CIDR block for trusted admin workstation IP (e.g., 203.0.113.5/32)"
  type        = string
}

variable "jumpbox_key_pair" {
  description = "Key Pair Name for SSH/RDP access to the Jumpbox"
  type        = string
}