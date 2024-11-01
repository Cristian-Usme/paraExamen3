terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.9.8"
}

provider "aws"{
    region = var.region
}

# Crea un grupo de seguridad para SSH y HTTP
resource "aws_security_group" "web" {
    name    = "examen_3"
    description = "Security group para permitir SSH y HTTP"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Crea una instancia de EC2
resource "aws_instance" "examen3"{
    ami             = "ami-0866a3c8686eaeeba"
    instance_type   = "t2.micro"
    security_groups  = [aws_security_group.web.name]

    tags = {
        Name = "Instancia_Examen3"
    }

    user_data = <<-EOF
                #!/bin/bash
                # Utiliza esto para tus datos de usuario
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "<h1>Hola Mundo desde $(hostname -f)</h1>" > /var/www/html/index.html
                EOF
}