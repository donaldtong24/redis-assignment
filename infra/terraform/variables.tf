variable "enable_nat_gateway" {
  description = "Create one NAT Gateway for private subnet outbound internet access"
  type        = bool
  default     = false
}

variable "admin_public_ip_cidr" {
  description = "Public IPv4 CIDR allowed to access the EKS Kubernetes API"
  type        = string
  default     = "67.86.175.47/32"
}