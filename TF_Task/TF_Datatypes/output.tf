output "randid"{

value =random_id.server.id
}


output "ranint"{
value= random_integer.priority.result

}

output "ranpas"{
value =random_password.password.result
sensitive=true
}

output "ranpet" {
value=random_pet.server.id

}

output "ranshuff" {
value= random_shuffle.az.result
}

output "ranstring" {
value = random_string.random.result

}
