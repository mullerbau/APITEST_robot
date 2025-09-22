*** Settings ***
Documentation    Testes de integração com fluxo completo
Resource         ../../keywords/api_keywords.robot
Resource         ../../keywords/comum.robot

*** Test Cases ***
Fluxo Completo CRUD de Reserva
    [Tags]    integracao    crud    fluxo_completo
    [Documentation]    Executa fluxo completo: Criar → Ler → Atualizar → Excluir
    Log de Teste Iniciado    Fluxo Completo CRUD de Reserva
    
    # Setup
    Criar Sessao da API
    ${token}=    Obter Token de Autenticacao
    
    # 1. Criar reserva
    Log To Console    1. Criando nova reserva...
    ${id_reserva}=    Criar Nova Reserva
    Validar Reserva Criada com Sucesso    ${id_reserva}
    
    # 2. Ler reserva criada
    Log To Console    2. Lendo reserva criada...
    ${reserva}=    Buscar Reserva por ID    ${id_reserva}
    Should Be Equal As Strings    ${reserva['firstname']}    João
    Should Be Equal As Strings    ${reserva['lastname']}    Silva
    
    # 3. Atualizar reserva
    Log To Console    3. Atualizando reserva...
    Atualizar Reserva Existente    ${token}    ${id_reserva}
    ${reserva_atualizada}=    Buscar Reserva por ID    ${id_reserva}
    Should Be Equal As Strings    ${reserva_atualizada['firstname']}    Maria
    
    # 4. Excluir reserva
    Log To Console    4. Excluindo reserva...
    Excluir Reserva    ${token}    ${id_reserva}
    
    # 5. Verificar exclusão
    Log To Console    5. Verificando exclusão...
    ${response}=    Get On Session    booker    ${BOOKING_ENDPOINT}/${id_reserva}    expected_status=404
    Should Be Equal As Strings    ${response.status_code}    404
    
    Log de Teste Finalizado    Fluxo Completo CRUD de Reserva

Teste de Multiplas Reservas
    [Tags]    integracao    multiplas_reservas
    [Documentation]    Cria múltiplas reservas e valida todas
    Log de Teste Iniciado    Teste de Multiplas Reservas
    
    Criar Sessao da API
    ${token}=    Obter Token de Autenticacao
    
    # Criar 3 reservas
    @{ids_reservas}=    Create List
    FOR    ${i}    IN RANGE    3
        ${id_reserva}=    Criar Nova Reserva
        Append To List    ${ids_reservas}    ${id_reserva}
        Log To Console    Reserva ${i+1} criada com ID: ${id_reserva}
    END
    
    # Validar todas as reservas
    FOR    ${id_reserva}    IN    @{ids_reservas}
        ${reserva}=    Buscar Reserva por ID    ${id_reserva}
        Should Not Be Empty    ${reserva}
        Should Be Equal As Strings    ${reserva['firstname']}    João
    END
    
    # Limpar reservas criadas
    FOR    ${id_reserva}    IN    @{ids_reservas}
        Excluir Reserva    ${token}    ${id_reserva}
        Log To Console    Reserva ${id_reserva} excluída
    END
    
    Log de Teste Finalizado    Teste de Multiplas Reservas