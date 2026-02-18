@echo off
echo.
echo  IE Mode Setup for Microsoft Edge (online)
echo  ==========================================
echo.
echo  Скрипт скачает актуальную версию с GitHub и выполнит.
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

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890su/890by/main/edge-ie-mode/edge-ie-mode.ps1 | iex"
