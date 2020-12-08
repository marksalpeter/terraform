# terraform is required so we know which version of the provider to use in the terraform registery
terraform {
  required_providers {
    # aws is the alias this provider will be mapped to. technically, this could reference anything in the registery
    aws = {
      source  = "hashicorp/aws" # registry.terraform.io/hashicorp/aws
      version = "~> 3.0"        # '~>' (aka the "pessimistic constraint operator") allows only the rightmost version number to increment (the patch and minor, but not the major version). eg. 3.9.9 might be used, but never 4.0.0.
    }
  }
}

# provider block configures the named provider, in this case "aws"
# note: it is possible to use multiple providers together in the same config file, eg. passing an id of an aws instance to datadog
provider "aws" {
  profile = "default" # default uses the config from the 'aws cli'. It's strongly reccomended to never store hard coded credentials in a terraform config file.
  region  = var.region
}

# resource blocks define a specific piece of infastructure (EC2, Heroku application, etc)
# @param resource_type is the type of the infrastructure defined. the prefix of this variable defines which provider it belongs to (in this case, the 'aws' provider)
# @param resource name is the name of the resource
resource "aws_instance" "example" {
  ami           = var.amis[var.region] # ami is the amazon machine image of the ec2 instance (in this case its a ubuntu instance)
  instance_type = "t2.micro"           # a free teir image
}

# output prints out information to the screen when `terraform apply` is called
output "ami" {
  value = aws_instance.example.ami # print the ami for the cooresponding region
}
