# Create AWS EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${local.name}-${var.cluster_name}"
  role_arn = aws_iam_role.eks_master_role.arn

  vpc_config {
    # Note: Create ENI to communicate with EKS Control Plane in Private Subnet
    #subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]
    subnet_ids = data.aws_subnets.selected.ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access = var.cluster_endpoint_public_access
    //public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  }

  kubernetes_network_config {
    # The CIDR block to assign Kubernetes pod and service IP addresses from
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  //enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  enabled_cluster_log_types = ["api"]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.example
  ]
}

################################################################################

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*-${var.target_subnet_node_group}-*"] # insert values here
  }
}

resource "aws_cloudwatch_log_group" "example" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 1

  # ... potentially other configuration ...
}

/* output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
} */