provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  version                  = "0.35"
}

resource "yandex_storage_bucket" "bucket_tfstate" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = var.bucket_name
}
