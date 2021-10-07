terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "terraform-state-4444"
    region                      = "us-east-1"
    key                         = "prod/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
