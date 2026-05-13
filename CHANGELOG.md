# Change Log

## 2026-05-09

### Vocabulary learning flow
- Changed Session 1 from "study one word, immediately quiz that word" to "study a 5-word batch, then take a mixed quiz".
- The mixed quiz now includes today's 5 words plus available reviewing/mastered words, up to 8 questions total.
- Quiz options are generated from nearby vocabulary items with similar part of speech, category, or difficulty, so distractors are less obvious than the original fixed options.
- Incorrect answers keep the tested word in reviewing status; correct answers continue to move words from new to reviewing, and from reviewing to mastered.

### Audio support
- Added browser text-to-speech buttons for vocabulary words, example sentences, and vocabulary quiz prompts.
- Audio uses the browser's built-in `SpeechSynthesisUtterance` with `en-CA` pronunciation and a slightly slower rate.
- Playback is user-triggered only; there is no automatic audio.

### UI copy
- Updated the Session 1 description to clarify the new batch-study plus mixed-quiz flow.

### Follow-up adjustment
- Restored single-card vocabulary study: words are shown one at a time again, but the quiz still starts only after the full 5-word set has been reviewed.

### Vocabulary ordering
- Added a stable shuffled vocabulary order so the learner no longer starts with dictionary-style A/B/C sequencing.
- Session 1 word batches and the Word Bank tab now use the same shuffled order.
- The shuffled order is saved locally and only adds newly introduced vocabulary IDs later, so refreshes do not reshuffle the whole list.

### Warm cat theme
- Updated the visual theme from cool purple/blue to a warmer coral, amber, cream, and soft mint palette.
- Added light cat/paw branding touches in the nav, level badges, and vocabulary session icon.
- Kept the existing layout and learning flow unchanged while softening buttons, progress bars, and background tones.

### Light theme refinement
- Changed the warm cat theme from a dark warm background to a light cream background.
- Adjusted cards, nav, tab bar, completed session states, overlay, and confetti colors to match the lighter palette.

## 2026-05-12

### Account login and cross-device sync
- Added a Supabase Auth sign-in gate with email/password account creation, email/password sign-in, and magic-link sign-in.
- Replaced the old per-browser random sync ID with the authenticated Supabase user ID, enabling progress sync across devices.
- On first login, the app uploads existing browser progress if no cloud progress exists for that account.
- Added sign-out from the top navigation account button.
- Updated sync to include `vocab_order` when the database has the new column.

### Supabase schema
- Added `vocab_order` to `user_state` so the stable shuffled vocabulary order can sync across devices.
- Updated row-level security policies so authenticated users can only access rows where `user_id` matches their Supabase Auth user ID.

### Mistake tracking
- Added a `mistake_log` table for cross-device weak-point tracking.
- Vocabulary and reading multiple-choice mistakes now record the question, chosen answer, correct answer, and context.
- Writing feedback now records weak-pattern events such as task length, paragraph/coherence issues, vocabulary repetition, and readability/punctuation issues.
- Added a Recent Mistakes section to the Progress tab so learners can see whether recent problems came from quiz choices or writing feedback.

## 2026-05-13

### Reading passage bank expansion
- Expanded reading.json from 10 to 22 passages covering all four CELPIP reading parts.
- Part 0 (general info article, R001–R010): existing passages relabelled from part:3 to part:0 to avoid misleading the learner about CELPIP Part 3 format.
- Part 1 (correspondence, R014–R016): inspection notice, road works parking restriction, employee benefits change.
- Part 2 (diagram/table, R017–R019): community pool schedule, municipal waste collection timetable, city parking rate chart with notes and footnote rules.
- Part 3 (reading for information A/B/C/D, R020–R022): Employment Insurance eligibility, Canadian rental arrangement types, waste sorting categories.
- Part 4 (viewpoints, R011–R013): downtown parking fees, landlord pet policy, library video game lending.
- All 22 passages now have 4 questions each; the 4th question is always an inference question requiring reading between the lines.

### Reading renderer upgrades
- `startReading()` now reads from `data/reading.json` (falls back to hardcoded `CELPIP_READINGS` only if the file is empty).
- `renderPassage()` is now part-aware: Part 2 renders an HTML table with notes, Part 4 renders intro and named-commenter blocks, Part 0/1/3 render plain paragraphs.
- Added CSS for `.passage-table`, `.passage-comment`, `.commenter`, and `.passage-notes`.
- Fixed `.commenter` color from undefined `--fg` to `--t1`.

### Writing deep-feedback prompt
- Added a "Copy Deep Feedback Prompt → Paste into Claude" button that appears after writing submission.
- The copied prompt includes task type, situation, required points, rule-based scores (for reference), word count, and the student's full response, along with strict CELPIP scoring and revision instructions for Claude.
- `textarea` is disabled on submit to prevent the student text from drifting before copying.
- Submitted text, word count, and scores are saved in `QS` so the copy button always reflects the moment of submission.
- Clipboard failure shows an error message on the button instead of failing silently.
- Future `relationship`, `tone`, `rubricHints`, and `benchmarkAnswer` fields in writing.json are automatically included in the prompt when present.

### Vocabulary audio enhancements
- Answers a vocab question correctly now triggers a short synthesised ding sound via Web Audio API (no external audio file needed).
- Advancing to the next vocabulary study card now automatically speaks the new word aloud.

### CELPIP-style non-AI practice upgrade
- Replaced the generic reading passage session with four rotating CELPIP-style reading formats: correspondence, diagram/application, information, and viewpoints.
- Increased reading practice to four questions per set and labels each set by CELPIP-style part and task type.
- Added template-generated Task 1 and Task 2 writing prompts so writing practice can vary without calling an AI API.
- Replaced random writing scores with a rule-based scorer that checks task-specific coverage, email format, opinion clarity, connectors, vocabulary variety, paragraphing, sentence length, punctuation, and word count.
- Writing weak-pattern logging now uses the same rule checks that drive the score.
