@echo off
echo.
echo  cert-govby-update - obnovlenie sertifikatov
echo  ============================================
echo.
echo  Skachivaet i ustanavlivaet kornevye sertifikaty
echo  MNS, NCUE, Belstat dlya raboty s gosportalami RB.
echo  Sertifikaty sohranyayutsya v %LOCALAPPDATA%\crt-by
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0cert-govby-update.ps1"

pause
