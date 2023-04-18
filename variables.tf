variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# EKS Cluster Input Variables
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eksdemo"
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  default     = "192.168.0.0/24"
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
  type = number
  default     = 1.26
}
variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# EKS Node Group Variables
## Placeholder space you can create if required

variable "node_group" {
  description = "List of node groups which can contains EKS worker nodes."
  type        = list(string)
  default     = ["drupal", "dac", "soar"]
}

variable "node_ami_type" {
  description = "List of ami types which can contains EKS worker nodes."
  type        = list(string)
  default     = ["AL2_x86_64", "AL2_x86_64", "AL2_x86_64"]
}

variable "node_instance_type" {
  description = "List of instance types which can contains EKS worker nodes."
  type        = list(string)
  default     = ["t2.micro", "t2.micro", "t2.micro"]
}
