output "cluster_id" {
  description = "The name/id of the EKS cluster."
  value       = module.eks_test.cluster_id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = module.eks_test.cluster_arn
}