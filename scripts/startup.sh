#!/bin/bash

echo "========================================"
echo "Starting Redis + FastAPI Kubernetes app"
echo "========================================"

echo ""
echo "Applying Redis ConfigMap..."
kubectl apply -f k8s/redis-configmap.yaml

echo ""
echo "Applying Redis Secret..."
kubectl apply -f k8s/redis-secret.yaml

echo ""
echo "Applying Redis PVC..."
kubectl apply -f k8s/redis-pvc.yaml

echo ""
echo "Applying Redis Service..."
kubectl apply -f k8s/redis-service.yaml

echo ""
echo "Applying Redis Deployment..."
kubectl apply -f k8s/redis-deployments.yaml

echo ""
echo "Applying FastAPI Service..."
kubectl apply -f k8s/service.yaml

echo ""
echo "Applying FastAPI Deployment..."
kubectl apply -f k8s/deployment.yaml

echo ""
echo "Applying Ingress..."
kubectl apply -f k8s/ingress.yaml

echo ""
echo "========================================"
echo "Kubernetes manifests applied"
echo "========================================"