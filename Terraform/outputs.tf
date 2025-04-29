output "ad_directory_id" {
  value = aws_directory_service_directory.ad.id
}

output "fsx_file_system_id" {
  value = aws_fsx_windows_file_system.fsx.id
}output "jumpbox_public_ip" {
  value = aws_instance.jumpbox.public_ip
}

output "jumpbox_instance_id" {
  value = aws_instance.jumpbox.id
}