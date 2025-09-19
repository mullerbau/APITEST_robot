*** Settings ***   
Documentation
Library        RequestsLibrary
Resource       ../resource/api_teste.resource

*** Test Cases ***
Caso 1: DELETE Booking
    [Documentation]    Testa o endpoint de deleção de reserva.
    Criar Sessao
    ${token}=    Token de Autenticação
    ${booking_id}=    Criar reserva
    Deletar reserva    ${token}    ${booking_id}
    Log To Console    Reserva deletada com sucesso: ${booking_id}

Caso 2: DELETE Booking falha sem token
    [Documentation]    Testa o endpoint de deleção de reserva sem token.
    Criar Sessao
    ${booking_id}=    Criar reserva
    Deletar reserva sem token    ${booking_id}
    Should Be Equal As Strings    ${response.status_code}    403
    Log To Console    Tentativa de deleção sem token realizada.