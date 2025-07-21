data "aws_vpc" "default" {
  default = true
}



data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  default_subnet_ids = data.aws_subnets.default.ids
}







