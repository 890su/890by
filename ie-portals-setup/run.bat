@echo off
echo.
echo  IE Portals Setup - надёжные узлы
echo  ================================
echo.
echo  Добавление госпорталов в список надёжных узлов.
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0ie-portals-setup.ps1"
