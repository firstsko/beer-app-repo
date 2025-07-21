data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "common" {
  name        = var.security_group_name
  description = "Allow ingress on multiple ports"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      description = "Allow TCP on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidrs
    }
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
