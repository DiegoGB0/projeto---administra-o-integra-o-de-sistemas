#!/bin/bash

echo "========================================="
echo " Inicializando Infraestrutura "
echo "========================================="

if ! command -v docker >/dev/null 2>&1
then
    echo "ERRO: Docker não encontrado."
    exit 1
fi

if ! docker info >/dev/null 2>&1
then
    echo "ERRO: Docker não está em execução."
    exit 1
fi

echo "Docker OK."

RUNNING=$(docker compose ps -q)

if [ -n "$RUNNING" ]
then
    echo "Ambiente já está em execução."
else
    echo "Iniciando containers..."
    docker compose up -d
fi

echo ""
echo "Status dos containers:"
docker compose ps

echo ""
echo "Serviços disponíveis:"
echo "Nginx:      http://localhost"
echo "Prometheus: http://localhost:9090"
echo "Grafana:    http://localhost:3000"