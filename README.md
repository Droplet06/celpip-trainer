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
- Batch vocabulary study followed by a mixed quiz instead of one-word immediate checks
- CELPIP-style reading practice rotating through correspondence, diagram/application, information, and viewpoints formats
- Template-generated Task 1 / Task 2 writing prompts
- Rule-based CELPIP-style writing assessment for task coverage, structure, vocabulary, readability, and task fulfillment
- Browser text-to-speech buttons for vocabulary words, example sentences, and quiz prompts
- Supabase Auth sign-in for cross-device progress sync
- Mistake log for missed vocabulary/reading choices and writing weak-pattern feedback
- Signed-in progress syncs through Supabase, with browser localStorage kept as a local cache
- Works offline after first load

## Supabase Auth Setup

1. In Supabase, open **Authentication → Providers** and make sure Email is enabled.
2. In **Authentication → URL Configuration**, add your GitHub Pages URL and local preview URL to redirect URLs:
   - `http://127.0.0.1:8000`
   - your deployed GitHub Pages URL
3. Run `supabase_schema.sql` in the Supabase SQL Editor so the auth-safe row policies, `vocab_order` column, and `mistake_log` table are installed.

## Change Log

See `CHANGELOG.md` for reviewer-facing notes on recent behavior changes.

## Data Files

- `data/vocab.json` — 150 vocabulary words with quiz questions
- `data/reading.json` — 22 reading passages with 4 questions each; part 0 = general info article (10), part 1 = correspondence (3), part 2 = diagram/table (3), part 3 = reading for information A/B/C/D paragraphs (3), part 4 = viewpoints (3)
- `data/writing.json` — 20 writing prompts (Task 1 and Task 2)
