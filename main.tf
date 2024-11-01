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
              sudo apt update
              sudo apt install -y docker.io git

              # Se clona mi repositorio
              git clone https://github.com/Cristian-Usme/paraExamen3 /home/ubuntu/app

              # Cambia al directorio de la app y construye la imagen Docker
              cd /home/ubuntu/app
              sudo docker build -t servicio_telematico .

              # Ejecuta el contenedor en el puerto 80
              sudo docker run -d -p 80:80 servicio_telematico
              EOF
}