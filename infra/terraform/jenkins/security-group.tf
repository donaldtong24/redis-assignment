resource "aws_security_group" "jenkins" {
  name        = "redis-assignment-jenkins"
  description = "Jenkins controller - web UI and SSH from admin IP only"
  vpc_id      = var.vpc_id

  ingress {
    description = "Jenkins web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.admin_public_ip_cidr]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_public_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "redis-assignment-jenkins"
    Project     = "redis-assignment"
    Environment = "dev"
  }
}
