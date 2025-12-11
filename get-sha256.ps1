# PowerShell script to get SHA-256 fingerprint for Android
# Run this script to get your debug keystore fingerprint

Write-Host "Getting SHA-256 fingerprint from debug keystore..." -ForegroundColor Cyan
Write-Host ""

$keystorePath = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $keystorePath) {
    keytool -list -v -keystore $keystorePath -alias androiddebugkey -storepass android -keypass android | Select-String -Pattern "SHA256"
    Write-Host ""
    Write-Host "Copy the SHA-256 value above and paste it into:" -ForegroundColor Green
    Write-Host "public\.well-known\assetlinks.json" -ForegroundColor Yellow
} else {
    Write-Host "Debug keystore not found at: $keystorePath" -ForegroundColor Red
    Write-Host "Make sure you've built at least one Android app." -ForegroundColor Yellow
}

