resource "aws_iam_group" "administrators" {
  name = "administrators"
}

resource "aws_iam_group_policy_attachment" "administrators" {
  group      = aws_iam_group.administrators.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "deployer" {
  name = "deployer"
}

resource "aws_iam_user_group_membership" "deployer" {
  user   = aws_iam_user.deployer.name
  groups = [aws_iam_group.administrators.name]
}

resource "aws_iam_user" "tvink" {
  name = "tvink"
}

resource "aws_iam_user_group_membership" "tvink" {
  user   = aws_iam_user.tvink.name
  groups = [aws_iam_group.administrators.name]
}
