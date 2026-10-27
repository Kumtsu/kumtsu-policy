# ดัชนีกลาง: อะไรคือแหล่งความจริง และอยู่ที่ไหน (Kumtsu)

อัปเดต 29 ก.ย. 2569 · เจ้าของ: คุณบ๊อบบี้ · อ่านไฟล์นี้ก่อนเสมอถ้าเป็น AI ตัวใหม่ (Claude, Codex, ตัวอื่น)

> 📢 **ประกาศ (27 ต.ค. 2569):** นโยบายกลาง `kumtsu-master-policy` เป็น**ฉบับ 8** แล้ว และเป็นเอกสารที่ต้องอ่าน**ก่อนไฟล์นี้**เสมอ · ฉบับ 8 เพิ่มข้อ 4.7 ล็อกบุ๊คกลางเดือนละ 1 เล่ม: อ่าน logbook จาก view `ops_logbook_current` · ใส่ tag `room:` ทุกแถว · ตั้งแต่ 1 พ.ย. 2569 ลงแถวรับทราบเล่มใหม่ `logbook_ack` ทุกต้นเดือน · คู่มือ `kumtsu-monthly-logbook`

## 0. กฎเหล็ก 3 ข้อ
1. **คุ้มสึ กับ หิว 456 (หิ๊วหิว/ซักซี่/คาร์พาลุย) แยกขาดกัน** — คนละฐานข้อมูล คนละ GitHub คนละโฟลเดอร์ ห้ามเอาข้อมูลมาปนกัน (หิว 456: GitHub `hiwcompanydaynnight`, Cloudflare D1)
2. **ทุกการบันทึกลง 3 ที่ในรอบเดียวกัน**: ไฟล์ในเครื่อง + Supabase `public.runbooks` + GitHub (private) — ดู `kumtsu-sync-everywhere-rule` · ความจำของ Claude ใช้ได้แค่ตัว Claude ไม่ถือเป็นแหล่งความจริง
3. **ห้ามรายงานว่าเสร็จจนกว่าจะตรวจ** — ใช้ `kumtsu-golden-cases` เทียบตัวเลขก่อนบอกว่าถูก · การบันทึกบัญชีทุกรายการต้องให้คนยืนยัน · ห้ามส่งอีเมล/ข้อความแทนคุณบ๊อบบี้โดยไม่ได้รับคำสั่ง

## 1. หัวข้อ → แหล่งความจริง → runbook
| หัวข้อ | แหล่งความจริง | Runbook (slug ใน public.runbooks) |
|---|---|---|
| รายได้จริง | ไฟล์บัญชี KUMTSU REV PLATFORMS (กระทบยอดกับรายงานแพลตฟอร์ม+แบงก์) | acc-rev-platforms-file, runbook-trcloud-revenue-workflow |
| ยอดขายรายบิล/รายเมนู | FoodStory (POS) — ใช้เป็นตัวตรวจ ไม่ใช่รายได้ทางบัญชี | kumtsu-daily-sales-report(+full/reference/scheduled) |
| ชื่อสาขา/รหัสสาขา | Supabase `branch_master` + `branch_alias` | runbook-branch-master |
| P&L รายสาขารายเดือน | Supabase `branch_month_fact` + views `v_branch_pl` `v_company_pl` `v_branch_brand_sales` | runbook-branch-month-fact, runbook-pl-by-branch, runbook-pl-dashboard-refresh, kumtsu-pl-changelog |
| ต้นทุนวัตถุดิบ/COGS/สต็อก | ไฟล์ Inventory Super Cloud Kitchens + รายงานเคลื่อนไหวสินค้า FoodStory | kumtsu-monthly-cogs, kumtsu-inventory-cogs-log, kumtsu-add-inventory-item(+staff-runbook), kumtsu-menu-bom-facts |
| สต็อกครัวกลาง/สั่งของ/lead time | Supply Chain Monitor M-YYYY แท็บ Monitor daily + Spec Sheet → `inv_item_spec`, `inv_stock_count` | kumtsu-supply-chain-log (อ่านก่อน), kumtsu-hq-inventory-report-check |
| ค่าเช่า/น้ำ/ไฟ | ไฟล์ค่าเช่าของบัญชี → `branch_rent_master` | runbook-branch-rent-utilities |
| เงินเดือน/HR | ไฟล์ "สรุปการจ่ายเงิน M-YY" | runbook-payroll-branch-mapping, kumtsu-hr-log |
| ระบบบัญชี/ERP (TRCLOUD) | PRD + พิมพ์เขียว (ร่าง รอยืนยัน) | prd-kumtsu-erp, runbook-trcloud-blueprint |
| วิธีทำงานกับ AI | สกิลกลาง | skill-*, kumtsu-sync-everywhere-rule, kumtsu-github-repos |
| เอกสารตัวช่วย | — | kumtsu-index (ไฟล์นี้), kumtsu-golden-cases, kumtsu-glossary, kumtsu-adr-log (ทำไมเลือกแบบนี้), kumtsu-pending-decisions (เรื่องค้าง), kumtsu-ai-authority (ร่าง อำนาจ AI), kumtsu-access-map (ระบบและสิทธิ์ ไม่มีรหัส), kumtsu-gotchas (กับดัก) |

## 2. ที่เก็บ (ไล่จากมากไปน้อยตามความน่าเชื่อถือ)
1. **Supabase** โปรเจกต์ Kumtsu's Project (ref `cokrtednhnunuyvksfhv`) — ข้อมูลที่ AI อ่านได้ + `public.runbooks`
2. **Google Drive** โฟลเดอร์ "KUMTSU MODEL AI CLAUDE" (id `1kVveACZHDZieeQMCIQ0SBNrHTEYgSmEh`) — ที่พักไฟล์การทำงานของแต่ละแผนก และเอกสารฉบับที่คนแก้
3. **GitHub** (บัญชี Kumtsu, private): `kumtsu-sales-report`, `kumtsu-hr`, `kumtsu-inventory`, `kumtsu-accounting`(runbook บัญชี), `kumtsu-sales-dashboard` — **`Kumtsu-Website` ของคุณพัชร (ไอที) ห้ามแตะ**
4. **ความจำ Claude** — ใช้ช่วยจำบริบท ไม่ใช่ที่อ้างอิง

## 3. ลำดับอ่านสำหรับ AI ตัวใหม่
`kumtsu-index` → `kumtsu-glossary` → `kumtsu-golden-cases` → runbook ของงานที่ทำ → (ถ้าเกี่ยวกับ ERP) `prd-kumtsu-erp`

## 4. สถานะเอกสาร
ครบแล้ว 8 ชิ้น (29 ก.ย. 2569) · `kumtsu-ai-authority` เป็นร่างรอคุณบ๊อบบี้ยืนยัน · ยังไม่ได้ push ลง GitHub


## ภาคผนวก (1 ต.ค. 2569)
- เอกสารเพิ่ม: `kumtsu-insight-price89-20261001` — บันทึกวิเคราะห์กระแสราคา 89 บาทเทียบยอดขาย
- อัปเดตวันนี้: kumtsu-adr-log (K16 เปิด RLS), kumtsu-gotchas, kumtsu-pending-decisions (E1–E6)

- (8 ต.ค. 2569) เอกสารเพิ่ม: `kumtsu-ck-contract-review-20261008` — รีวิวสัญญา Cloud Kitchen Service (CK-261268-002) ข้อค้นพบ โมเดลบริการ 3 ระดับ และคำถามค้าง 5 ข้อ · อ่านก่อนร่างหรือแก้สัญญา Cloud Kitchen
- (8 ต.ค. 2569) กฎเพิ่ม: logbook ทุกชิ้นต้องบันทึก **ทั้ง 2 ที่** คือ Supabase `public.runbooks` + Google Drive (งานสัญญา Cloud Kitchen เก็บที่โฟลเดอร์ "CLOUD KITCHENS SERVICE" id `1Fn1lIjczHZAMBIobWjrG9RHJbuODyrde` ใต้ "KUMTSU MODEL AI CLAUDE") · มีสำเนาในเครื่องเพิ่มได้ · GitHub รอ D3
- (9 ต.ค. 2569) บรีฟส่งต่อห้องใหม่งานสัญญา Cloud Kitchen: `kumtsu-ck-room-brief-20261009` (อ่านคู่กับ `kumtsu-ck-contract-review-20261008`)

- (9 ต.ค. 2569) ร่างสัญญา Cloud Kitchen v1 ใน Claude Docs: `kumtsu-ck-draft-v1-20261009`

- (27 ต.ค. 2569) นโยบายเพิ่ม: `kumtsu-standard-skills-policy` — สกิลพื้นฐานพนักงานระดับ 0 (ทุกคน) / ระดับ 1 (ตามตำแหน่ง) · การ์ดสกิลใหม่: `skill-superpowers`, `skill-impeccable`, `skill-claude-mem`, `skill-find-skills`, `skill-task-observer` (ร่าง รอคุณบ๊อบบี้ยืนยัน)

- (27 ต.ค. 2569) นโยบายกลางรวมเป็นไฟล์เดียว `kumtsu-master-policy` (ฉบับ 8) อ่านก่อนทุกงาน · คู่มือเพิ่ม: `kumtsu-monthly-logbook` (ล็อกบุ๊คกลางรายเดือน + view `ops_logbook_current`, `ops_logbook_month_summary`, `ops_logbook_month_by_room`) · `kumtsu-new-ai-account-setup` (เปิดบัญชี AI ให้แผนก) · `kumtsu-dept-acc` (ชุดเริ่มต้นแผนกบัญชี) · ops_logbook #143, #146
