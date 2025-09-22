*** Settings ***
Documentation    Keywords para operações da API Restful-Booker
Library          RequestsLibrary    
Library          Collections
Library          DateTime
Resource         ../config/configuracoes.robot
Resource         comum.robot

*** Keywords ***
Criar Sessao da API
    Create Session    booker    ${BASE_URL}    timeout=${TIMEOUT}

Obter Token de Autenticacao
    &{dados_auth}=    Create Dictionary    username=${USUARIO}    password=${SENHA}
    ${response}=    Post On Session   booker    ${AUTH_ENDPOINT}    json=${dados_auth}
    Set Global Variable      ${response}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['token']}
    [Return]    ${token}

Validar Token na Resposta
    Dictionary Should Contain Key    ${response.json()}    token
    Log To Console    Token obtido: ${response.json()['token']}

Listar Todas as Reservas
    ${response}=    Get On Session    booker    ${BOOKING_ENDPOINT}
    Should Be Equal As Strings    ${response.status_code}    200
    ${reservas}=    Set Variable    ${response.json()}
    [Return]    ${reservas}

Buscar Reserva por ID
    [Arguments]    ${id_reserva}
    ${response}=    Get On Session    booker    ${BOOKING_ENDPOINT}/${id_reserva}
    Should Be Equal As Strings    ${response.status_code}    200
    ${reserva}=    Set Variable    ${response.json()}
    [Return]    ${reserva}

Criar Nova Reserva
    &{datas_reserva}=    Create Dictionary    checkin=2025-10-01    checkout=2025-10-10
    &{dados_reserva}=    Create Dictionary    
    ...    firstname=João    
    ...    lastname=Silva    
    ...    totalprice=250    
    ...    depositpaid=True    
    ...    bookingdates=${datas_reserva}    
    ...    additionalneeds=Café da manhã
    
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    json=${dados_reserva}
    Should Be Equal As Strings    ${response.status_code}    200
    ${id_reserva}=    Set Variable    ${response.json()['bookingid']}
    Set Global Variable    ${ID_RESERVA}    ${id_reserva}
    [Return]    ${id_reserva}

Criar Reserva com Dados Customizados
    [Arguments]    ${dados_reserva}
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    json=${dados_reserva}
    Should Be Equal As Strings    ${response.status_code}    200
    ${id_reserva}=    Set Variable    ${response.json()['bookingid']}
    [Return]    ${id_reserva}

Atualizar Reserva Existente
    [Arguments]    ${token}    ${id_reserva}
    &{novas_datas}=    Create Dictionary    checkin=2025-11-01    checkout=2025-11-10
    &{dados_atualizados}=    Create Dictionary    
    ...    firstname=Maria    
    ...    lastname=Santos    
    ...    totalprice=300    
    ...    depositpaid=False    
    ...    bookingdates=${novas_datas}    
    ...    additionalneeds=Jantar
    
    &{cabecalhos}=    Create Dictionary    Cookie=token=${token}
    ${response}=    PUT On Session    booker    ${BOOKING_ENDPOINT}/${id_reserva}    
    ...    json=${dados_atualizados}    headers=${cabecalhos}
    Should Be Equal As Strings    ${response.status_code}    200
    ${resposta_json}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${resposta_json['firstname']}    Maria

Excluir Reserva
    [Arguments]    ${token}    ${id_reserva}
    ${cabecalhos}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Accept=application/json    
    ...    Cookie=token=${token}
    ${response}=    DELETE On Session   booker    ${BOOKING_ENDPOINT}/${id_reserva}    headers=${cabecalhos}
    Should Be Equal As Strings    ${response.status_code}    201

Tentar Atualizar Sem Token
    [Arguments]    ${id_reserva}
    &{novas_datas}=    Create Dictionary    checkin=2025-11-01    checkout=2025-11-10
    &{dados_atualizados}=    Create Dictionary    
    ...    firstname=Carlos    
    ...    lastname=Oliveira    
    ...    totalprice=180    
    ...    depositpaid=False    
    ...    bookingdates=${novas_datas}    
    ...    additionalneeds=Wi-Fi
    ${response}=    PUT On Session    booker    ${BOOKING_ENDPOINT}/${id_reserva}    
    ...    json=${dados_atualizados}    expected_status=403
    Should Be Equal As Strings    ${response.status_code}    403

Tentar Excluir Sem Token
    [Arguments]    ${id_reserva}
    ${response}=    DELETE On Session   booker    ${BOOKING_ENDPOINT}/${id_reserva}    expected_status=403
    Should Be Equal As Strings    ${response.status_code}    403