resource "yandex_compute_instance" "db" {
  name = "reddit-db"

  count = var.db_servers_count

  labels = {
    tags = "${var.env}-reddit-db"
  }

  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = true
  }

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.ssh_key_path)
  }

  /*
  provisioner "file" {
    source      = "${path.module}/files/mongod.conf"
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/mongod.conf /etc/",
      "sudo systemctl restart mongod"
    ]
  }
  */

}
