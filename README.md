# tform-aws-eks-poc

This will deploy a full AWS EKS cluster with Terraform

## This is a list of resources that are created
# All defaults are listed Below in the Chart

1. VPC
2. Internet Gateway (IGW)
3. Public and Private Subnets
4. Security Groups, Route Tables and Route Table Associations
5. IAM roles, instance profiles and policies
6. An EKS Cluster
7. Autoscaling group and Launch Configuration
8. Worker Nodes in a private Subnet
9. The ConfigMap required to register Nodes with EKS
10. KUBECONFIG file to authenticate kubectl using the heptio authenticator aws binary

## Configuration

This is DEFAULKT config with the following variable ainouts:

| Name                 | Description                       | Default       |
|----------------------|-----------------------------------|---------------|
| `cluster-name`       | The name of your EKS Cluster      | `my-cluster`  |
| `aws-region`         | The AWS Region to deploy EKS      | `us-west-2`   |
| `k8s-version`        | The desired K8s version to launch | `1.11`        |
| `node-instance-type` | Worker Node EC2 instance type     | `m4.large`    |
| `desired-capacity`   | Desired Worker node capacity      | `2`           |
| `max-size`           | Maximum Worker node capacity      | `5`           |
| `min-size`           | Minimum Worker node capacity      | `1`           |
| `vpc-subnet-cidr`    | VPC Subnet CIDR                   | `10.0.0.0/16` |

> NOTE: The VPC Subnet will look like this (255.255.0.0) for IP Assignment or (10.0.`*`.`*`) allowing for 65,534 usable IP addresses.

> NOTE: Create a file called terraform.tfvars in the root for each project specifications, Change the  variables to over-ride the defaults.

## How to use this POC

```bash
git clone https://DanPalloneII@bitbucket.org/DanPalloneII/tform-aws-eks-poc.git
cd tform-aws-eks-poc
```

### IAM

The AWS credentials must be associated with a user having at LEAST the following AWS managed IAM policies

* IAMFullAccess
* AutoScalingFullAccess
* AmazonEKSClusterPolicy
* AmazonEKSWorkerNodePolicy
* AmazonVPCFullAccess
* AmazonEKSServicePolicy
* AmazonEKS_CNI_Policy
* AmazonEC2FullAccess

You need to create the following managed policies

*EKS*

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        }
    ]
}
```

### Terraform

You need to run the following commands to create the resources with Terraform:

```bash
terraform init
terraform plan
terraform apply
```

> NOTE: Save the plan state `terraform plan -out eks-state` or even better yet, setup [remote storage](https://www.terraform.io/docs/state/remote.html) for Terraform state. 

> NOTE: We can store the state in an [S3 backend](https://www.terraform.io/docs/backends/types/s3.html), with locking via DynamoDB

### Setup kubectl

Setup your `KUBECONFIG`

```bash
terraform output kubeconfig > ~/.kube/eks-cluster
export KUBECONFIG=~/.kube/eks-cluster
```

### To Authorize worker nodes

Get the config from terraform output, and save it to a yaml file:

```bash
terraform output config-map > config-map-aws-auth.yaml
```

Apply the config map to EKS:

```bash
kubectl apply -f config-map-aws-auth.yaml
```

Verify the worker nodes are joining the cluster

```bash
kubectl get nodes --watch
```

### To Cleaning up Everything

You can destroy this cluster entirely by running:

```bash
terraform plan -destroy
terraform destroy  --force
```

NL-
