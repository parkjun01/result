-- 월별 기록 삭제 기능을 위한 delete 권한 추가
-- (기존에는 실수 방지를 위해 삭제 권한을 주지 않았으나, 잘못 저장된 기록을
--  직접 지울 수 있어야 하므로 evangelism_records / evangelism_monthly_contributions
--  두 테이블에 한해 anon delete 정책을 추가함)

create policy "anon can delete evangelism_records"
  on evangelism_records for delete
  to anon
  using (true);

create policy "anon can delete evangelism_monthly_contributions"
  on evangelism_monthly_contributions for delete
  to anon
  using (true);
