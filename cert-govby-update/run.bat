@echo off
echo.
echo  cert-govby-update - обновление сертификатов
echo  ============================================
echo.
echo  Скачивает и устанавливает корневые сертификаты
echo  МНС, НЦЭУ, Белстат для работы с госпорталами РБ.
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0cert-govby-update.ps1"

pause
