@echo off
echo.
echo  cert-govby-update - обновление сертификатов (online)
echo  =====================================================
echo.
echo  Скрипт скачает актуальную версию с GitHub и выполнит.
echo.

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890by/support-tools/main/cert-govby-update/cert-govby-update.ps1 | iex"

pause
