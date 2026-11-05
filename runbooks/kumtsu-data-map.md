# แผนที่ข้อมูลคุ้มสึ (kumtsu-data-map)

ฉบับที่ 1 · 5 พ.ย. 2569 · เจ้าของ: คุณบ๊อบบี้ · ใช้คู่กับ `kumtsu-index` (สารบัญเอกสาร) และนโยบายกลางข้อ 10.3
**ใครอ่าน:** ผู้บริหารและ AI ทุกห้อง ก่อนตอบคำถามที่ต้องใช้ตัวเลข ให้เปิดแผนที่นี้ดูว่าข้อมูลอยู่ตารางไหน และสดถึงวันไหน

## ภาพรวม
- ฐานข้อมูลกลาง: Supabase โปรเจกต์ Kumtsu's Project (`cokrtednhnunuyvksfhv`) มี 81 ตาราง + 11 view (5 พ.ย. 2569)
- ต้นทาง: FoodStory (POS) → ยอดขายซิงก์อัตโนมัติ · Google Sheets (Inventory, Supply Chain Monitor, KUMTSU REV PLATFORMS, ค่าเช่า) → โหลดเข้ารายเดือน · ระบบบัญชี → งบทดลองรายเดือน
- มีแค่ยอดขายที่อัปเดตเอง ที่เหลือโหลดเป็นรอบ ต้องเช็กคอลัมน์ "ข้อมูลถึง" ก่อนตอบทุกครั้ง

## 1. ตารางหลักสำหรับผู้บริหาร
| เรื่อง | ตาราง / view | ใช้ตอบคำถาม | ข้อมูลถึง (5 พ.ย. 2569) |
|---|---|---|---|
| งานบริษัท | `ops_logbook_current` · `ops_logbook_month_summary` · `ops_logbook_month_by_room` | ใครทำอะไร ค้างอะไร รอตัดสินใจอะไร | ปัจจุบัน |
| นโยบาย/คู่มือ | `runbooks` (เริ่มที่ `kumtsu-index`) | วิธีทำงานและกติกา | ปัจจุบัน |
| ยอดขาย | `fact_sales_daily` · `fact_sales_daily_product` · `v_branch_brand_sales` | ยอดรายวัน รายเมนู แยกสาขา แบรนด์ ช่องทาง | ม.ค. 2024 – เมื่อวาน (ซิงก์ทุก 15 นาที) |
| ยอดขายรายเดือน (ฝั่งบัญชี) | `ar_sales_brand_monthly` · `ar_sales_platform_monthly` · `ar_revenue_tax_monthly` | ยอดขาย/รายได้รายเดือนตามบัญชี แยกแพลตฟอร์ม | ถึง ก.ย. 2026 |
| กำไรขาดทุน | `v_company_pl` · `v_branch_pl` (จาก `branch_month_fact`) · `v_pl_segment_compare` (จาก `pl_segment_month`) | P&L บริษัท สาขา แยกธุรกิจขายอาหาร/เซอร์วิส | ส.ค. 2026 เดือนเดียว |
| งบทดลอง | `v_acc_tb_month` · `acc_account` | ยอดบัญชีรายเดือน ผังบัญชี | ม.ค. 2025 – ส.ค. 2026 |
| ลูกหนี้ | `ar_cloud_kitchen_aging` · `ar_cloud_kitchen_billing` · `ar_franchise_monthly` | ค้างชำระ cloud kitchen ยอดแฟรนไชส์ | ตามไฟล์ต้นทาง |
| สาขา | `branch_master` · `branch_rent_monthly` | รายชื่อหน่วยงาน ค่าเช่า น้ำ ไฟ | ค่าเช่า ส.ค.–ต.ค. 2026 |
| สต็อก/วัตถุดิบ | `inv_stock_count` · `inv_item_spec` · `menu_bom` | สต็อกนับจริง สเปกวัตถุดิบ สูตรอาหาร | สต็อก ก.ย. 2026 |
| ครัวกลาง → สาขา | `tr_delivery_schedule` | รอบรถส่งสาขา | ปัจจุบัน |
| องค์กร | `v_org_chart` (จาก `org_positions`) | ผังองค์กร สายรายงาน | 28 ต.ค. 2026 |
| งานสนับสนุน | `it_jobs` · `maintenance_jobs` | งาน IT และงานซ่อมสาขา | ปัจจุบัน |

## 2. ข้อควรรู้ก่อนใช้ตัวเลข
1. ยอดขาย FoodStory ใช้ดูเทรนด์และตรวจ รายได้จริงทางบัญชียึด `ar_revenue_tax_monthly` (ไฟล์ REV PLATFORMS)
2. ยอดขายสาขาแฟรนไชส์ไม่ใช่รายได้บริษัท บริษัทรับรู้แค่ royalty และการขายวัตถุดิบ
3. ราคาใน `menu_bom` เป็นราคา FoodStory ห้ามใช้คิดต้นทุนตรง ๆ
4. `branches` (ฝั่งยอดขาย) กับ `branch_master` (ฝั่ง P&L) ยังไม่ผูกกันตรง ใช้ `branch_alias` จับคู่ชื่อ
5. P&L และสต็อกมีข้อมูลแค่ 1 เดือน ยังเทียบเดือนต่อเดือนไม่ได้

## 3. ตารางที่ผู้บริหารไม่ต้องดู
- ตารางเทคนิค: `fact_sales_line` · `import_*` · `stg_*` · `ingest_*` · `line_*` · `branch_alias` · `channel_aliases` · `audit_logs` · `data_quality_runs`
- ตารางของแอปภายใน (ไอทีดูแล อ่านได้เมื่อจำเป็น ห้ามแก้): `it_*` · `maintenance_*` · `cloud_kitchen_*` · `rfd_*`
- **ห้ามเปิดดู:** `branch_access_*` เก็บรหัสเข้าระบบสาขา
- ข้อมูลส่วนบุคคล: `profiles` · `internal_profiles` ใช้เฉพาะงานที่เกี่ยว

## 4. คำสั่งช่วยดู
```sql
-- ยอดขายเมื่อวาน รายสาขา
select * from public.fact_sales_daily where business_date = current_date - 1;
-- P&L บริษัท
select * from public.v_company_pl;
-- ข้อมูลแต่ละตารางสดถึงวันไหน
select max(business_date) from public.fact_sales_daily;
select max(period) from public.acc_tb_month;
```

## ประวัติฉบับ
| ฉบับ | วันที่ | เปลี่ยนอะไร |
|---|---|---|
| 1 | 5 พ.ย. 2569 | สร้างจากการสำรวจ Supabase ตอนเตรียมห้อง AI คุณเอิร์ธ (CEO) · ผู้สั่ง: คุณบ๊อบบี้ |
