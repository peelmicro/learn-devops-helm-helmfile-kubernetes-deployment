# ************************
# vars.tf
# ************************




variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = "map"

  default = {
    # *******************************************
    # https://cloud-images.ubuntu.com/locator/ec2/
    #
    #   US East (N. Virginia) => us-east-1
    #   OS        => UBUNTU Xenial 16.04 LTS
    #   AMI_ID    => ami-04b8c2001b0bf0c27
    #
    #   AMI shortcut (AMAZON MACHINE IMAGE)
    #
    # *******************************************
    us-east-1 = "ami-04b8c2001b0bf0c27"
  }
}

# ************************
# provider.tf
# ************************
provider "aws" {
  shared_credentials_file = "/root/.aws"
  region     = "${var.AWS_REGION}"
}

# ************************
# instance.tf
# ************************
resource "aws_instance" "UDEMY_DEVOPSINUSE" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"

  tags {
    Name = "UDEMY"
  }

  instance_type = "a1.medium"

  provisioner "local-exec" {
    command = "echo ${aws_instance.UDEMY_DEVOPSINUSE.private_ip} >> private_ips.txt"
  }
}

output "ip" {
  value = "${aws_instance.UDEMY_DEVOPSINUSE.public_ip}"
}
