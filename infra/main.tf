resource "aws_vpc" "smoke_test" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-cloud-smoke-test"
  }
}