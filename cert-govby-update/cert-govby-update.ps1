# --- НАСТРОЙКИ ---

# Каталог, куда будут загружены файлы
$baseFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadFolder = Join-Path $baseFolder "cert"

# Создать подкаталог 'cert', если его нет
New-Item -ItemType Directory -Path $downloadFolder -Force | Out-Null

# Список URL сертификатов
$certUrls = @(
    "http://www.portal.nalog.gov.by/ca/mns_root.cer",
    "http://www.portal.nalog.gov.by/ca/mns_work.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/kuc1.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/kuc2.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/ruc1.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/ruc2.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/ruc3.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/cas_ruc2.cer",
    "https://nces.by/wp-content/uploads/certificates/pki/cas_ruc3.cer"
)

# Список URL для CRL
$crlUrls = @(
    "http://www.portal.nalog.gov.by/ca/mns-ca.crl",
    "http://www.portal.nalog.gov.by/ca/mns-ra.crl",
    "https://nces.by/wp-content/uploads/certificates/pki/kuc1.crl",
    "https://nces.by/wp-content/uploads/certificates/pki/kuc2.crl",
    "https://nces.by/wp-content/uploads/certificates/pki/ruc2.crl",
    "https://nces.by/wp-content/uploads/certificates/pki/ruc3.crl",
    "https://nces.by/wp-content/uploads/certificates/pki/cas_ruc2.crl",
    "https://nces.by/wp-content/uploads/certificates/pki/cas_ruc3.crl"
)

# URL и имя p7b-файла
$p7bUrl = "http://e-respondent.belstat.gov.by/belstat/resources/files/belstat.p7b"
$p7bFile = Join-Path $downloadFolder "belstat.p7b"

# --- СКАЧИВАЕМ СЕРТИФИКАТЫ ---
Write-Host "Скачиваем сертификаты..." -ForegroundColor Cyan
foreach ($url in $certUrls) {
    $fileName = Split-Path $url -Leaf
    $outPath = Join-Path $downloadFolder $fileName
    Invoke-WebRequest -Uri $url -OutFile $outPath
    Write-Host "Скачан: $fileName"
}

# --- СКАЧИВАЕМ CRL ---
Write-Host "Скачиваем CRL..." -ForegroundColor Cyan
foreach ($url in $crlUrls) {
    $fileName = Split-Path $url -Leaf
    $outPath = Join-Path $downloadFolder $fileName
    Invoke-WebRequest -Uri $url -OutFile $outPath
    Write-Host "Скачан: $fileName"
}

# --- СКАЧИВАЕМ belstat.p7b ---
Write-Host "Скачиваем belstat.p7b..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $p7bUrl -OutFile $p7bFile
Write-Host "Скачан: belstat.p7b"

# --- УСТАНОВКА .CER ФАЙЛОВ ---
$certFiles = Get-ChildItem -Path $downloadFolder -Filter *.cer
foreach ($cert in $certFiles) {
    try {
        $certObj = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
        $certObj.Import($cert.FullName)

        $store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "CurrentUser"
        $store.Open("ReadWrite")
        $store.Add($certObj)
        $store.Close()

        Write-Host "Добавлен: $($cert.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Ошибка с файлом: $($cert.Name) — $($_.Exception.Message)" -ForegroundColor Red
    }
}

# --- УСТАНОВКА ИЗ P7B ---
Write-Host "Импортируем сертификаты из belstat.p7b..." -ForegroundColor Cyan
try {
    $collection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
    $collection.Import($p7bFile)

    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "CurrentUser"
    $store.Open("ReadWrite")
    foreach ($cert in $collection) {
        $store.Add($cert)
        Write-Host "Добавлен из P7B: $($cert.Subject)" -ForegroundColor Green
    }
    $store.Close()
} catch {
    Write-Host "Ошибка импорта P7B: $($_.Exception.Message)" -ForegroundColor Red
}

# --- ИМПОРТ CRL ---
Write-Host "Импорт CRL..." -ForegroundColor Cyan
$crlFiles = Get-ChildItem -Path $downloadFolder -Filter *.crl
foreach ($crl in $crlFiles) {
    try {
        certutil -addstore -user CA $crl.FullName
        Write-Host "Импортирован CRL: $($crl.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Ошибка при импорте CRL: $($crl.Name)" -ForegroundColor Red
    }
}

Write-Host "`nГотово!" -ForegroundColor Yellow
