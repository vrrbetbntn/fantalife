# Quick Start Guide

## Answer to Your Questions

### ✅ Can I use GitHub Pages?
**Yes!** GitHub Pages is free and works perfectly for static Universal Links. See `GITHUB_PAGES_SETUP.md` for setup.

### ✅ Do I need to update SHA-256 every build?
**No!** The SHA-256 fingerprint is tied to your **keystore**, not your build:
- **Debug builds**: Same keystore → Same SHA-256 (get it once, use forever)
- **Release builds**: Same keystore → Same SHA-256 (get it once, use forever)

You only update it if you change keystores or want to support both debug AND release.

## Quick Setup Steps

### 1. Get SHA-256 (One Time Only)

**Windows:**
```powershell
cd public
.\get-sha256.ps1
```

**Mac/Linux:**
```bash
cd public
chmod +x get-sha256.sh
./get-sha256.sh
```

**Or manually:**
```bash
# Debug keystore
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# Look for "SHA256:" line and copy that value
```

### 2. Update `assetlinks.json`

Replace `REPLACE_WITH_YOUR_SHA256_FINGERPRINT` with the SHA-256 value you got.

### 3. Choose Hosting

**Option A: GitHub Pages** (Free, Recommended)
1. Create a GitHub repo
2. Copy `public/` folder contents to repo root
3. Enable GitHub Pages in repo settings
4. Update all config files with your GitHub Pages URL (see `CONFIG_TEMPLATE.md`)

**Option B: Firebase Hosting**
```bash
firebase deploy --only hosting
```

### 4. Update App Configuration

Update these files with your hosting URL:
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `lib/ui/home_screen.dart`
- `lib/main.dart`

See `CONFIG_TEMPLATE.md` for exact locations.

### 5. Deploy & Test

After deployment, test the links work!

## Summary

- ✅ GitHub Pages works great (free, static hosting)
- ✅ SHA-256 is per-keystore, not per-build
- ✅ Get SHA-256 once, reuse forever (unless you change keystores)
- ✅ All files are static (no backend needed)

