# Create IAM Role and attach trust policy
resource "aws_iam_role" "role" {
  name               = var.automation_role
  description        = "Access resources using AWS API for S3, SSM, etc."
  assume_role_policy = file("./trust-policy.json")
}

# Use custom policy
resource "aws_iam_role_policy" "policy" {
  name   = var.automation_role
  role   = aws_iam_role.role.name
  policy = file("./iam-permissions-policy.json")
}

# Use existing polices
resource "aws_iam_role_policy_attachment" "policy" {
  count      = length(var.policy_arn)
  role       = aws_iam_role.role.name
  policy_arn = element(var.policy_arn, count.index)
}
