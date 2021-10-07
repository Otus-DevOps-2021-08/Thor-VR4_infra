variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable subnet_id {
description = "Subnets for modules"
}
variable app_servers_count {
  description = "How many instances we need"
}
variable ssh_key_path {
  # Описание переменной
  description = "Path to the key used for ssh access"
}
variable db_url {
  # Описание переменной
  description = "DB address"
}
