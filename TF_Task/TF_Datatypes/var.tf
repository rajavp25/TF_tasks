variable "num"{
type=number
default=8
}

variable "str"{
type=string
default="This is a string variable"
}

variable "boolean"{
type=bool
default=true
}

variable "alis"{
type=list(any)
default=[ 16 , "Raja" , false ]
}

variable "stringlist"{
type=list(string)
default= [ "field1" , "field2" , "field3" ]
}

variable "maps"{
type=map(string)
default={
test1= "raja"
test2= "rajavp"
}
}

variable "tupl"{
type= tuple([number , number])
default=[1,3000]
}

variable "obj"{
type =object ({
name=string
num1=number})
default={
name="dilli"
num1=3
}
}

