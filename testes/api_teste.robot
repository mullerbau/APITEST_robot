*** Settings ***
Documentation
Library        RequestsLibrary
Resource       ../resource/api_teste.resource


*** Test Cases ***
Cenario 1: Login e Obter Token
    [Documentation]    Testa o endpoint de autenticação e valida o token retornado.
    Criar Sessao
    ${token}=    Token de Autenticação
    Validar Token no Response
    Log To Console    Token obtido: ${token}

Caso 2: GET Booking
    [Documentation]    Testa o endpoint de obtenção de reservas.
    Criar Sessao
    Listar Reservas por ID
    Log To Console    Lista de reservas obtida com sucesso.

Caso 3: GET Booking por ID
    [Documentation]    Testa o endpoint de obtenção de reserva por ID.
    Criar Sessao
    Listar Reservas por ID especifico    ${BOOKING_ID}
    Log To Console    Reserva obtida com sucesso: ${BOOKING_ID}

Caso 4: POST Booking
    [Documentation]    Testa o endpoint de criação de reserva.
    Criar Sessao
    Criar reserva
    Listar reserva criada
    Log To Console    Reserva criada com sucesso: ${BOOKING_ID}

Caso 5: PUT Update Booking
    [Documentation]    Testa o endpoint de atualização de reserva.
    Criar Sessao
    ${token}=    Token de Autenticação
    ${booking_id}=    Criar reserva
    Atualizar reserva    ${token}    ${booking_id}
    Log To Console    Reserva atualizada com sucesso: ${booking_id}

Caso 6: DELETE Booking
    [Documentation]    Testa o endpoint de deleção de reserva.
    Criar Sessao
    ${token}=    Token de Autenticação
    ${booking_id}=    Criar reserva
    Deletar reserva    ${token}    ${booking_id}
    Log To Console    Reserva deletada com sucesso: ${booking_id}
