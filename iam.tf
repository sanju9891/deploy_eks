module "eks_iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/eks"
  cluster_name = module.eks.cluster_name
}
