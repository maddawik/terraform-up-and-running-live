output "all_arns" {
  # NOTE: We need the values function and the * splat expression to
  # get all arns from the map
  value       = values(aws_iam_user.example)[*].arn
  description = "The ARNs for all users"
}

# Example Outputs

output "upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

output "for_directive" {
  value = "%{for i, name in var.user_names}(${i}): ${name}, %{endfor}"
}

# NOTE: this is a bit brittle...
output "neo_cloudwatch_policy_arn" {
  value = var.give_neo_full_cloudwatch_access ? aws_iam_user_policy_attachment.neo_cloudwatch_full_access[0].policy_arn : aws_iam_user_policy_attachment.neo_cloudwatch_read_only[0].policy_arn
}
