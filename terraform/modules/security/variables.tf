variable "security_group_name" {
  type        = string
  description = "Name of the security group"
}

variable "ingress_ports" {
  type        = list(number)
  description = "List of ports to allow ingress"
  default     = [5000, 5432]
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "Allowed source CIDRs"
  default     = ["0.0.0.0/0"]
}
