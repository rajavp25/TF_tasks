variable "location" {
#default = "westus2"
}
variable "vnetname" {
#default = "TF_vnet2"
 }
variable "add_space" {
  default = ["10.3.0.0/16"]
  type    = list(string)
}
variable "sub_name" {
#  default = "TF_subnet2"
 }

variable "subspace" {
  default = ["10.3.0.0/24"]
  type    = list(string)
}

variable "nic" {
  default = "TF_NIC1"
}

variable "pubip" {
  default = "TF_Publicip2"
}

variable "az_uname" {
  default = "azureuser"
}
