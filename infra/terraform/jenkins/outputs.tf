output "public_ip" {
  description = "Public IP of the Jenkins instance"
  value       = aws_instance.jenkins.public_ip
}

output "instance_id" {
  description = "Instance ID of the Jenkins controller"
  value       = aws_instance.jenkins.id
}

output "iam_role_arn" {
  description = "IAM role ARN assumed by the Jenkins instance"
  value       = aws_iam_role.jenkins.arn
}
