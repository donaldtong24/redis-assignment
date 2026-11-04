module "vpc" {
  source = "./vpc"

  enable_nat_gateway = var.enable_nat_gateway
}

module "eks" {
  source = "./eks"

  cluster_subnet_ids = [
    module.vpc.private_subnet_ids["private-a"],
    module.vpc.private_subnet_ids["private-b"]
  ]

  worker_subnet_ids = [
    module.vpc.public_subnet_ids["public-a"],
    module.vpc.public_subnet_ids["public-b"]
  ]

  admin_public_ip_cidr = var.admin_public_ip_cidr

  depends_on = [module.vpc]
}