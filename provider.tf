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
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region  = lookup(var.env, "AWS_REGION", "wrong_value")
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
} 
*/