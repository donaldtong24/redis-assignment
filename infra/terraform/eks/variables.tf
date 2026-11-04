variable "cluster_subnet_ids" {
  description = "Private subnet IDs for EKS control plane networking"
  type        = list(string)
}

variable "worker_subnet_ids" {
  description = "Public subnet IDs for development worker nodes"
  type        = list(string)
}

variable "admin_public_ip_cidr" {
  description = "Public IPv4 CIDR allowed to access the EKS Kubernetes API"
  type        = string
}