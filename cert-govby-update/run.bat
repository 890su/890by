@echo off
:: Запрос прав администратора (UAC)
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo  cert-govby-update - obnovlenie sertifikatov
echo  ============================================
echo.
echo  Skachivaet i ustanavlivaet kornevye sertifikaty
echo  MNS, NCUE, Belstat dlya raboty s gosportalami RB.
echo  Sertifikaty sohranyayutsya v C:\ProgramData\crt-by
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0cert-govby-update.ps1"

pause
