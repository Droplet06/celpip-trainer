-- CELPIP Trainer — Supabase Schema
-- Run this in Supabase SQL Editor

-- 1. User progress (one row per user per day)
create table if not exists progress (
  id          uuid primary key default gen_random_uuid(),
  user_id     text not null,
  date        date not null,
  xp_today    integer not null default 0,
  words_done  integer not null default 0,
  sessions    jsonb not null default '{"1":"pending","2":"locked","3":"locked"}',
  created_at  timestamptz default now(),
  updated_at  timestamptz default now(),
  unique(user_id, date)
);

-- 2. Persistent user state (streak, totals, batches)
create table if not exists user_state (
  user_id       text primary key,
  streak        integer not null default 0,
  xp_total      integer not null default 0,
  completed_dates text[] not null default '{}',
  vocab_batch   integer not null default 0,
  vocab_order   integer[] not null default '{}',
  reading_batch integer not null default 0,
  writing_batch integer not null default 0,
  updated_at    timestamptz default now()
);

-- Existing installs created before 2026-05-12 need this migration.
alter table user_state add column if not exists vocab_order integer[] not null default '{}';

-- 3. Vocab status per word per user
create table if not exists vocab_status (
  id         uuid primary key default gen_random_uuid(),
  user_id    text not null,
  word_id    integer not null,
  status     text not null default 'new',  -- 'new' | 'reviewing' | 'mastered'
  updated_at timestamptz default now(),
  unique(user_id, word_id)
);

-- 4. Mistake and weak-pattern log
create table if not exists mistake_log (
  id          uuid primary key,
  user_id     text not null,
  occurred_at timestamptz not null default now(),
  area        text not null, -- vocabulary | reading | writing
  kind        text not null, -- choice | writing_vocabulary | writing_readability | etc.
  word_id     integer,
  word        text,
  question    text,
  chosen      text,
  correct     text,
  details     text,
  created_at  timestamptz default now()
);

create index if not exists mistake_log_user_time_idx on mistake_log(user_id, occurred_at desc);

-- Enable Row Level Security (open access via anon key is fine for personal use)
alter table progress      enable row level security;
alter table user_state    enable row level security;
alter table vocab_status  enable row level security;
alter table mistake_log   enable row level security;

-- Policies: authenticated users can only access their own rows.
-- Drop the original no-auth policies if this project was created from an older version.
drop policy if exists "allow all" on progress;
drop policy if exists "allow all" on user_state;
drop policy if exists "allow all" on vocab_status;
drop policy if exists "allow all" on mistake_log;
drop policy if exists "own progress" on progress;
drop policy if exists "own user_state" on user_state;
drop policy if exists "own vocab_status" on vocab_status;
drop policy if exists "own mistake_log" on mistake_log;

create policy "own progress" on progress
  for all to authenticated
  using (auth.uid()::text = user_id)
  with check (auth.uid()::text = user_id);

create policy "own user_state" on user_state
  for all to authenticated
  using (auth.uid()::text = user_id)
  with check (auth.uid()::text = user_id);

create policy "own vocab_status" on vocab_status
  for all to authenticated
  using (auth.uid()::text = user_id)
  with check (auth.uid()::text = user_id);

create policy "own mistake_log" on mistake_log
  for all to authenticated
  using (auth.uid()::text = user_id)
  with check (auth.uid()::text = user_id);
