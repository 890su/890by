@echo off
:: Запрос прав администратора (UAC)
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo  cert-govby-update - obnovlenie sertifikatov (online)
echo  =====================================================
echo.
echo  Skript skachaet aktualnuyu versiyu s GitHub i vypolnit.
echo  Sertifikaty sohranyayutsya v C:\ProgramData\crt-by
echo.

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890su/890by/main/cert-govby-update/cert-govby-update.ps1 | iex"

pause
