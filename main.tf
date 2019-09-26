# In this example, we are using the fakeserver available with this provider
# to create and manage imaginary users in our imaginary API server
# https://github.com/Mastercard/terraform-provider-restapi/tree/master/fakeserver

# To use this example fully, start up fakeserver and run this command
# curl 127.0.0.1:8080/api/objects -X POST -d '{ "id": "8877", "first": "John", "last": "Doe" }'
#
# After running terraform apply, you will now see three objects in the API server:
# curl 127.0.0.1:8080/api/objects | jq
provider "aws" {}
terraform {
  backend "s3" {
    bucket  = "terraformmystate"
    key     = "state_file/terraform.tfstate"
    encrypt = "true"
    region  = "ap-south-1"
  }
}

provider "restapi" {
  uri                  = "http://127.0.0.1:8080/"
  debug                = true
  write_returns_object = true
}


# This will ADD the user named "Foo" as a managed resource
resource "restapi_object" "Mso_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/mso"
  data = "{ \"id\": \"${var.mso_ref_id}\", \"name\": \"mso_mm\"}"
}
resource "restapi_object" "Locality_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/locality"
  data = "{ \"id\": \"2\", \"name\": \"locality_change\"}"
}
resource "restapi_object" "Channel_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/channel"
  data = "{ \"id\":  \"${var.chn_ref_id}\", \"name\": \"channel\"}"
}
resource "restapi_object" "Mso_locality_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/mso_locality"
  data = "{ \"id\": \"${var.Mso_locality_ref_id}\", \"name\": \"mso_locality\", \"mso_ref_id\": \"${var.mso_ref_id}\"}"
}
resource "restapi_object" "Packaged_service_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/packaged_service"
  data = "{ \"id\":  \"${var.pack_ser_ref_id}\", \"name\": \"packaged_service\", \"channel_num\": \"${var.chn_ref_id}\" , \"Mso_locality_ref_id\": \"${var.Mso_locality_ref_id}\"}"
}
resource "restapi_object" "Linearpackagecategories_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/linearpackagecategories"
  data = "{ \"id\": \"${var.linear_cat_ref_id}\", \"name\": \"linearpackagecategories\"}"
}
resource "restapi_object" "LinearpackageServices_object" {
  path = "/TiVorestapi.TiVo.com/lineartv/linearpackageServices"
  data = "{ \"id\": \"7\", \"name\": \"linearpackageServices\", \"linear_cat_ref_id\": \"${var.linear_cat_ref_id}\", \"pack_ser_ref_id\": \"${var.pack_ser_ref_id}\"}"
}
