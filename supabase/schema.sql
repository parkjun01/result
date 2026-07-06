-- 전도종합 계산기 - Supabase 스키마
-- 로그인 없이 anon key로 읽기/쓰기 하는 개인용 도구 전제로 작성됨

create extension if not exists pgcrypto;

-- 1) 현재 설정값(목표치, 캠퍼스명, 하단 멘트 등) 저장용 - 단일 row를 계속 덮어씀
create table if not exists evangelism_settings (
  id text primary key default 'default',
  campus_name text,
  footer_message text,
  goals jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table evangelism_settings enable row level security;

create policy "anon can read evangelism_settings"
  on evangelism_settings for select
  to anon
  using (true);

create policy "anon can upsert evangelism_settings"
  on evangelism_settings for insert
  to anon
  with check (true);

create policy "anon can update evangelism_settings"
  on evangelism_settings for update
  to anon
  using (true)
  with check (true);

-- 2) 주간/월간 전도결과 기록 이력 - 저장 버튼 누를 때마다 새 row로 계속 쌓임
create table if not exists evangelism_records (
  id uuid primary key default gen_random_uuid(),
  record_type text not null check (record_type in ('weekly', 'monthly')),
  period_key text not null, -- 주간: '2026-07-W2', 월간: '2026-07'
  title text,
  campus_name text,
  date_str date,
  footer_message text,
  data jsonb not null, -- { overallGoal, overallRes, campusGoal, campusRes, kingRes }
  created_at timestamptz not null default now()
);

create index if not exists evangelism_records_period_idx
  on evangelism_records (record_type, period_key);

alter table evangelism_records enable row level security;

create policy "anon can read evangelism_records"
  on evangelism_records for select
  to anon
  using (true);

create policy "anon can insert evangelism_records"
  on evangelism_records for insert
  to anon
  with check (true);
