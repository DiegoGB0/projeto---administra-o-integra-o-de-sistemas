#!/bin/bash

echo "====================================="
echo "  INICIANDO INFRAESTRUTURA DO PROJETO"
echo "====================================="

# Verifica se o Docker está rodando
if ! docker info > /dev/null 2>&1; then
  echo "❌ Docker não está rodando. Inicie o Docker e tente novamente."
  exit 1
fi

echo "✅ Docker está rodando"

# Verifica se já existe stack rodando
if [ "$(docker compose ps -q)" ]; then
  echo "⚠️ Já existe um ambiente rodando. Reiniciando..."
  docker compose down
fi

# Sobe a infraestrutura
echo "🚀 Subindo containers..."
docker compose up -d

echo ""
echo "====================================="
echo "  STATUS DOS CONTAINERS"
echo "====================================="
docker compose ps

echo ""
echo "====================================="
echo "  INFRAESTRUTURA PRONTA!"
echo "====================================="
echo "Nginx Load Balancer: http://localhost:8080"
echo "Grafana: http://localhost:3000"
echo "Prometheus: http://localhost:9090"
echo "====================================="