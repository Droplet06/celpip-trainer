# CELPIP Trainer

A mobile-friendly daily practice app for CELPIP exam prep.

## Deploy to GitHub Pages

1. Create a new **public** GitHub repository (e.g. `celpip-trainer`)
2. Push this folder's contents to the `main` branch:

```bash
cd web-app
git init
git add .
git commit -m "Initial deploy"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/celpip-trainer.git
git push -u origin main
```

3. Go to repo **Settings → Pages**
4. Under **Source**, select **GitHub Actions**
5. The workflow runs automatically — your app will be live at:
   `https://YOUR_USERNAME.github.io/celpip-trainer/`

## Features

- 3 daily sessions: Vocabulary → Reading → Writing
- Sessions unlock in order (complete one to unlock the next)
- XP system with 5 levels
- Day streak tracking
- 7-day activity strip + 28-day calendar
- 150-word vocab bank with status tracking (new / reviewing / mastered)
- All data stored in browser localStorage (no account needed)
- Works offline after first load

## Data Files

- `data/vocab.json` — 150 vocabulary words with quiz questions
- `data/reading.json` — 10 reading passages with 3 questions each
- `data/writing.json` — 20 writing prompts (Task 1 and Task 2)
