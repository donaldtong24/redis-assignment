variable "vpc_id" {
  description = "VPC ID to launch the Jenkins instance into"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID for the Jenkins instance"
  type        = string
}

variable "admin_public_ip_cidr" {
  description = "Public IPv4 CIDR allowed to reach Jenkins (SSH + web UI)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Jenkins controller"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "EC2 key pair name for SSH access (optional)"
  type        = string
  default     = null
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository Jenkins is allowed to push to"
  type        = string
}
