terraform {
  backend "s3" {
    bucket       = var.s3_remote_bucket
    key          = "global/s3/terraform.tfstate"
    region       = var.region
    encrypt      = true
    use_lockfile = true
  }
}