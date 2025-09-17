*** Settings ***
Documentation
Library        RequestsLibrary    
Library    Collections


*** Variables ***
${BASE_URL}              https://reqres.in/api
${USERS_ENDPOINT}        /users
${REGISTER_ENDPOINT}     /register
${LOGIN_ENDPOINT}        /login
${API_KEY}               reqres-free-v1


*** Keywords ***
Criar Sessao
    Create Session    reqres    https://reqres.in/api

GET Endpoint /users
    ${response}    GET On Session    reqres    /users
    Set Global Variable   ${response}

Validar Status Code "${status_code}"
    Should Be True    ${response.status_code} == ${status_code}

POST Endpoint /register
    &{payload}=    Create Dictionary    username=Teste
    ...    email=teste@example.com
    ...    password=123456
    ${response}    POST On Session    reqres    ${REGISTER_ENDPOINT}    json=${payload}
    Log To Console    Response: ${response.content}
    Set Global Variable   ${response}

POST Login /login
    &{payload}=    Create Dictionary    email=eve.holt@reqres.in    password=cityslicka
    ${response} =    POST On Session    reqres    ${LOGIN_ENDPOINT}    json=${payload}
    Set Global Variable   ${response}
    Log To Console    Response: ${response.content}

Validar Token no Response
    Dictionary Should Contain Key    ${response.json()}    token
    Log To Console    Token: ${response.json()['token']}

