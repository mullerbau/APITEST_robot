*** Settings ***
Documentation    Keywords comuns reutilizáveis
Library          OperatingSystem
Library          Collections
Library    DateTime

*** Keywords ***
Validar Codigo de Status
    [Arguments]    ${resposta}    ${codigo_esperado}
    Should Be Equal As Strings    ${resposta.status_code}    ${codigo_esperado}

Importar Dados JSON
    [Arguments]    ${caminho_arquivo}
    ${arquivo}=    Get File    ${EXECDIR}/${caminho_arquivo}
    ${dados_json}=    Evaluate    json.loads('''${arquivo}''')    json
    [Return]    ${dados_json}

Validar Reserva Criada com Sucesso
    [Arguments]    ${id_reserva}
    Should Not Be Empty    ${id_reserva}
    Should Be True    ${id_reserva} > 0
    Log To Console    Reserva validada com ID: ${id_reserva}

Gerar Timestamp
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    [Return]    ${timestamp}

Validar Resposta Contem Chave
    [Arguments]    ${resposta}    ${chave}
    Dictionary Should Contain Key    ${resposta.json()}    ${chave}

Log de Teste Iniciado
    [Arguments]    ${nome_teste}
    Log To Console    \n=== INICIANDO: ${nome_teste} ===

Log de Teste Finalizado
    [Arguments]    ${nome_teste}    ${resultado}=SUCESSO
    Log To Console    === FINALIZADO: ${nome_teste} - ${resultado} ===\n