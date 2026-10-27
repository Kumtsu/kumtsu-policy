-- วางใน Supabase > SQL Editor แล้วกด Run เพื่อดู logbook แบบอ่านง่าย (อ่านอย่างเดียว)
select
  id                                   as "เลขที่",
  log_date                             as "วันที่",
  category                             as "แผนก",
  status                               as "สถานะ",
  title                                as "งาน",
  owner                                as "เจ้าของงาน",
  coalesce(array_to_string(array(select substr(t,4) from unnest(tags) t where t like 'by:%'), ', '), '-') as "ผู้ทำ",
  coalesce((select substr(t,6) from unnest(tags) t where t like 'room:%' limit 1), '-') as "ห้อง",
  steps                                as "ใครทำอะไร ยังไง",
  result                               as "ผล / ค้าง / รอตัดสินใจ",
  related_runbook                      as "คู่มือ",
  created_by                           as "ผู้ลงบันทึก"
from public.ops_logbook
order by log_date desc, id desc;
