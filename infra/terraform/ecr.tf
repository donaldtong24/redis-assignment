resource "aws_ecr_repository" "python_api" {
  name                 = "redis-assignment/python-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project     = "redis-assignment"
    Environment = "dev"
  }
}

resource "aws_ecr_lifecycle_policy" "python_api" {
  repository = aws_ecr_repository.python_api.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images after 14 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 14
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
