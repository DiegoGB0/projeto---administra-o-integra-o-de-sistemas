# Projeto AIS

Projeto desenvolvido para a disciplina de **Administração e Integração de Sistemas**.

---

# Objetivo

Construir uma infraestrutura utilizando contêineres Docker composta por:

- Proxy Reverso e Load Balancer (Nginx)
- Duas instâncias da aplicação web
- Banco de dados PostgreSQL com persistência
- Monitoramento com Prometheus
- Dashboard de métricas com Grafana

---

# Arquitetura

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
        │ App 1 │         │ App 2 │ ───────────┐
        └───────┘         └───────┘            │
              │             │                  │
              └──────┬──────┘                  │
                     ▼                         │
              ┌──────────┐                 ┌──────────┐
              │PostgreSQL│                 │PostgreSQL│
              └──────────┘                 └──────────┘  
                                               │
                ┌──────────────────────────────┘ 
                ▼
         ┌─────────────┐
         │ Prometheus  │
         └──────┬──────┘
                ▼
         ┌─────────────┐
         │   Grafana   │
         └─────────────┘
```

---

# Estrutura do Projeto

```text
.
├── app/
│   ├── app1/
│   │   └── index.html
│   └── app2/
│       └── index.html
├── nginx/
│   └── nginx.conf
├── prometheus/
│   └── prometheus.yml
├── scripts/
│   └── start-infra.sh
├── docker-compose.yml
└── README.md
```

---

# Tecnologias Utilizadas

- Docker
- Docker Compose
- Nginx
- PostgreSQL
- Prometheus
- Grafana

---

# Requisitos

- Docker Desktop
- Docker Compose
- Git

---

# Como Executar

Subir toda a infraestrutura:

```bash
docker compose up -d
```

Verificar os containers:

```bash
docker compose ps
```

Parar o ambiente:

```bash
docker compose down
```

---

# Aplicação Web

A aplicação foi dividida em duas instâncias independentes para demonstrar o balanceamento de carga.

## App 1

Exibe a página:

```text
🚀 APP 1
Rodando na instância 1
```

## App 2

Exibe a página:

```text
⚡ APP 2
Rodando na instância 2
```

As duas aplicações são servidas por containers Nginx distintos e serão acessadas através do Load Balancer.

## Como testar

Subir a infraestrutura:

```bash
docker compose up -d
```

Abrir:

```text
http://localhost:8080
```

A aplicação deverá responder através do Nginx Load Balancer.

---

# Banco de Dados

Banco utilizado:

- PostgreSQL 16

Configuração:

- Usuário: `admin`
- Senha: `admin123`
- Banco: `projeto`

Persistência realizada através do volume Docker:

```text
postgres_data
```

## Como testar

Entrar no PostgreSQL:

```bash
docker exec -it postgres-db psql -U admin -d projeto
```

Criar uma tabela:

```sql
CREATE TABLE teste (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);
```

Inserir um registro:

```sql
INSERT INTO teste (nome)
VALUES ('Diego');
```

Verificar:

```sql
SELECT * FROM teste;
```

Sair:

```sql
\q
```

---

# Teste de Persistência

Parar a infraestrutura:

```bash
docker compose down
```

Subir novamente:

```bash
docker compose up -d
```

Entrar novamente no PostgreSQL:

```bash
docker exec -it postgres-db psql -U admin -d projeto
```

Consultar os dados:

```sql
SELECT * FROM teste;
```

Se o registro continuar existindo, a persistência está funcionando corretamente.

---

# Balanceamento de Carga

## Como testar

Abrir:

```text
http://localhost:8080
```

Atualizar a página algumas vezes.

Deverá aparecer alternadamente:

```text
🚀 APP 1
```

e

```text
⚡ APP 2
```

Parar uma das aplicações:

```bash
docker stop app1
```

Atualizar novamente:

```text
http://localhost:8080
```

A aplicação deverá continuar funcionando utilizando a segunda instância.

Reiniciar a aplicação:

```bash
docker start app1
```

---

# Monitoramento e Automação

## Como executar

Dar permissão ao script:

```bash
chmod +x scripts/start-infra.sh
```

Executar:

```bash
./scripts/start-infra.sh
```

---

# Serviços

Aplicação:

```text
http://localhost:8080
```

Prometheus:

```text
http://localhost:9090
```

Grafana:

```text
http://localhost:3000
```

---

# Login Grafana

Usuário:

```text
admin
```

Senha:

```text
admin
```

---

# Fonte de Dados

Tipo:

```text
Prometheus
```

URL:

```text
http://prometheus:9090
```

---

# Dashboard

Consulta utilizada:

```text
up
```

Resultado:

```text
1 = serviço online

0 = serviço offline
```

---

# Como testar

Executar:

```bash
docker compose ps
```

Acessar:

- http://localhost:9090
- Status → Targets

Todos os serviços deverão estar com status **UP**.

Depois acessar:

- http://localhost:3000

Entrar com:

Usuário:

```text
admin
```

Senha:

```text
admin
```

Verificar se o dashboard exibe as métricas dos serviços monitorados.

---

# Validação Geral da Infraestrutura

Executar:

```bash
docker compose ps
```

O resultado esperado é:

- app1 → Running
- app2 → Running
- postgres-db → Running
- nginx-lb → Running
- prometheus → Running
- grafana → Running

Em seguida, acessar:

- Aplicação: http://localhost:8080
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

Se todos os serviços estiverem acessíveis, a infraestrutura estará funcionando corretamente.

---

# Status Atual

- ✅ Estrutura do projeto criada
- ✅ Docker Compose configurado
- ✅ Rede interna configurada
- ✅ Volume persistente configurado
- ✅ Aplicação Web (App 1 e App 2)
- ✅ PostgreSQL funcionando
- ✅ Persistência dos dados validada
- ✅ Prometheus funcionando
- ✅ Grafana funcionando
- ✅ Script de inicialização
- ⏳ Nginx e Load Balancer (em integração)
- ⏳ Testes de balanceamento

---

# Equipe

| Integrante | Responsabilidade |
|------------|------------------|
| Diego (pessoa 1) | Infraestrutura Docker |
| Kauê (pessoa 2) | Aplicação Web e Banco de Dados |
| Eraldo (Pessoa 3) | Nginx e Load Balancer |
| José Antônio (Pessoa 4) | Monitoramento e Automação |