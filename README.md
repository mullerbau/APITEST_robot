# Projeto de Testes de API - Restful-Booker

## Descrição do Projeto

Este projeto foi desenvolvido para a prática de testes de API, utilizando o Robot Framework e a biblioteca RequestsLibrary. O objetivo é automatizar testes para os principais endpoints da API de demonstração [Restful-Booker](https://restful-booker.herokuapp.com/apidoc/index.html), abrangendo operações de CRUD (Create, Read, Update, Delete).

## Tecnologias Utilizadas

* **Robot Framework**: Um framework de automação genérico e de código aberto
* **RequestsLibrary**: Uma biblioteca para o Robot Framework que facilita requisições HTTP
* **Python**: Linguagem de programação utilizada para a execução do Robot Framework

## Pré-requisitos

Certifica-te de que as seguintes ferramentas estão instaladas no teu ambiente:

* Python (versão 3.6 ou superior)
* pip (gestor de pacotes do Python)

Para instalar as bibliotecas necessárias, executa o seguinte comando:

```bash
pip install robotframework robotframework-requests
```

Ou use o script de setup automatizado:

```bash
setup.bat
```

## Estrutura do Projeto (Refatorada - Boas Práticas)

```
├── config/
│   └── configuracoes.robot          # Configurações centralizadas
│
├── keywords/
│   ├── api_keywords.robot           # Keywords específicas da API
│   └── comum.robot                  # Keywords reutilizáveis
│
├── data/
│   ├── json/
│   │   ├── json_reserva_ex.json     # Dados de teste para reservas
│   │   └── json_login_ex.json       # Dados de teste para login
│   └── csv/                         # Dados em CSV (futuro)
│
├── suites/
│   ├── api/
│   │   ├── teste_autenticacao.robot      # Testes de autenticação
│   │   ├── teste_reservas_crud.robot     # Testes CRUD de reservas
│   │   └── teste_dados_json.robot        # Testes com dados JSON
│   └── integracao/
│       └── teste_fluxo_completo.robot    # Testes de integração
│
├── results/                         # Relatórios de execução
├── executar_testes.bat             # Script interativo de execução
├── setup.bat                       # Script de instalação
└── README.md
```

## Como Executar os Testes

### Opção 1: Script Interativo (Recomendado)
```bash
executar_testes.bat
```

### Opção 2: Comandos Diretos

**Executar todos os testes:**
```bash
robot -d ./results suites/
```

**Executar por suite específica:**
```bash
robot -d ./results suites/api/teste_autenticacao.robot
robot -d ./results suites/api/teste_reservas_crud.robot
robot -d ./results suites/api/teste_dados_json.robot
robot -d ./results suites/integracao/
```

**Executar por tags:**
```bash
robot -d ./results -i positivo suites/        # Apenas testes positivos
robot -d ./results -i negativo suites/        # Apenas testes negativos
robot -d ./results -i autenticacao suites/    # Apenas testes de auth
robot -d ./results -i crud suites/            # Apenas testes CRUD
robot -d ./results -i integracao suites/      # Apenas testes de integração
```

## Tipos de Teste Implementados

### 🔐 **Autenticação**
- Obtenção de token com credenciais válidas
- Tentativa com credenciais inválidas

### 📋 **CRUD de Reservas**
- Criar reserva válida
- Listar todas as reservas
- Buscar reserva por ID
- Atualizar reserva (com/sem autenticação)
- Excluir reserva (com/sem autenticação)

### 📄 **Testes com Dados JSON**
- Criação com dados válidos do JSON
- Tentativas com dados inválidos/incompletos

### 🔄 **Integração**
- Fluxo completo CRUD
- Testes com múltiplas reservas

## Tags Disponíveis

- `positivo` / `negativo`: Tipo de teste
- `autenticacao`: Testes de autenticação
- `reserva`: Testes relacionados a reservas
- `crud`: Operações CRUD
- `json`: Testes com dados JSON
- `integracao`: Testes de integração
- `get` / `post` / `put` / `delete`: Por método HTTP

## Melhorias Implementadas

✅ **Estrutura profissional seguindo boas práticas**
✅ **Keywords reutilizáveis e organizadas**
✅ **Configurações centralizadas**
✅ **Dados de teste externos (JSON)**
✅ **Suites especializadas por funcionalidade**
✅ **Sistema de tags robusto**
✅ **Scripts de automação**
✅ **Documentação completa**

## Autor
Eric Bauer - [mullerbau]