terraform {
  backend "s3" {
    bucket       = "ticket-api-terraform-bucket"
    key          = "global/s3/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}