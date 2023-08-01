resource "aws_eks_cluster" "example" {
  name     = "${var.env}-eks"
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}
