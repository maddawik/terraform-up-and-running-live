variable "user_names" {
  description = "Create IAM users with these names."
  type        = list(string)
  default     = ["neo", "morpheus", "trinity"]
}

# Example Vars

variable "hero_thousand_faces" {
  description = "Map Example"
  type        = map(string)
  default = {
    neo      = "hero"
    trinity  = "love interest"
    morpheus = "mentor"
  }
}
