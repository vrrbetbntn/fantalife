# PowerShell script to get SHA-256 fingerprint for Android
# Automatically finds keytool from Android Studio or Java installation

Write-Host "Getting SHA-256 fingerprint from debug keystore..." -ForegroundColor Cyan
Write-Host ""

$keystorePath = "$env:USERPROFILE\.android\debug.keystore"

# Try to find keytool in common locations
$keytoolPaths = @(
    "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe",
    "C:\Program Files\Android\Android Studio\jre\bin\keytool.exe",
    "$env:JAVA_HOME\bin\keytool.exe",
    "C:\Program Files\Java\*\bin\keytool.exe"
)

$keytool = $null
foreach ($path in $keytoolPaths) {
    if ($path -like "*\*") {
        # Handle wildcard paths
        $found = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($found) {
            $keytool = $found.FullName
            break
        }
    } elseif (Test-Path $path) {
        $keytool = $path
        break
    }
}

# Try to find keytool in PATH
if (-not $keytool) {
    $keytool = (Get-Command keytool -ErrorAction SilentlyContinue).Source
}

if (-not $keytool) {
    Write-Host "keytool not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Java JDK or ensure Android Studio is installed." -ForegroundColor Yellow
    Write-Host "You can also manually run:" -ForegroundColor Yellow
    Write-Host '  "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android' -ForegroundColor Gray
    exit 1
}

if (-not (Test-Path $keystorePath)) {
    Write-Host "Debug keystore not found at: $keystorePath" -ForegroundColor Red
    Write-Host "Make sure you've built at least one Android app." -ForegroundColor Yellow
    exit 1
}

Write-Host "Using keytool: $keytool" -ForegroundColor Gray
Write-Host ""

# Get the SHA-256 fingerprint
$output = & $keytool -list -v -keystore $keystorePath -alias androiddebugkey -storepass android -keypass android 2>&1

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error running keytool:" -ForegroundColor Red
    Write-Host $output
    exit 1
}

# Extract SHA-256 line
$sha256Line = $output | Select-String -Pattern "SHA256:"
if ($sha256Line) {
    Write-Host "SHA-256 Fingerprint:" -ForegroundColor Green
    Write-Host $sha256Line.Line -ForegroundColor White
    Write-Host ""
    
    # Extract just the fingerprint value (remove colons for JSON)
    $sha256Value = ($sha256Line.Line -replace ".*SHA256:\s*", "").Replace(":", "").Trim()
    
    Write-Host "Formatted for assetlinks.json:" -ForegroundColor Green
    Write-Host $sha256Value -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Copy the value above and paste it into:" -ForegroundColor Yellow
    Write-Host "public\.well-known\assetlinks.json" -ForegroundColor White
    Write-Host ""
    Write-Host "Replace 'REPLACE_WITH_YOUR_SHA256_FINGERPRINT' with the value above." -ForegroundColor Gray
} else {
    Write-Host "Could not find SHA-256 in keytool output." -ForegroundColor Red
    Write-Host "Full output:" -ForegroundColor Yellow
    Write-Host $output
}