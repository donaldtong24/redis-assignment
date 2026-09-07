#!/bin/bash

set -e

echo "========================================"
echo "Kubernetes Application Status"
echo "========================================"

echo
echo "Cluster:"
kubectl cluster-info

echo
echo "Nodes:"
kubectl get nodes

echo
echo "Pods:"
kubectl get pods

echo
echo "Services:"
kubectl get services

echo
echo "Deployments:"
kubectl get deployments

echo
echo "PersistentVolumeClaims:"
kubectl get pvc

echo
echo "========================================"