*** Settings ***
Documentation
Library        RequestsLibrary
Resource       ../resource/api_teste.resource

*** Test Cases ***
Cenario 1: Login e Obter Token
    [Tags]    post
    [Documentation]    Testa o endpoint de autenticação e valida o token retornado.
    Criar Sessao
    ${token}=    Token de Autenticação
    Validar Token no Response
    Log To Console    Token obtido: ${token}

Caso 2: POST Booking
    [Tags]    post
    [Documentation]    Testa o endpoint de criação de reserva.
    Criar Sessao
    Criar reserva
    Listar reserva criada
    Log To Console    Reserva criada com sucesso: ${BOOKING_ID}

Caso 3: POST Booking com dados inválidos
    [Tags]    post
    [Documentation]    Testa o endpoint de criação de reserva com dados inválidos.
    Criar Sessao
    &{invalid_payload}=    Create Dictionary    firstname=1234    lastname=5678    totalprice=-100    depositpaid=maybe    bookingdates=invalid_date    additionalneeds=Breakfast
    ${response}=    Post On Session    booker    ${BOOKING_ENDPOINT}    json=${invalid_payload}
    Should Be Equal As Strings    ${response.status_code}    400
    Log To Console    Response da criação com dados inválidos: ${response.content}
    