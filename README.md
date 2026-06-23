Projeto desenvolvido para a disciplina de Administração e Integração de Sistemas.

## Objetivo

Construir uma infraestrutura utilizando contêineres Docker, composta por:

- Proxy Reverso e Load Balancer (Nginx)
- Duas instâncias da aplicação web
- Banco de dados PostgreSQL com persistência
- Monitoramento com Prometheus
- Dashboard de métricas com Grafana

## Arquitetura

```text
                 ┌─────────┐
                 │ Cliente │
                 └────┬────┘
                      │
                      ▼
               ┌────────────┐
               │   Nginx    │
               │ LoadBalancer│
               └─────┬──────┘
                     │
            ┌────────┴────────┐
            ▼                 ▼
        ┌───────┐         ┌───────┐
        │ App 1 │         │ App 2 │
        └───────┘         └───────┘
              │             │
              └──────┬──────┘
                     ▼
              ┌──────────┐
              │PostgreSQL│
              └──────────┘

         ┌─────────────┐
         │ Prometheus  │
         └──────┬──────┘
                ▼
         ┌─────────────┐
         │   Grafana   │
         └─────────────┘
```

## Estrutura do Projeto

```text
.
├── app/
├── nginx/
│   └── nginx.conf
├── prometheus/
│   └── prometheus.yml
├── scripts/
│   └── start-infra.sh
├── docker-compose.yml
└── README.md
```

## Tecnologias Utilizadas

- Docker
- Docker Compose
- Nginx
- PostgreSQL
- Prometheus
- Grafana

## Requisitos

- Docker Desktop
- Docker Compose
- Git

## Como Executar

```bash
docker compose up -d
```

Verificar os containers:

```bash
docker ps
```

Parar o ambiente:

```bash
docker compose down
```

## Status Atual

- [x] Estrutura do projeto criada
- [x] Docker Compose configurado
- [x] Rede interna configurada
- [x] Volume persistente configurado
- [x] PostgreSQL funcionando
- [x] Prometheus funcionando
- [x] Grafana funcionando
- [ ] Nginx configurado
- [ ] Aplicação web finalizada
- [ ] Script de inicialização
- [ ] Testes de balanceamento
- [ ] Testes de persistência

## Equipe

| Integrante | Responsabilidade |
|------------|------------------|
|Diego (Pessoa 1) | Infraestrutura Docker |
|Kauê (Pessoa 2) | Aplicação Web |
| Pessoa 3 | Nginx e Load Balancer |
| Pessoa 4 | Monitoramento e Automação |