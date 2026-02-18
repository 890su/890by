@echo off
echo.
echo  IE Portals Setup - надёжные узлы (online)
echo  =========================================
echo.
echo  Скрипт скачает актуальную версию с GitHub и выполнит.
echo.

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890by/support-tools/main/ie-portals-setup/ie-portals-setup.ps1 | iex"
