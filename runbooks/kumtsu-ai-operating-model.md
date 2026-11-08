# Runbook: แบบใช้ AI ทั้งบริษัท + สรุปงานรายสัปดาห์จาก ops_logbook

ฉบับ 1 · 8 พ.ย. 2569 · เจ้าของ: คุณบ๊อบบี้ · ห้อง KUMTSU DEV
เอกสารผลลัพธ์ครั้งแรก (Claude Doc): https://claude.ai/artifact/HgKqmUs1caS9pjYYNRuUFF

## A. ข้อสรุปที่ใช้ (รอคุณบ๊อบบี้ยืนยันก่อนเขียนเข้านโยบายฉบับ 12)
- บัญชี Claude ต่อแผนก · ห้อง AI ต่อตำแหน่ง (`room:` ตรง org_positions) · สมองกลาง = นโยบาย/สกิล/logbook ใน Supabase
- บัญชีรายคนเฉพาะ: ผู้บริหาร 4 ท่าน, งานเงินเดือน, หัวหน้าบัญชี (คนโอนเงิน) หรือคนที่ใช้ AI > 2 ชม./วัน หรือชนลิมิตบ่อย
- ช่องโหว่นโยบายที่ต้องเพิ่ม: playbook การตัดสินใจ, ตรวจสุขภาพห้องรายสัปดาห์, บัตรย่อ 1 หน้า, ข้อ policy_override, ชื่อคน/ห้องมาตรฐาน, สอบ AI รายเดือน, แยกสิทธิ์ Supabase

## B. สรุปงานรายสัปดาห์ (ทำซ้ำได้ทุกจันทร์)
Supabase ref `cokrtednhnunuyvksfhv` · เปลี่ยนช่วงวันที่ใน `:d1` `:d2`
นับงานจาก log_date หรือ created_at (เวลาไทย) ตกในช่วง เพราะบางห้องลง log_date ย้อนหลัง

### B1 งานรายห้อง
```sql
with w as (select * from ops_logbook
  where (created_at at time zone 'Asia/Bangkok')::date between '2026-11-01' and '2026-11-08'
     or log_date between '2026-11-01' and '2026-11-08')
select coalesce((select t from unnest(tags) t where t like 'room:%' limit 1),'(ไม่มี room)') room,
  count(*) n, count(*) filter (where status='done') done,
  string_agg(distinct owner, ', ') owners, string_agg(distinct created_by, ', ') creators
from w group by 1 order by n desc;
```
### B2 รายการงาน (ใช้เขียนคอลัมน์ "ทำอะไรเด่น" และ "ค้าง/ติด")
```sql
with w as (...เหมือน B1...)
select coalesce((select t from unnest(tags) t where t like 'room:%' limit 1),'-') room, id, log_date,
  category, status, left(title,90) title
from w order by room, id;
```
แถวไม่มี room: ดู owner/created_by/tags แล้วจัดเข้าห้องที่ใช่ (GR vs TO = KUMTSU - SUPPLY CHAIN, stock ของน้องภู = SC ฝ่ายผลิต)

### B3 ห้องไหนยังไม่รับทราบนโยบาย/เล่ม
```sql
select r.room, max(l.created_at) last_any,
  bool_or('policy:v11'=any(l.tags) and 'policy_ack'=any(l.tags)) ack_policy,
  bool_or('book:2569-11'=any(l.tags) and 'logbook_ack'=any(l.tags)) ack_book
from ops_logbook l cross join lateral (select t room from unnest(l.tags) t where t like 'room:%') r
group by 1 order by last_any desc;
```
(เปลี่ยน policy:vN และ book:<เล่ม> ให้เป็นฉบับ/เล่มปัจจุบัน)

### B4 รูปแบบรายงาน
1. ภาพรวม 3 บรรทัด: จำนวนงาน/เสร็จ/ค้าง, ห้องเด่น, ห้องที่ยังไม่รับทราบ
2. ตาราง: ห้อง | ผู้ใช้ | งาน (เสร็จ) | ทำอะไรเด่น | ค้าง/ติด
3. ห้องที่ไม่มีงานเลย
4. ข้อสังเกตที่ขัดนโยบาย (เช่นปรับตัวเลขให้เท่ากัน แก้ไฟล์เดือนก่อน) + มุมพลิกวิกฤต
5. ลง ops_logbook หมวด data_system tag room:KUMTSU DEV, weekly_summary

## D. ระบบตรวจสุขภาพห้อง: view `public.ops_room_health` (สร้าง 8 พ.ย. 2569 คุณบ๊อบบี้สั่ง "ลุยเลย")
อ่านอย่างเดียว ไม่แก้ข้อมูล (security_invoker) · คิดเลขฉบับนโยบายจาก runbooks และชื่อเล่มจากวันที่ไทยเอง ไม่ต้องแก้ทุกเดือน
```sql
select room, last_activity, rows_7d, done_7d, ack_policy, ack_book, open_over_7d, decisions_open, bad_steps_7d, issues
from ops_room_health order by cardinality(issues) desc, rows_7d desc;
```
- 1 แถว = 1 ห้อง (tag room:) + แถว "(ไม่มีห้อง)" · นับเฉพาะงาน 60 วันล่าสุด + งานที่ยังไม่ done
- issues: ยังไม่รับทราบนโยบาย/เล่ม · งานค้างเกิน 7 วัน · steps ไม่ขึ้นต้น "1." · ไม่มีงานเกิน 7 วัน
- ใช้ทุกจันทร์คู่กับส่วน B แล้วใส่ผลในรายงานสัปดาห์ · ห้องชื่อเก่า (KUMTSU - IT, KUMTSU-HR, KUMTSIS) โผล่เพราะมีงานค้าง ให้ปิดหรือย้าย tag

## C. ประวัติ
- 8 พ.ย. 2569 สร้าง view ops_room_health · ผลแรก: ห้องไม่มีปัญหาเลยมี 1 ห้อง (HR PAYROLL)
- 8 พ.ย. 2569 ครั้งแรก: สัปดาห์ 1–8 พ.ย. 105 งาน เสร็จ 79 · รับทราบ v11 ครบ 3/11 ห้อง
