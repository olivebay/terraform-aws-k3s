# data "template_file" "master-script" {
#   template = file("scripts/install-k3s.sh")
#   count = var.masters
#   vars = {
#     MYSQL_RDS_ENDPOINT = aws_db_instance.mysql.endpoint
#     MASTER_PRIVATE_IP = aws_instance.master[count.index].private_ip
#   }

# }

# output "rendered_templated" {
#   value = data.template_file.master-script.*.rendered
# }

