@echo off
echo.
echo  IE Mode Setup for Microsoft Edge
echo  =================================
echo.
echo  Скрипт настроит режим IE в Edge для белорусских госпорталов.
echo  Требуется запуск от имени администратора.
echo.

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo  [!] Запустите этот файл от имени администратора!
    echo      Правая кнопка мыши - "Запуск от имени администратора"
    echo.
    pause
    exit /b 1
)

powershell -ExecutionPolicy Bypass -File "%~dp0edge-ie-mode.ps1"
