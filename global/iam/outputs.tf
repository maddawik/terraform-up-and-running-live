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
