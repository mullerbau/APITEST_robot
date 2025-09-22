*** Settings ***
Documentation    Testes de autenticação da API Restful-Booker
Resource         ../../keywords/api_keywords.robot
Resource         ../../keywords/comum.robot

*** Test Cases ***
Obter Token com Credenciais Validas
    [Tags]    autenticacao    positivo
    [Documentation]    Valida obtenção de token com credenciais corretas
    Log de Teste Iniciado    Obter Token com Credenciais Validas
    Criar Sessao da API
    ${token}=    Obter Token de Autenticacao
    Validar Token na Resposta
    Should Not Be Empty    ${token}
    Log de Teste Finalizado    Obter Token com Credenciais Validas

Tentar Obter Token com Credenciais Invalidas
    [Tags]    autenticacao    negativo
    [Documentation]    Valida falha na obtenção de token com credenciais incorretas
    Log de Teste Iniciado    Tentar Obter Token com Credenciais Invalidas
    Criar Sessao da API
    ${dados_json}=    Importar Dados JSON    data/json/json_login_ex.json
    ${dados_invalidos}=    Set Variable    ${dados_json['usuario_invalido']}
    ${response}=    Post On Session   booker    ${AUTH_ENDPOINT}    
    ...    json=${dados_invalidos}    expected_status=200
    Should Be Equal As Strings    ${response.json()['reason']}    Bad credentials
    Log de Teste Finalizado    Tentar Obter Token com Credenciais Invalidas