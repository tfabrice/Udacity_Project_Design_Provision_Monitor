# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAUVTDASA6L3CA5DXE"
  secret_key = "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"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami   = "ami-0230bd60aa48260c6"
  # ami = "ami-0fa1ca9559f1892ec"
  instance_type = "t2.micro"
  tags = {
    name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami   = "ami-0230bd60aa48260c6"
  # ami = "ami-0fa1ca9559f1892ec"
  instance_type = "m4.large"
  tags = {
    name = "Udacity M4"
  }
}