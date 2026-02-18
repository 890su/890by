@echo off
echo.
echo  IE Portals Setup - nadyozhnye uzly (Trusted Sites)
echo  ==================================================
echo.
echo  Dobavlenie gosportalov v spisok nadyozhnyh uzlov.
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0ie-portals-setup.ps1"
