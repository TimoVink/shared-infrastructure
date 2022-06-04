resource "aws_iam_group" "deployer" {
  name = "deployer"
}

resource "aws_iam_group_policy_attachment" "deployer" {
  group      = aws_iam_group.deployer.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "deployer" {
  name = "deployer"
}

resource "aws_iam_user_group_membership" "deployer" {
  user   = aws_iam_user.deployer.name
  groups = [aws_iam_group.deployer.name]
}
