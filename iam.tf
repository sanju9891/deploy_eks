module "eks_iam_role" {
  //source       = "terraform-aws-modules/iam/aws//modules/eks"
  source       = "cloudposse/eks-iam-role/aws"
  cluster_name = module.eks.cluster_name
}
