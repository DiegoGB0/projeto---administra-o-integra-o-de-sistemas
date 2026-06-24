#!/bin/bash

echo "===================================="
echo " Iniciando infraestrutura Docker..."
echo "===================================="

docker compose down

docker compose up --build -d

echo ""
echo "Containers iniciados:"
docker ps

echo ""
echo "Acesse:"
echo "Aplicação : http://localhost:8080"
echo "Grafana   : http://localhost:3000"
echo "Prometheus: http://localhost:9090"