module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.25"
  vpc_id          = aws_vpc.my_vpc.id
  subnet_ids      = concat(aws_subnet.public_subnet.*.id, aws_subnet.private_subnet.*.id)

  node_groups = {
    eks_nodes = {
      desired_capacity = 3
      max_capacity     = 4
      min_capacity     = 1
      instance_type    = "t2.medium"
    }
  }
  tags = {
    Name = "eks-cluster"
  }
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
