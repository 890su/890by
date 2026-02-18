# ============================================================
# IE Portals Setup — надёжные узлы (Trusted Sites)
# Добавление белорусских госпорталов в список надёжных узлов
# ============================================================
# Запуск: PowerShell от администратора (или от пользователя — HKCU)
# Версия: 1.0 | Февраль 2026
# GitHub: https://github.com/890su/890by
# ============================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " IE Portals — надёжные узлы (Trusted Sites)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# -----------------------------------------------------------
# 1. Добавляем сайты в надёжные узлы (Trusted Sites)
# -----------------------------------------------------------

Write-Host "Добавление в надёжные узлы..." -ForegroundColor Cyan

$trustedSites = @(
    "*.vat.gov.by",
    "*.nalog.gov.by",
    "*.ssf.gov.by",
    "*.usd.nces.by",
    "*.uas.nces.by",
    "*.nces.by",
    "*.belstat.gov.by"
)

$regBase = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains"

foreach ($site in $trustedSites) {
    $domain = $site.TrimStart("*.")
    $parts = $domain.Split(".")

    # Строим путь в реестре: ssf.gov.by -> Domains\by\gov\ssf
    $path = $regBase
    for ($i = $parts.Count - 1; $i -ge 0; $i--) {
        $path = "$path\$($parts[$i])"
    }

    # Проверяем — если уже добавлен, пропускаем
    if (Test-Path $path) {
        $existing = Get-ItemProperty -Path $path -Name "https" -ErrorAction SilentlyContinue
        if ($existing -and $existing.https -eq 2) {
            Write-Host "  [=] $site — уже добавлен, пропускаем" -ForegroundColor Yellow
            continue
        }
    } else {
        New-Item -Path $path -Force | Out-Null
    }

    New-ItemProperty -Path $path -Name "https" -Value 2 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $path -Name "http"  -Value 2 -PropertyType DWord -Force | Out-Null
    Write-Host "  [+] $site" -ForegroundColor Green
}

# -----------------------------------------------------------
# 2. Снимаем галочку "Требовать HTTPS для всех сайтов"
# -----------------------------------------------------------

$zoneSettingsPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2"
New-ItemProperty -Path $zoneSettingsPath -Name "2200" -Value 3 -PropertyType DWord -Force | Out-Null
Write-Host "[OK] Требование HTTPS для надёжных узлов отключено" -ForegroundColor Green

# -----------------------------------------------------------
# Готово
# -----------------------------------------------------------

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Настройка завершена!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Перезапустите браузер для применения изменений." -ForegroundColor Yellow
Write-Host ""

Read-Host "Нажмите Enter для выхода"
