provider "aws" {
    region = "us-east-1"
}

variable "subnet_cidr_block" {

}

variable "vpc_cidr_block" {
    description = "vpc cidr block"
}

variable "zone" {}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "dev-vpc",
        vpc_env: "dev"
    }
}

resource "aws_subnet" "dev-subnet" {
    vpc_id = aws_vpc.dev-vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.zone
    tags = {
        Name: "dev-subnet"
    }
}

data "aws_vpc" "my-vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.my-vpc.id
    cidr_block = "172.31.96.0/20"
    availability_zone = var.zone
    tags = {
        Name: "dev-subnet-2"
    }
}

output "default-vpc-id" {
    value = data.aws_vpc.my-vpc.id
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}
