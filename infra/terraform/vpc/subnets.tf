locals {
  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnets = {
    public-a = {
      cidr = "10.0.1.0/24"
      az   = "us-east-1a"
    }
    public-b = {
      cidr = "10.0.2.0/24"
      az   = "us-east-1b"
    }
  }

  private_subnets = {
    private-a = {
      cidr = "10.0.11.0/24"
      az   = "us-east-1a"
    }
    private-b = {
      cidr = "10.0.12.0/24"
      az   = "us-east-1b"
    }
  }
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name                     = "redis-assignment-${each.key}"
    Environment              = "dev"
    Project                  = "redis-assignment"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name                              = "redis-assignment-${each.key}"
    Environment                       = "dev"
    Project                           = "redis-assignment"
    "kubernetes.io/role/internal-elb" = "1"
  }
}
