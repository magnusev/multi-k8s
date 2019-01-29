#!/usr/bin/env bash

# Build Docker images
docker build -t magnusev/multi-client:latest -t magnusev/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t magnusev/multi-server:latest -t magnusev/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t magnusev/multi-worker:latest -t magnusev/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

# Push Docker images to Docker hub
docker push magnusev/multi-client:latest
docker push magnusev/multi-server:latest
docker push magnusev/multi-worker:latest

docker push magnusev/multi-client:$GIT_SHA
docker push magnusev/multi-server:$GIT_SHA
docker push magnusev/multi-worker:$GIT_SHA

# Apply configuration to Kubernetes
kubectl apply -f k8s

# Tell Kubernetes that the docker images have changed
kubectl set image deployments/client-deployment client=magnusev/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=magnusev/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=magnusev/multi-worker:$GIT_SHA