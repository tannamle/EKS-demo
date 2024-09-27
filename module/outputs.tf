# Do not change generates the kubeconfig files 
# Needed to connect to the EKS cluster
# Also builds the Config map for Authorization
# See Readme for more information

# Setup kubectl
output "kubeconfig" {
  value = "${module.eks.kubeconfig}"
}

# Setup Configmap so Workers can Join the cluster
output "config-map" {
  value = "${module.eks.config-map-aws-auth}"
}
