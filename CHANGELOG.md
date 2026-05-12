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
