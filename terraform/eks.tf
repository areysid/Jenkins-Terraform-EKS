module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.6.0"

  cluster_name                   = local.name
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default_node_group = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3

      capacity_type = "ON_DEMAND"

      tags = {
        Name = "eks-default-node"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
