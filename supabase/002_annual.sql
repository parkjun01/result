-- 연간 목표 + 연간 누적치(월별 기여분) 저장용 테이블
-- schema.sql 실행 이후 추가로 실행하세요.

create table if not exists evangelism_yearly_goals (
  year int primary key,
  overall_goal jsonb not null default '{}'::jsonb,
  campus_goal jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table evangelism_yearly_goals enable row level security;

create policy "anon can read evangelism_yearly_goals"
  on evangelism_yearly_goals for select
  to anon
  using (true);

create policy "anon can insert evangelism_yearly_goals"
  on evangelism_yearly_goals for insert
  to anon
  with check (true);

create policy "anon can update evangelism_yearly_goals"
  on evangelism_yearly_goals for update
  to anon
  using (true)
  with check (true);

-- 매달 1일 '기록 저장' 시 직전 달 결과가 (year, month) 기준으로 upsert 됨
-- 같은 달을 다시 저장해도 덮어쓰기만 될 뿐 중복으로 더해지지 않음
create table if not exists evangelism_monthly_contributions (
  year int not null,
  month int not null,
  overall jsonb not null default '{}'::jsonb,
  campus jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (year, month)
);

alter table evangelism_monthly_contributions enable row level security;

create policy "anon can read evangelism_monthly_contributions"
  on evangelism_monthly_contributions for select
  to anon
  using (true);

create policy "anon can insert evangelism_monthly_contributions"
  on evangelism_monthly_contributions for insert
  to anon
  with check (true);

create policy "anon can update evangelism_monthly_contributions"
  on evangelism_monthly_contributions for update
  to anon
  using (true)
  with check (true);
