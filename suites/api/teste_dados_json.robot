*** Settings ***
Documentation    Testes usando dados externos em JSON
Resource         ../../keywords/api_keywords.robot
Resource         ../../keywords/comum.robot

*** Test Cases ***
Criar Reserva com Dados JSON Validos
    [Tags]    reserva    json    positivo
    [Documentation]    Cria reserva usando dados válidos do JSON
    Log de Teste Iniciado    Criar Reserva com Dados JSON Validos
    Criar Sessao da API
    ${dados_json}=    Importar Dados JSON    data/json/json_reserva_ex.json
    ${dados_reserva}=    Set Variable    ${dados_json['reserva_valida']}
    ${id_reserva}=    Criar Reserva com Dados Customizados    ${dados_reserva}
    Validar Reserva Criada com Sucesso    ${id_reserva}
    Log de Teste Finalizado    Criar Reserva com Dados JSON Validos

Tentar Criar Reserva Sem Dados Obrigatorios
    [Tags]    reserva    json    negativo
    [Documentation]    Tenta criar reserva com dados vazios
    Log de Teste Iniciado    Tentar Criar Reserva Sem Dados Obrigatorios
    Criar Sessao da API
    ${dados_json}=    Importar Dados JSON    data/json/json_reserva_ex.json
    ${dados_reserva}=    Set Variable    ${dados_json['reserva_sem_dados']}
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    
    ...    json=${dados_reserva}    expected_status=500
    Validar Codigo de Status    ${response}    500
    Log de Teste Finalizado    Tentar Criar Reserva Sem Dados Obrigatorios

Tentar Criar Reserva Sem Nome
    [Tags]    reserva    json    negativo
    [Documentation]    Tenta criar reserva sem firstname
    Log de Teste Iniciado    Tentar Criar Reserva Sem Nome
    Criar Sessao da API
    ${dados_json}=    Importar Dados JSON    data/json/json_reserva_ex.json
    ${dados_reserva}=    Set Variable    ${dados_json['reserva_sem_nome']}
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    
    ...    json=${dados_reserva}    expected_status=500
    Validar Codigo de Status    ${response}    500
    Log de Teste Finalizado    Tentar Criar Reserva Sem Nome

Tentar Criar Reserva Sem Datas
    [Tags]    reserva    json    negativo
    [Documentation]    Tenta criar reserva sem datas
    Log de Teste Iniciado    Tentar Criar Reserva Sem Datas
    Criar Sessao da API
    ${dados_json}=    Importar Dados JSON    data/json/json_reserva_ex.json
    ${dados_reserva}=    Set Variable    ${dados_json['reserva_sem_datas']}
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    
    ...    json=${dados_reserva}    expected_status=500
    Validar Codigo de Status    ${response}    500
    Log de Teste Finalizado    Tentar Criar Reserva Sem Datas