##################################################################################
# VARIABLES
##################################################################################

# variable "aws_access_key" {}
# variable "aws_secret_key" {}
# variable "private_key_path" {}

# variable "key_name" {
#   default = "PluralsightKeys"
# }

variable "network_address_space" {
  default = "10.1.0.0/16"
}

variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}

variable "subnet2_address_space" {
  default = "10.1.1.0/24"
}

variable "trusted_networks" {
  default = "190.240.66.234/32"
}

variable "aws_access_key" {
  default = "AKIAJL2FP2VFK5RH4KDQ"
}

variable "aws_secret_key" {
  default = "60pOUqScy1QlKI4r2U+eFz0Lc+sLM/ias3Ubl6YE"
}
