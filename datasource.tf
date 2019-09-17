data "terraform_remote_state" "remote_state" {
  backend = "s3"

  config = {
    bucket   = "terraformmystate"
    region   = "ap-south-1"
    key      = "state_file/terraform.tfstate"
  }
}
