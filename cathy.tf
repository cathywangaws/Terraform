resource "aws_instance" "cathy"{
    ami = "ami-5b41123e"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-cathy"
    }
}