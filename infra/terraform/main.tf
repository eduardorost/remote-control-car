provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "remote_control_car" {
  ami = "ami-0ab4d1e9cf9a1215a"
  instance_type = "t2.micro"
  user_data = "${file("user-data.sh")}"
  key_name = "remote_control_car"

  tags = {
    Name = "RemoteControlCarInstance"
  }

  provisioner "file" {
    source = "./../ansible/app.yaml"
    destination = "/home/ec2-user/app.yaml"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("./remote_control_car.pem")
      host = self.public_dns
    }
  }

  provisioner "file" {
    source = "/home/ilegra/.ssh/id_ed25519"
    destination = "/home/ec2-user/.ssh/id_rsa"

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("./remote_control_car.pem")
      host = self.public_dns
    }
  }
}

output "ec2-dns" {
    value = "${aws_instance.remote_control_car.public_dns}"
}