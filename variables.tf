variable "region" {
  default = "us-east-1"
}
variable "bucket_name" {
    type = string
  default = "my-unqiue-cv-bucket-1634"
}
variable "tags" {
    type = map(string)
  default = {
    Project     = "MyCV"
    managed_by  = "terraform"
  }
}