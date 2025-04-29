# Final terraform.tfvars for Hybrid AD + FSx + Jumpbox

# Active Directory Domain Name
ad_domain_name = "corp.adhybrid.com"

# Admin password for AD (use a strong one!)
ad_admin_password = "F0x!T@ngo123"

# AMI ID for Windows Server 2022 Base (you should double-check this in your region)
jumpbox_ami_id = "ami-0c798d4b81e585f36"

# Instance type for Jumpbox
jumpbox_instance_type = "t3.medium"

# Your admin workstation's public IP (with /32 restriction)
admin_cidr_block = "73.243.168.48/32"

# Existing Key Pair Name in AWS (needed for RDP login)
jumpbox_key_pair = "Jump-Box"
