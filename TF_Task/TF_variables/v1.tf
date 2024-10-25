variable "a1" {
  default = "a1.txt"
  type    = string
}
variable "a2" {
  default = " Hello, this is a task to show variable injection by using default value "
}

variable "a3" {

default ="a3.txt"
type =string
}

variable "a4" {

 default = " Hello, This is to show variable injection using interactive mode" 

}


resource "local_file" "f1" {

  filename = var.a1
  content  = var.a2

}

resource "local_file" "f2"{

filename = var.a3
content = var.a4

}

