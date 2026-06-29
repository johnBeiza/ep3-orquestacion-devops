#!/bin/bash
echo "=== 1 y 2. Construyendo imágenes (Build) ==="
podman build -t localhost:5000/tienda-backend:eks-v1 -f Dockerfile .
podman build -t localhost:5000/tienda-frontend:eks-v1 -f Dockerfile.frontend .

echo "=== 3. Subiendo imágenes al registry (Push) ==="
podman push localhost:5000/tienda-backend:eks-v1
podman push localhost:5000/tienda-frontend:eks-v1

echo "=== 4, 5 y 6. Desplegando en Kubernetes ==="
kubectl apply -f deployment.yaml -f service.yaml -f hpa.yaml
kubectl apply -f frontend-deployment.yaml -f frontend-service.yaml

echo "=== 7. Esperando el rollout... ==="
kubectl rollout status deployment/tienda-backend
kubectl rollout status deployment/tienda-frontend

echo "=== 8. Estado final del despliegue ==="
kubectl get deploy,svc,hpa,pods -o wide
echo "=== Pipeline completado con éxito ==="
