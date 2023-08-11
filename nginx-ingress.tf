resource "null_resource" "null" {

  triggers = {
    always = timestamp()
  }

  depends_on = [
    aws_eks_cluster.eks
  ]
  provisioner "local-exec" {
    command = <<EOF
aws eks update-kubeconfig --name ${var.env}-eks
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade -i ingress ingress-nginx/ingress-nginx -f ${path.module}/nginx-values.yml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
EOF
  }
}

