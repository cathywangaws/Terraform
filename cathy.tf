resource "aws_instance" "HelloWorld"{
    ami = "ami-045f5e9c2833c8631"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.html
        nohup busybox httpd -f -p ${var.server_port} &
        EOF

    tags = {
        Name = "terraform-helloworld"
    }
}

resource "aws_security_group" "instance"{
    name = "terraform-helloworld-instance"

    ingress {
        from_port = var.server_port
        to_port = var.server_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

variable "server_port" {
    description = "The port the server will use for HTTP requests. If no default value, Terraform will prompt you to enter a value."
    type = number
    default = 8080
}

output "public_ip"{
    value = aws_instance.HelloWorld.public_ip
    description = "The public IP address of the web server"
}