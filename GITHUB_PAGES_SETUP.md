# GitHub Pages Setup for Universal Links

This guide will help you set up GitHub Pages to host the Universal Links files.

## Step 1: Create a GitHub Repository

1. Create a new repository on GitHub (e.g., `fanta-links` or use your existing repo)
2. Note your GitHub username and repository name

## Step 2: Update Configuration Files

You'll need to update these files with your GitHub Pages URL:

### Your GitHub Pages URL will be:
- **Project Pages**: `https://YOUR_USERNAME.github.io/REPO_NAME/`
- **User/Org Pages**: `https://YOUR_USERNAME.github.io/`

Replace `YOUR_USERNAME` and `REPO_NAME` in:
- `public/.well-known/apple-app-site-association`
- `public/.well-known/assetlinks.json`
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `lib/ui/home_screen.dart`

## Step 3: Deploy Files

### Option A: Manual Deployment
1. Copy the `public` folder contents to your GitHub repository
2. **Create a `.nojekyll` file** in the repository root (this disables Jekyll processing which can interfere with `.well-known` files)
3. Enable GitHub Pages in repository settings:
   - Go to Settings → Pages
   - Source: Deploy from a branch
   - Branch: `main` (or `master`) → `/ (root)`
   - Click Save

### Option B: GitHub Actions (Automatic)
See `.github/workflows/deploy-pages.yml` for automatic deployment on push.

## Step 4: Verify

After deployment, verify these URLs work:
- `https://YOUR_USERNAME.github.io/REPO_NAME/.well-known/apple-app-site-association`
- `https://YOUR_USERNAME.github.io/REPO_NAME/.well-known/assetlinks.json`
- `https://YOUR_USERNAME.github.io/REPO_NAME/join/test123`

## Important Notes

- **⚠️ Critical**: You must create a `.nojekyll` file in the repository root to disable Jekyll processing. Without this, `.well-known` files may not be accessible (404 errors).
- GitHub Pages uses HTTPS by default ✅
- The `.well-known` folder must be accessible
- Files are served from the repository root or `/docs` folder
- Custom domains are supported (requires DNS setup)

