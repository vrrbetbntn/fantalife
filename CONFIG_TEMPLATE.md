# Configuration Template for GitHub Pages

Replace these placeholders in the following files:

## Placeholders to Replace:
- `YOUR_USERNAME` → Your GitHub username
- `REPO_NAME` → Your repository name (or leave empty for user pages)
- `YOUR_SHA256` → Your Android app's SHA-256 fingerprint (get once, reuse forever)
- `TEAM_ID` → Your Apple Developer Team ID

## Files to Update:

### 1. `public/.well-known/apple-app-site-association`
```json
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAM_ID.com.example.fanta",
        "paths": [
          "/join/*"
        ]
      }
    ]
  }
}
```

### 2. `public/.well-known/assetlinks.json`
```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.example.fanta",
      "sha256_cert_fingerprints": [
        "YOUR_SHA256"
      ]
    }
  }
]
```

### 3. `android/app/src/main/AndroidManifest.xml`
Find the HTTPS intent filter and update:
```xml
<data android:scheme="https" 
      android:host="YOUR_USERNAME.github.io" 
      android:pathPrefix="/REPO_NAME/join"/>
```
(Remove `/REPO_NAME` if using user pages)

### 4. `ios/Runner/Info.plist`
Update the associated domain:
```xml
<string>applinks:YOUR_USERNAME.github.io</string>
```

### 5. `lib/ui/home_screen.dart`
Update the share URL:
```dart
final shareUrl = 'https://YOUR_USERNAME.github.io/REPO_NAME/join/$_activeGroupId';
```
(Remove `/REPO_NAME` if using user pages)

### 6. `lib/main.dart`
Update the deep link handler to match your GitHub Pages URL.

