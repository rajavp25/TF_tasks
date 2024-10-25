
#variable declaration

variable l1{
#default variable declaration
type = bool
default =true

}

variable lengthofvar{
#default value of variable is not given will invoke through CLI
type = number

}

variable lenpwd{

type = number
default = 16

}

variable pwd{

default = "$imple"

}

variable count1{

type = number
default = 5

}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
     # version = "~> 3.0"
#version is declared through environment
    }
  }
}

provider "random" {
}

resource "random_string" "random" {
 
  length     = var.lengthofvar
  special          = var.l1
  override_special = "D!ll!"
}

resource "random_password" "password" {

#variable declaration using inline injection for length
  length           = var.lenpwd
  special          = true
  override_special = var.pwd
# override_special pwd will be declared through file based injection

}

resource "random_shuffle" "az" {

# injecting variables using terrafrom.tfvars and auto.tfvars file

  input        = ["var.vshuffle1", "var.vshuffle2", "var.vashuffle3", "us-west-1e"]
  result_count = var.count1
#count1 variable declared using environment variable

}





