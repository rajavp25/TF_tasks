resource "random_id" "server" {
byte_length =var.num
}

resource "random_integer" "priority"{
min=var.tupl[0]
max=var.tupl[1]
}

resource "random_password" "password" {
length =var.alis[0]
special=var.boolean
override_special="Simple@!23"
}

resource "random_pet" "server"{
length=var.obj.num1
prefix=var.maps["test1"]
}

resource "random_shuffle" "az"{
input =[var.maps.test1,var.maps.test2,var.stringlist[0],var.stringlist[1],var.stringlist[2],var.obj.name]
result_count=var.tupl[0]
}

resource "random_string" "random"{
length=var.alis[0]
special=var.alis[2]
override_special="D!illi"
}
