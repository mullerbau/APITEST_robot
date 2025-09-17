*** Settings ***
Documentation
Library        RequestsLibrary
Resource       api_teste.resource


*** Test Cases ***
Cenario 1: GET Todos Usuários
    Criar Sessao
    GET Endpoint /users
    Validar Status Code "200"

Cenário 2: POST Criar Usuário 200
    Criar Sessao
    POST Endpoint /register 
    Validar Status Code "200"

Cenário 3: POST Login Usuário 200
    Criar Sessao
    POST Login /login
    Validar Status Code "200"
    Validar Token no Response
    