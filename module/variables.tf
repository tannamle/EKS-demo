# Variables Configuration

variable "cluster-name" {
  default     = "test03-cluster-533045288693"
  type        = "string"
  description = "This is a POC Cluster for EKS  Default"
}

variable "aws-region" {
  default     = "us-east-1"
  type        = "string"
  description = "The AWS Region to deploy EKS (US-EAST-1) Default"
}

variable "k8s-version" {
  default     = "1.11"
  type        = "string"
  description = "Required K8s version (1.11) Default"
}

variable "vpc-subnet-cidr" {
  default     = "10.30.0.0/20"
  type        = "string"
  description = "The VPC Subnet CIDR (10.20.0.0/20) Default"
}

variable "node-instance-type" {
  default     = "m4.large"
  type        = "string"
  description = "Worker Node EC2 instance type (m4.large) Default"
}

variable "key-pair" {
  default   = "EKS-ec2"
  type        = "string"
  description = "Worker Node EC2 instance key-pair Default"
}

variable "desired-capacity" {
  default     = 2
  type        = "string"
  description = "Autoscaling Desired node capacity (2) Default"
}

variable "max-size" {
  default     = 3
  type        = "string"
  description = "Autoscaling maximum node capacity (3) Default"
}

variable "min-size" {
  default     = 1
  type        = "string"
  description = "Autoscaling Minimum node capacity (1) Default"
}
