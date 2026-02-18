@echo off
echo.
echo  IE Mode Setup for Microsoft Edge (online)
echo  ==========================================
echo.
echo  Skript skachaet aktualnuyu versiyu s GitHub i vypolnit.
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

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890su/890by/main/edge-ie-mode/edge-ie-mode.ps1 | iex"
