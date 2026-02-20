output "all_arns" {
  # NOTE: We need the * splat expression to get all arns from the array
  value       = aws_iam_user.example[*].arn
  description = "The ARNs for all users"
}
