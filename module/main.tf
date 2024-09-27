# EKS Terraform module
# This is a basic setup more modules can be added in the future

module "eks" {
  source             = "./eks/"
  cluster-name       = "${var.cluster-name}"
  k8s-version        = "${var.k8s-version}"
  aws-region         = "${var.aws-region}"
  node-instance-type = "${var.node-instance-type}"
  desired-capacity   = "${var.desired-capacity}"
  max-size           = "${var.max-size}"
  min-size           = "${var.min-size}"
  key-pair        = "{var.key-pair}"
  vpc-subnet-cidr    = "${var.vpc-subnet-cidr}"
}
