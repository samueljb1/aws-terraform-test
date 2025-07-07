provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "prueba_tecnica_aws" {
  key_name   = "prueba-tecnica-aws"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBffZud7hwdKaBxBQxV/ZYfJ150wwCRvx+bM84DyJkxi0J2l2WpYydSmVSFNCctEXkYLvHoiYrc8/mrq5whixtF6igJEtxOmA5+quzf+HpmptlerAZr2IVJJdpH+WL5lhf6EYgEl9AMDQnohNa4o/RPE4OqN5FF4VGluHiG6U7BxPj47sMcT06q252dRiZjEOi+IO0htLMdBlfox3KoavMf/YwfG/shVzs6Hj58743U3qBkb63UcVIB/HBGN/bm/qxSXWz/3uySHbWP5GGY33v11VJqmZUn1SvVVReIcCZyhQwzHvQuLv0BKK6axuZirjIjUD/dc6b0+CufHcuoHuV/XVitDus90E4/wqMoImz6scy7qHTWjfIGvO6FUAKbz9lCf3+oEUN22rCcDr+CooGdTCUKXrbwclFQQmrh9XZZll0yF9XaZV8e4XA4ihsb80LZs+5LzD1Aa3C6WqxUbndgkLz61iTGgaOm63i/kJ/JHrvvxd/N1HheYWf3ezqc0G7JMAVU+s62OGoYJBEVUuoDp0Pq6Yk9o1XbacnpOsQ7oewTQ30x8Zq8zfkPkpzd+AKSRT8bPe93UBvc5dHRo3RntuzVKfhOTqZ6wUG4Tt4wyd/fhb2V1ioFXQvwYDz1cCU3Bo065Asdo/pSW9QLffgt8GxFGh1JYd5fj/57YHEYQ== samuel blanco@DESKTOP-57L1A2A"
}

resource "aws_security_group" "ssh_access" {
  name_prefix = "ssh-access-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.93.173.53/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.prueba_tecnica_aws.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "prueba-tecnica-aws-ec2"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "prueba-tecnica-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t3.micro"
  db_name                 = "pruebatecnica"
  username                = "postgreuser"
  password                = "PruebaTecAWS!2025"
  publicly_accessible     = true
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.ssh_access.id]
}
