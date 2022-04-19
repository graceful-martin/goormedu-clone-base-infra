############################################################################
# VPC
############################################################################

resource "aws_vpc" "vpc" {
  cidr_block = "172.26.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "goormedu-clone-vpc" }
}