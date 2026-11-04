resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "redis-assignment-workers"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = var.worker_subnet_ids

  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.worker_node,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr_pull
  ]

  tags = {
    Project     = "redis-assignment"
    Environment = "dev"
  }
}
