module "vpc" {
  source = "./vpc"

  enable_nat_gateway = var.enable_nat_gateway
}
