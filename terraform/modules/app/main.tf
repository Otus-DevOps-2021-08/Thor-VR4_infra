resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  count = var.app_servers_count

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
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
  provisioner "file" {
    source      = "${path.module}/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    inline = [
      "echo DATABASE_URL=${var.db_url} > ~/database.conf"
    ]
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }

}
