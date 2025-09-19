*** Settings ***
Documentation
Library        RequestsLibrary
Resource       ../resource/api_teste.resource

*** Test Cases ***
Caso 1: PUT Update Booking
    [Documentation]    Testa o endpoint de atualização de reserva.
    Criar Sessao
    ${token}=    Token de Autenticação
    ${booking_id}=    Criar reserva
    Atualizar reserva    ${token}    ${booking_id}
    Log To Console    Reserva atualizada com sucesso: ${booking_id}

Caso 2: PUT Update Booking falha sem token
    [Documentation]    Testa o endpoint de atualização de reserva sem token.
    Criar Sessao
    ${booking_id}=    Criar reserva
    Atualizar reserva sem token    ${booking_id}
    Should Be Equal As Strings    ${response.status_code}    403
    Log To Console    Tentativa de atualização sem token realizada.

Caso 3: PUT Update Booking com dados inválidos
    [Documentation]    Testa o endpoint de atualização de reserva com dados inválidos.
    Criar Sessao
    ${token}=    Token de Autenticação
    ${booking_id}=    Criar reserva
    &{invalid_payload}=    Create Dictionary    firstname=1234    lastname=5678    totalprice=-100    depositpaid=maybe    bookingdates=invalid_date    additionalneeds=Breakfast
    ${response}=    PUT On Session    booker    ${BOOKING_ENDPOINT}/${booking_id}    json=${invalid_payload}    headers={"Cookie": "token=${token}"}
    Should Be Equal As Strings    ${response.status_code}    400
    Log To Console    Response da atualização com dados inválidos: ${response.content}