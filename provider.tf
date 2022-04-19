# terraform plan -var-file="env.tfvars"
# terraform apply -var-file="env.tfvars"

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.10.0" # >= 4.10.0, < 4.10.1
        }
    }

    required_version = ">= 1.1"
}

provider "aws" {
    profile = "default"
    region  = "ap-northeast-2"
}

variable "env" { 
    type = map(string)
}

module "network" {
    source = "./prod/network"
}

/* SSM KEY GEN
module "security" {
    source = "./prod/security"
    ssm-env = var.env
} */