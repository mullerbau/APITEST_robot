@echo off
echo ========================================
echo  TESTES API RESTFUL-BOOKER - ROBOT FRAMEWORK
echo ========================================

:menu
echo.
echo Escolha uma opcao:
echo 1. Executar todos os testes
echo 2. Executar testes de autenticacao
echo 3. Executar testes CRUD de reservas
echo 4. Executar testes com dados JSON
echo 5. Executar testes de integracao
echo 6. Executar apenas testes positivos
echo 7. Executar apenas testes negativos
echo 8. Sair
echo.
set /p opcao="Digite sua opcao (1-8): "

if "%opcao%"=="1" goto todos
if "%opcao%"=="2" goto auth
if "%opcao%"=="3" goto crud
if "%opcao%"=="4" goto json
if "%opcao%"=="5" goto integracao
if "%opcao%"=="6" goto positivos
if "%opcao%"=="7" goto negativos
if "%opcao%"=="8" goto sair
echo Opcao invalida!
goto menu

:todos
echo Executando todos os testes...
robot -d ./results suites/
goto fim

:auth
echo Executando testes de autenticacao...
robot -d ./results suites/api/teste_autenticacao.robot
goto fim

:crud
echo Executando testes CRUD de reservas...
robot -d ./results suites/api/teste_reservas_crud.robot
goto fim

:json
echo Executando testes com dados JSON...
robot -d ./results suites/api/teste_dados_json.robot
goto fim

:integracao
echo Executando testes de integracao...
robot -d ./results suites/integracao/
goto fim

:positivos
echo Executando apenas testes positivos...
robot -d ./results -i positivo suites/
goto fim

:negativos
echo Executando apenas testes negativos...
robot -d ./results -i negativo suites/
goto fim

:fim
echo.
echo ========================================
echo  Testes concluidos!
echo  Relatorios disponiveis em: ./results/
echo ========================================
pause
goto menu

:sair
echo Saindo...
exit