# terraform plan -var-file="env.tfvars"
# terraform apply -var-file="env.tfvars"
# terraform apply -var="env={ GOOGLE_CLIENT_ID="523715127618-k8p4h0cs8roqb5ag74te4puu3ubr8l28.apps.googleusercontent.com", GOOGLE_SECRET ="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", JWT_PRIVATEKEY="MySecretKey1$1$234", DB_HOST="goormedu-test-db.cf99rqo7hwfv.ap-northeast-2.rds.amazonaws.com", DB_PORT="3306", DB_USERNAME="admin", DB_PASSWORD="ZVHLS3RKaQpkWY74xNVN", DB_DATABASE="test", PORT="4000", DOMAIN="api.goormedu-clone.com", CLIENT_DOMAIN="http://goormedu-clone.com", AWS_REGION="ap-northeast-2", AWS_S3="back-test-bucket", AWS_CLIENT_ID="AKIA34COWLMOKZ6RABGD", AWS_SECRET="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", SENTRY_DSN="https://c9925687ea754f8e864b42070bc71aa0@o1202267.ingest.sentry.io/6327291" }"

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
    source = "./global/network"
}

/* SSM KEY GEN
module "security" {
    source = "./global/security"
    ssm-env = var.env
} */

module "prod-backend" {
    source = "./prod/backend"
}