# ============================================================
# IE Mode Setup for Microsoft Edge
# Настройка режима Internet Explorer в Microsoft Edge
# для работы с белорусскими государственными порталами
# ============================================================
# Запуск: PowerShell от администратора
# Версия: 1.0 | Февраль 2026
# GitHub: https://github.com/890su/890by
# ============================================================

#Requires -RunAsAdministrator

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " IE Mode Setup for Microsoft Edge" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# -----------------------------------------------------------
# 1. Создаём XML список сайтов для IE mode
# -----------------------------------------------------------

$xml = @'
<site-list version="1">
  <site url="e-respondent.belstat.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="e-respondent.belstat.gov.by/belstat">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="belstat.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="portal.ssf.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="portal2.ssf.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="portal2.ssf.gov.by/mainPage/">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="portal.vat.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="portal.nalog.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="vat.gov.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="oauth.uas.nces.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
  <site url="usd.nces.by">
    <compat-mode>IE11</compat-mode>
    <open-in>IE11</open-in>
  </site>
</site-list>
'@

$filePath = "C:\ProgramData\ie-site-list.xml"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

try {
    [System.IO.File]::WriteAllText($filePath, $xml, $utf8NoBom)
} catch {
    Write-Host "[ОШИБКА] Не удалось создать файл: $filePath" -ForegroundColor Red
    Write-Host "Убедитесь, что скрипт запущен от имени администратора." -ForegroundColor Yellow
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

if (Test-Path $filePath) {
    Write-Host "[OK] Файл списка сайтов создан: $filePath" -ForegroundColor Green
} else {
    Write-Host "[ОШИБКА] Файл не создан!" -ForegroundColor Red
    Read-Host "Нажмите Enter для выхода"
    exit 1
}

# -----------------------------------------------------------
# 2. Прописываем политику Edge — указываем на список сайтов
# -----------------------------------------------------------

reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v InternetExplorerIntegrationSiteList /t REG_SZ /d $filePath /f | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Политика Edge обновлена" -ForegroundColor Green
} else {
    Write-Host "[ОШИБКА] Не удалось обновить политику Edge" -ForegroundColor Red
}

# -----------------------------------------------------------
# Готово
# -----------------------------------------------------------

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Настройка завершена!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Перезапустите Microsoft Edge для применения изменений." -ForegroundColor Yellow
Write-Host ""
Write-Host "Для проверки откройте в Edge:" -ForegroundColor White
Write-Host "  edge://compat/iediagnostic" -ForegroundColor White
Write-Host ""
Write-Host "Поле 'Источник эффективного списка сайтов' должно показывать:" -ForegroundColor White
Write-Host "  file:///C:/ProgramData/ie-site-list.xml" -ForegroundColor White
Write-Host ""

Read-Host "Нажмите Enter для выхода"
