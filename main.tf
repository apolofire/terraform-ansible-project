provider "aws" {
  region     = "us-east-1" # ajuste conforme a região desejada
}
resource "aws_instance" "windows_vm" {
  ami           = "ami-073e3b46f8802d31b"  # AMI do Windows Server 
  instance_type = "t2.micro"  # Tipo de instância gratuito na AWS

  tags = {
    Name = "Windows-IIS"
  }

  key_name = "my-key-pair1"  # Substitua pelo nome do seu par de chaves

  vpc_security_group_ids = [aws_security_group.allow_winrm_rdp.id]
}

resource "aws_security_group" "allow_winrm_rdp" {
  name        = "allow_winrm_rdp"
  description = "Allow WinRM and RDP"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5986
    to_port     = 5986
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

