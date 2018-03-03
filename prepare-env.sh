#!/bin/bash
set -e

BASE=$(pwd)
TOOLS_DIR=$BASE/tools/
KUBECTL=$TOOLS_DIR/kubectl
MINIKUBE=$TOOLS_DIR/minikube

mkdir -p $TOOLS_DIR

if [ ! -x $KUBECTL ]; then
  echo "kubectl not installed, installing..."
  TEMP=$(mktemp -d)
  (
    cd $TEMP
    curl -fOL https://dl.k8s.io/v1.9.3/kubernetes-client-linux-amd64.tar.gz
    tar -xf kubernetes-client-linux-amd64.tar.gz
    mv $(find kubernetes -name kubectl) $TOOLS_DIR
  )
fi

if [ ! -x $MINIKUBE ]; then
  echo "minikube not installed, installing..."
  curl -fL https://github.com/kubernetes/minikube/releases/download/v0.25.0/minikube-linux-amd64 -o $TOOLS_DIR/minikube
  chmod +x $TOOLS_DIR/minikube
fi

if ! $MINIKUBE status ; then
  $MINIKUBE start
  $MINIKUBE addons enable ingress
fi

echo "Prepare docker env"
source <($MINIKUBE docker-env)
