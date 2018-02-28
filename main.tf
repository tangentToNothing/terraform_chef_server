provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "chef_server" {
  instance_type = "t2.micro"
  ami           = "${data.aws_ami.ubuntu.id}"
  key_name      = "udacity"
  tags = "${var.Tags}"
  provisioner "remote-exec" {
    inline = [
          "apt-get update && apt-get install -y wget",
          "wget https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/14.04/chef-server-core_12.17.33-1_amd64.deb",
          "dpkg -i chef-server-core_12.17.33-1_amd64.deb",
          "chef-server-ctl reconfigure"
        ]
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file("${var.udacity_key}")}"
    }
  } 

}