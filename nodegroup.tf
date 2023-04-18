# Create AWS EKS Node Group - Private

resource "aws_eks_node_group" "eks_ng_private" {
  cluster_name    = aws_eks_cluster.eks_cluster.name

  count = 3
  node_group_name = element(var.node_group, count.index)
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = ["subnet-071aada621643b10b", "subnet-087d4dc0426576a50"]
  #version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)    
  
  ami_type = element(var.node_ami_type, count.index)
  capacity_type = "ON_DEMAND"
  disk_size = 20
  instance_types = [element(var.node_instance_type, count.index)]
  
  
#   remote_access {
#     ec2_ssh_key = "eks-terraform-key"    
#   }

  scaling_config {
    desired_size = 1
    min_size     = 1    
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1    
    #max_unavailable_percentage = 50    # ANY ONE TO USE
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]  
  tags = {
    Name = "Private-Node-Group"
  }
}