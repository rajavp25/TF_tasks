resource "local_file" "project2" {

  filename = "testfile.txt"
  content  = " This is my first terraform project"

}
resource "local_file" "project3" {

  filename = "testfile.txt"
  content  = " This is my first terraform project and need to check the validate cmd"

}
