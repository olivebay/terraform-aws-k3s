resource "aws_instance" "master" {
  ami             = var.ami[var.aws_region]
  instance_type   = var.instance_type
  key_name        = aws_key_pair.mykeypair.key_name
  count           = var.count_masters
  security_groups = [aws_security_group.servers.id]
  subnet_id       = element(list(aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-public-3.id),count.index)
  tags = {
      Name = "k3s-master"
      role = "master"
  }
  depends_on = [aws_db_instance.mysql]

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.user[var.platform]
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${aws_db_instance.mysql.endpoint} > /tmp/mysql_endpoint",
      "echo ${aws_instance.master[0].private_ip} > /tmp/master-server-addr",
    ]
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/install-k3s.sh",
    ]
  }

   provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.PATH_TO_PRIVATE_KEY} ${var.user[var.platform]}@${aws_instance.master[count.index].public_ip}:/tmp/token data/token"
  }
}

resource "aws_instance" "worker" {
  ami             = var.ami[var.aws_region]
  instance_type   = var.instance_type
  key_name        = aws_key_pair.mykeypair.key_name
  count           = var.count_workers
  security_groups = [aws_security_group.servers.id]
  subnet_id       = element(list(aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-public-3.id),count.index)
  tags = {
      Name = "${format("worker-%01d", count.index + 1)}"
      role = "worker"
  }
   depends_on = [aws_db_instance.mysql]

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.user[var.platform]
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }

  provisioner "file" {
    source      = "${path.module}/data/token"
    destination = "/tmp/token"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${aws_instance.master[0].private_ip} > /tmp/master-server-addr",
    ]
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/join-cluster.sh",
    ]
  }
}

