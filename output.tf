output "master_IPs" {
  value = aws_instance.master.*.public_ip
}

output "worker_IPs" {
  value = aws_instance.worker.*.public_ip
}

output "rds" {
  value = aws_db_instance.mysql.endpoint
}