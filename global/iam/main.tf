terraform {
  required_version = "1.14.3"
  backend "s3" {
    bucket = "terraform-up-and-running-ch-307091e9f"
    key    = "global/iam/terraform.tfstate"
    region = "us-east-2"

    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_user" "example" {
  # NOTE: This is now an array of resources, no longer a single resource
  # we convert to a set since for_each only works on sets/maps
  for_each = toset(var.user_names)
  name     = each.value
}


### Conditional cloudwatch access for neo

resource "aws_iam_policy" "cloudwatch_read_only" {
  name   = "cloudwatch-read-only"
  policy = data.aws_iam_policy_document.cloudwatch_read_only.json
}

data "aws_iam_policy_document" "cloudwatch_read_only" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudwatch_full_access" {
  name   = "cloudwatch-full-access"
  policy = data.aws_iam_policy_document.cloudwatch_full_access.json
}

data "aws_iam_policy_document" "cloudwatch_full_access" {
  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_full_access" {
  count      = var.give_neo_full_cloudwatch_access ? 1 : 0
  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_full_access.arn
}

resource "aws_iam_user_policy_attachment" "neo_cloudwatch_read_only" {
  count      = var.give_neo_full_cloudwatch_access ? 0 : 1
  user       = aws_iam_user.example[0].name
  policy_arn = aws_iam_policy.cloudwatch_read_only.arn
}
