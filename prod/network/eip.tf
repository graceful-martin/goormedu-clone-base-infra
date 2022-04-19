############################################################################
# Elastic IP for NAT Gateway
############################################################################

resource "aws_eip" "eip" {
  vpc = true
  tags = { Name = "eip" }
}