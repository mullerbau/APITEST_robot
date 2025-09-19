*** Settings ***
Documentation  Testes de API com Robot Framework - Endpoint /booking
Library        RequestsLibrary    
Library        Collections
Resource       ../variaveis/variaveis_globais.robot


*** Keywords ***
Criar Sessao
    Create Session    booker    ${BASE_URL}    
Token de Autenticação
    &{auth_payload}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    Post On Session   booker    ${AUTH_ENDPOINT}    json=${auth_payload}
    Set Global Variable      ${response}
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['token']}
    [Return]    ${token}
Validar Token no Response
    Dictionary Should Contain Key    ${response.json()}    token
    Log To Console    Token: ${response.json()['token']}

Listar Reservas por ID
    ${response}=    Get On Session    booker    ${BOOKING_ENDPOINT}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Response: ${response.content}
    ${bookings}=    Set Variable    ${response.json()}
    [Return]    ${bookings}

Listar Reservas por ID especifico
    [Arguments]    ${booking_id}
    ${response}=    Get On Session    booker    ${BOOKING_ENDPOINT}/${booking_id}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Response: ${response.content}
    ${booking}=    Set Variable    ${response.json()}
    [Return]    ${booking}


Criar reserva
    &{booking_dates}=    Create Dictionary    checkin=2025-10-01    checkout=2025-10-10
    
    &{booking_payload}=    Create Dictionary    firstname=salve    lastname=brother    totalprice=138    depositpaid=True    bookingdates=${booking_dates}    additionalneeds=Breakfast
    
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    json=${booking_payload}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Response: ${response.content}
    ${booking_id}=    Set Variable    ${response.json()['bookingid']}
    Set Global Variable    ${BOOKING_ID}    ${booking_id}
    [Return]    ${booking_id}


Listar reserva criada
    ${response}=    Get On Session    booker    ${BOOKING_ENDPOINT}/${BOOKING_ID}
    Should Be Equal As Strings    ${response.status_code}    200

Atualizar reserva
    [Arguments]    ${token}    ${booking_id}
    
    &{booking_dates}=    Create Dictionary    checkin=2025-11-01    checkout=2025-11-10
    &{updated_payload}=    Create Dictionary    firstname=Eric    lastname=bruxo    totalprice=200    depositpaid=False    bookingdates=${booking_dates}    additionalneeds=Lanche
    
    &{headers}=    Create Dictionary    Cookie=token=${token}
    
    ${response}=    PUT On Session    booker    ${BOOKING_ENDPOINT}/${booking_id}    json=${updated_payload}    headers=${headers}
    
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Response da atualização: ${response.content}
    
    ${response_json}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${response_json['firstname']}    Eric

Deletar reserva
    [Arguments]    ${token}    ${booking_id}
    ${headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json    Cookie=token=${token}
    ${response}=    DELETE On Session   booker    ${BOOKING_ENDPOINT}/${booking_id}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Response: ${response.content}
    

Atualizar reserva sem token
    [Arguments]    ${booking_id}
    &{booking_dates}=    Create Dictionary    checkin=2025-11-01    checkout=2025-11-10
    &{updated_payload}=    Create Dictionary    firstname=Eric    lastname=bruxo    totalprice=200    depositpaid=False    bookingdates=${booking_dates}    additionalneeds=Lanche
    ${response}=    PUT On Session    booker    ${BOOKING_ENDPOINT}/${booking_id}    json=${updated_payload}
    Should Be Equal As Strings    ${response.status_code}    403
    Log To Console    Response da atualização sem token: ${response.content}

Deletar reserva sem token
    [Arguments]    ${booking_id}
    ${response}=    DELETE On Session   booker    ${BOOKING_ENDPOINT}/${booking_id}
    Should Be Equal As Strings    ${response.status_code}    403
    Log To Console    Response da deleção sem token: ${response.content}