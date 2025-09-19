# Projeto de Testes de API - Restful-Booker

## Descrição do Projeto

Este projeto foi desenvolvido para a prática de testes de API, utilizando o Robot Framework e a biblioteca RequestsLibrary. O objetivo é automatizar testes para os principais endpoints da API de demonstração [Restful-Booker](https://restful-booker.herokuapp.com/apidoc/index.html), abrangendo operações de CRUD (Create, Read, Update, Delete).

## Tecnologias Utilizadas

* **Robot Framework**: Um framework de automação genérico e de código aberto.
* **RequestsLibrary**: Uma biblioteca para o Robot Framework que facilita requisições HTTP.
* **Python**: Linguagem de programação utilizada para a execução do Robot Framework.

## Pré-requisitos

Certifica-te de que as seguintes ferramentas estão instaladas no teu ambiente:

* Python (versão 3.6 ou superior)
* pip (gestor de pacotes do Python)

Para instalar as bibliotecas necessárias, executa o seguinte comando:

```bash
pip install robotframework robotframework-requests
``` 
## Estrutura

├── resources/
│   └── api_teste.resource     # Ficheiro com as palavras-chave reutilizáveis (keywords) da API.
|
├── testes/
│   ├── api_teste-DELETE.robot # Cenários de teste para a requisição DELETE.
│   ├── api_teste-GET.robot    # Cenários de teste para a requisição GET.
│   ├── api_teste-POST.robot   # Cenários de teste para a requisição POST.
│   └── api_teste-PUT.robot    # Cenários de teste para a requisição PUT.
|
└── variaveis/
    └── variaveis_globais.robot  # Ficheiro com variáveis e configurações globais.


## Como Executar os Testes
1. Navega até a pasta raiz do projeto.

2. Executa o comando do Robot Framework para iniciar os testes:

```bash
python robot -d ./results testes/"teste desejado".robot
```

## Autor 
- Eric Bauer - [mullerbau]