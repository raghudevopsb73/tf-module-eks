resource "aws_eks_cluster" "eks" {
  name     = "${var.env}-eks"
  role_arn = aws_iam_role.eks-role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.env}-ng"
  node_role_arn   = aws_iam_role.node-role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types
  capacity_type   = var.capacity_type

  scaling_config {
    desired_size = var.min_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
}

resource "aws_iam_openid_connect_provider" "cluster" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}
