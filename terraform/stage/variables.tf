variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key .json"
}
variable ssh_key_path {
  # Описание переменной
  description = "Path to the key used for ssh access"
}
variable app_servers_count {
  description = "How many instances we need"
}
variable network_id {
  description = "Default network"
}
variable app_disk_image {
  description = "App disk image"
}
variable db_disk_image {
  description = "DB disk image"
}
variable db_servers_count {
  description = "How many instances we need"
}
variable enviroment {
  description = "Enviroment"
}
