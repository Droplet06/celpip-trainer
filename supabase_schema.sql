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
  reading_batch integer not null default 0,
  writing_batch integer not null default 0,
  updated_at    timestamptz default now()
);

-- 3. Vocab status per word per user
create table if not exists vocab_status (
  id         uuid primary key default gen_random_uuid(),
  user_id    text not null,
  word_id    integer not null,
  status     text not null default 'new',  -- 'new' | 'reviewing' | 'mastered'
  updated_at timestamptz default now(),
  unique(user_id, word_id)
);

-- Enable Row Level Security (open access via anon key is fine for personal use)
alter table progress      enable row level security;
alter table user_state    enable row level security;
alter table vocab_status  enable row level security;

-- Policies: allow all operations for any request (personal app, no auth needed)
create policy "allow all" on progress      for all using (true) with check (true);
create policy "allow all" on user_state    for all using (true) with check (true);
create policy "allow all" on vocab_status  for all using (true) with check (true);
