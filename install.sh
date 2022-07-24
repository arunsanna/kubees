#!/bin/bash


export EKSA_RELEASE="0.10.1"
export OS=$(uname -s | tr A-Z a-z)
export RELEASE_NUMBER=15
export KUBECONFIG="dev-cluster/dev-cluster-eks-a-cluster.kubeconfig"

install_eksctl() {
  echo "Installing eksctl"
  curl "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" --silent --location | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin/
}

install_eksanywhere() {
  echo "Installing eksanywhere"
  curl "https://anywhere-assets.eks.amazonaws.com/releases/eks-a/${RELEASE_NUMBER}/artifacts/eks-a/v${EKSA_RELEASE}/${OS}/amd64/eksctl-anywhere-v${EKSA_RELEASE}-${OS}-amd64.tar.gz" --silent --location | tar xz ./eksctl-anywhere
  sudo mv ./eksctl-anywhere /usr/local/bin/
}

deploy_eksanywhere() {
  eksctl anywhere create cluster -f dev-cluster.yaml
}


$1
