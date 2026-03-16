output "all_arns" {
  # NOTE: We need the values function and the * splat expression to
  # get all arns from the map
  value       = values(aws_iam_user.example)[*].arn
  description = "The ARNs for all users"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}
