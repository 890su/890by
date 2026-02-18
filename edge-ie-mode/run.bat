@echo off
echo.
echo  IE Mode Setup for Microsoft Edge
echo  =================================
echo.
echo  Skript nastroit rezhim IE v Edge dlya belorusskih gosportalov.
echo  Trebuetsya zapusk ot imeni administratora.
echo.

:: Proverka prav administratora
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo  [!] Zapustite etot fayl ot imeni administratora!
    echo      Pravaya knopka myshi - "Zapusk ot imeni administratora"
    echo.
    pause
    exit /b 1
)

powershell -ExecutionPolicy Bypass -File "%~dp0edge-ie-mode.ps1"
