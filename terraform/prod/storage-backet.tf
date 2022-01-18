terraform {



    


  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-for-otus"
    region     = "ru-centrall-a"
    key        = "terraform.tfstate"
    access_key = "OkOR6mBQuTz5rAR8ptQN"
    secret_key = "ZliTZhMJc_pEwsqz3gxwz8KbO9RZNZywN0c7RD4f"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
