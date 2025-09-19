*** Settings ***
Documentation       Testes da API Restful-Booker
Resource            ../resource/api_teste.resource
Resource            ../variaveis/variaveis_globais.robot

*** Test Cases ***
Cenario: Criar e Gerir uma Reserva Completa
    Criar Sessao
    

    ${booking_id}=    Criar reserva
    

    ${token}=    Token de Autenticação
    Atualizar Reserva    ${token}    ${booking_id}
    

    Deletar reserva    ${token}    ${booking_id}