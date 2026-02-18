@echo off
echo.
echo  IE Portals Setup - nadyozhnye uzly (online)
echo  ===========================================
echo.
echo  Skript skachaet aktualnuyu versiyu s GitHub i vypolnit.
echo.

powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/890su/890by/main/ie-portals-setup/ie-portals-setup.ps1 | iex"
