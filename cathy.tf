resource "aws_instance" "HelloWorld"{
    ami = "ami-045f5e9c2833c8631"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.html
        nohup busybox httpd -f -p 8080 &
        EOF

    tags = {
        Name = "terraform-helloworld"
    }
}

resource "aws_security_group" "instance"{
    name = "terraform-helloworld-instance"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}