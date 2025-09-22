*** Settings ***
Documentation    Testes CRUD para reservas da API Restful-Booker
Resource         ../../keywords/api_keywords.robot
Resource         ../../keywords/comum.robot

*** Test Cases ***
Criar Reserva Valida
    [Tags]    reserva    post    positivo
    [Documentation]    Testa criação de reserva com dados válidos
    Log de Teste Iniciado    Criar Reserva Valida
    Criar Sessao da API
    ${id_reserva}=    Criar Nova Reserva
    Validar Reserva Criada com Sucesso    ${id_reserva}
    Log de Teste Finalizado    Criar Reserva Valida

Listar Todas as Reservas Existentes
    [Tags]    reserva    get    positivo
    [Documentation]    Testa listagem de todas as reservas
    Log de Teste Iniciado    Listar Todas as Reservas Existentes
    Criar Sessao da API
    ${reservas}=    Listar Todas as Reservas
    Should Not Be Empty    ${reservas}
    Log To Console    Total de reservas: ${reservas.__len__()}
    Log de Teste Finalizado    Listar Todas as Reservas Existentes

Buscar Reserva Especifica por ID
    [Tags]    reserva    get    positivo
    [Documentation]    Testa busca de reserva específica por ID
    Log de Teste Iniciado    Buscar Reserva Especifica por ID
    Criar Sessao da API
    ${id_reserva}=    Criar Nova Reserva
    ${reserva}=    Buscar Reserva por ID    ${id_reserva}
    Should Not Be Empty    ${reserva}
    Should Be Equal As Strings    ${reserva['firstname']}    João
    Log de Teste Finalizado    Buscar Reserva Especifica por ID

Atualizar Reserva com Autenticacao
    [Tags]    reserva    put    positivo    autenticacao
    [Documentation]    Testa atualização de reserva com token válido
    Log de Teste Iniciado    Atualizar Reserva com Autenticacao
    Criar Sessao da API
    ${token}=    Obter Token de Autenticacao
    ${id_reserva}=    Criar Nova Reserva
    Atualizar Reserva Existente    ${token}    ${id_reserva}
    Log de Teste Finalizado    Atualizar Reserva com Autenticacao

Excluir Reserva com Autenticacao
    [Tags]    reserva    delete    positivo    autenticacao
    [Documentation]    Testa exclusão de reserva com token válido
    Log de Teste Iniciado    Excluir Reserva com Autenticacao
    Criar Sessao da API
    ${token}=    Obter Token de Autenticacao
    ${id_reserva}=    Criar Nova Reserva
    Excluir Reserva    ${token}    ${id_reserva}
    Log de Teste Finalizado    Excluir Reserva com Autenticacao

Tentar Atualizar Reserva Sem Autenticacao
    [Tags]    reserva    put    negativo
    [Documentation]    Testa falha na atualização sem token
    Log de Teste Iniciado    Tentar Atualizar Reserva Sem Autenticacao
    Criar Sessao da API
    ${id_reserva}=    Criar Nova Reserva
    Tentar Atualizar Sem Token    ${id_reserva}
    Log de Teste Finalizado    Tentar Atualizar Reserva Sem Autenticacao

Tentar Excluir Reserva Sem Autenticacao
    [Tags]    reserva    delete    negativo
    [Documentation]    Testa falha na exclusão sem token
    Log de Teste Iniciado    Tentar Excluir Reserva Sem Autenticacao
    Criar Sessao da API
    ${id_reserva}=    Criar Nova Reserva
    Tentar Excluir Sem Token    ${id_reserva}
    Log de Teste Finalizado    Tentar Excluir Reserva Sem Autenticacao