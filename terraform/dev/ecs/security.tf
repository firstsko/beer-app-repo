data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ecs_http_5000" {
  name        = "ecs-http-5000"
  description = "Allow inbound HTTP traffic on port 5000"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP on port 5000"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

