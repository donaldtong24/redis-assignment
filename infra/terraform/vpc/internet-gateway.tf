resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "redis-assignment-igw"
    Environment = "dev"
    Project     = "redis-assignment"
  }
}
