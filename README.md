# Universal Links Setup

This directory contains static files to enable clickable Universal Links in WhatsApp and other messaging apps.

## ⚠️ Important: SHA-256 Fingerprint

**You do NOT need to update the SHA-256 fingerprint every time you build!**

The SHA-256 fingerprint is tied to your **keystore**, not your build:
- **Debug builds**: Always use the same debug keystore → Same SHA-256 (get it once)
- **Release builds**: Use your release keystore → Same SHA-256 as long as you use the same keystore

**You only need to update it if:**
- You change your keystore
- You want to support both debug AND release builds (add both fingerprints)

## Setup Instructions

### 1. Get Your Android SHA-256 Fingerprint (Once!)

**For Debug builds:**
```bash
# Windows
keytool -list -v -keystore %USERPROFILE%\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android

# Mac/Linux
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

**For Release builds:**
```bash
keytool -list -v -keystore /path/to/your/keystore.jks -alias your-key-alias
```

Copy the **SHA-256** fingerprint (not SHA-1) and update `assetlinks.json`.

### 2. Update iOS Team ID

In `apple-app-site-association`, replace `TEAM_ID` with your Apple Developer Team ID.

### 3. Choose Your Hosting

#### Option A: Firebase Hosting
```bash
firebase deploy --only hosting
```

#### Option B: GitHub Pages
See `GITHUB_PAGES_SETUP.md` for instructions.

### 4. Verify the Files

After deployment, verify these URLs are accessible:
- `https://your-domain.com/.well-known/apple-app-site-association`
- `https://your-domain.com/.well-known/assetlinks.json`
- `https://your-domain.com/join/test123` (should redirect)

### 5. Test Universal Links

- **Android**: Use the App Links Tester app or test via ADB
- **iOS**: Long-press a link in Notes app or Safari

## How It Works

1. User shares: `https://your-domain.com/join/{groupId}`
2. WhatsApp recognizes it as a clickable HTTPS link
3. When clicked:
   - If app is installed: Opens directly in the app
   - If app is not installed: Shows the redirect page with the group code

## Notes

- The redirect page (`join.html`) automatically tries to open the app via deep link
- If the app doesn't open, it shows the group code for manual entry
- All files are static - no backend required!

