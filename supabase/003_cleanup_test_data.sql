-- 기능 검증을 위해 자동화 테스트로 넣었던 더미 데이터 삭제용
-- (2026-07 / 2026-08 테스트 기록, 연간목표 테스트값)

delete from evangelism_records where period_key in ('2026-07-W2', '2026-07', '2026-08');
delete from evangelism_monthly_contributions where year = 2026 and month in (7, 8);
delete from evangelism_yearly_goals where year = 2026;
-- evangelism_settings 의 'default' row는 원래 HTML 기본값과 동일한 내용이라 그대로 두어도 무방합니다.
