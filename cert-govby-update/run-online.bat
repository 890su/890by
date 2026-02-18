@echo off
echo.
echo  cert-govby-update - obnovlenie sertifikatov (online)
echo  =====================================================
echo.
echo  Skript skachaet aktualnuyu versiyu s GitHub i vypolnit.
echo.

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890su/890by/main/cert-govby-update/cert-govby-update.ps1 | iex"

pause
