provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  version                  = "0.35"
}

module "app" {
  source            = "../modules/app"
  public_key_path   = var.public_key_path
  app_disk_image    = var.app_disk_image
  subnet_id         = module.vpc.subnet_id
  app_servers_count = var.app_servers_count
  ssh_key_path      = var.ssh_key_path
  db_url            = module.db.local_ip_address_db
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.subnet_id
  ssh_key_path    = var.ssh_key_path
}

module "vpc" {
  source          = "../modules/vpc"
  network_id       = var.network_id
}
