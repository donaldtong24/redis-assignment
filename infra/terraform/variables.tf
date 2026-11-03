variable "enable_nat_gateway" {
  description = "Create one NAT Gateway for private subnet outbound internet access"
  type        = bool
  default     = false
}
