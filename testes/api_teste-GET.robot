*** Settings ***
Documentation
Library        RequestsLibrary
Resource       ../resource/api_teste.resource

*** Test Cases ***
Caso 1: GET Booking
    [Documentation]    Testa o endpoint de obtenção de reservas.
    Criar Sessao
    Listar Reservas por ID
    Log To Console    Lista de reservas obtida com sucesso.

Caso 2: GET Booking por ID
    [Documentation]    Testa o endpoint de obtenção de reserva por ID.
    Criar Sessao
    Listar Reservas por ID especifico    ${BOOKING_ID}
    Log To Console    Reserva obtida com sucesso: ${BOOKING_ID}