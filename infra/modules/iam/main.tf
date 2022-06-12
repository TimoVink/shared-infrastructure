resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group      = aws_iam_group.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "admin" {
  for_each = toset(var.admin_users)

  name = each.key
}

resource "aws_iam_user_group_membership" "admin" {
  for_each = toset(var.admin_users)

  user   = aws_iam_user.admin[each.key].name
  groups = [aws_iam_group.administrators.name]
}
