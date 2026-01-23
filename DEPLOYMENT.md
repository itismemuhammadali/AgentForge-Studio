# Vercel Deployment Guide

## Prerequisites
- GitHub account
- Vercel account (free tier available)
- Flutter SDK installed locally
- Git installed

## Step 1: Prepare Your Project

1. Make sure all changes are committed:
```bash
git add .
git commit -m "Prepare for Vercel deployment"
```

2. Push to GitHub:
```bash
git push origin main
```

## Step 2: Set Up Vercel

1. Go to [vercel.com](https://vercel.com)
2. Sign up or log in with your GitHub account
3. Click "New Project"
4. Select your GitHub repository
5. Configure project settings:
   - Framework: Other (Flutter)
   - Build Command: `flutter build web --release`
   - Output Directory: `build/web`

## Step 3: Add Environment Variables

In Vercel dashboard:
1. Go to Settings → Environment Variables
2. Add the following variables:

```
FIREBASE_API_KEY=your_value
FIREBASE_AUTH_DOMAIN=your_value
FIREBASE_PROJECT_ID=your_value
FIREBASE_STORAGE_BUCKET=your_value
FIREBASE_MESSAGING_SENDER_ID=your_value
FIREBASE_APP_ID=your_value
OPENAI_API_KEY=your_value
PINECONE_API_KEY=your_value
```

## Step 4: Deploy

1. Click "Deploy"
2. Wait for the build to complete (usually 5-10 minutes)
3. Your site will be live at: `https://your-project.vercel.app`

## Step 5: Custom Domain (Optional)

1. Go to Settings → Domains
2. Add your custom domain
3. Follow DNS configuration instructions

## Troubleshooting

### Build fails with "flutter not found"
- Vercel needs Flutter SDK. The build command should handle this automatically.

### Environment variables not loading
- Make sure variables are added in Vercel dashboard
- Redeploy after adding variables

### Firebase connection issues
- Verify Firebase credentials are correct
- Check Firebase security rules allow web access
- Ensure Firebase project is properly configured

## Monitoring

- Check deployment logs in Vercel dashboard
- Monitor performance in Analytics tab
- Set up error tracking with Sentry (optional)

## Rollback

If something goes wrong:
1. Go to Deployments tab
2. Find the previous working deployment
3. Click the three dots and select "Promote to Production"
