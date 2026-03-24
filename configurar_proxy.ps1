@echo off
setlocal

:: Solicita a senha
set /p SENHA=Digite sua senha: 

:: Define as variáveis de proxy
set LOGIN=x215607
set IP_PROXY=10.10.190.25
set PORT_PROXY=3128

:: Cria a string de proxy
set PROXY=http://%LOGIN%:%SENHA%@%IP_PROXY%:%PORT_PROXY%

:: Altera as variáveis de ambiente do sistema
setx HTTP_PROXY "%PROXY%"
setx HTTPS_PROXY "%PROXY%"

:: Configura o proxy para pip e npm
pip config set global.proxy "%PROXY%"
::npm config set proxy "%PROXY%"
::npm config set https-proxy "%PROXY%"

 echo Variáveis de ambiente HTTP_PROXY e HTTPS_PROXY configuradas com sucesso!

:: Script para atualizar credenciais de tarefas agendadas após mudança de senha

echo _________________________________________________________________
echo ATUALIZADOR DE TAREFAS AGENDADAS - WINDOWS 11

:: Verifica privilégios de admin
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERRO: Execute como Administrador!
    pause
    exit /b
)

:: Executa script PowerShell
powershell.exe -ExecutionPolicy Bypass -File "D:\Users\x215607\Desktop\bat\AtualizarTarefas.ps1" -username "%LOGIN%" -password "%SENHA%"

pause
