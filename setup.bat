@echo off
echo ========================================
echo  SETUP DO PROJETO RESTFUL-BOOKER TESTS
echo ========================================

echo Verificando instalacao do Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python nao encontrado! Instale o Python primeiro.
    pause
    exit /b 1
)

echo Python encontrado!
echo.
echo Instalando dependencias do Robot Framework...
pip install robotframework robotframework-requests

echo.
echo Criando pasta de resultados...
if not exist "results" mkdir results

echo.
echo ========================================
echo  SETUP CONCLUIDO COM SUCESSO!
echo  Execute 'executar_testes.bat' para iniciar
echo ========================================
pause