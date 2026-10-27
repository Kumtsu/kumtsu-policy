# ชุดเริ่มต้นแผนกบัญชี (kumtsu-dept-acc)

ฉบับที่ 1 · 27 ต.ค. 2569 · เจ้าของ: คุณบ๊อบบี้ · ops_logbook #137
ฉบับหลักอยู่ที่ Supabase `public.runbooks` slug **`kumtsu-dept-acc`**

**ใครอ่าน:** AI ของแผนกบัญชี อ่านต่อจาก `kumtsu-master-policy` และ `kumtsu-new-ai-account-setup` เพื่อรู้ว่าแผนกมีใคร ทำงานอะไร ใช้คู่มือและตารางไหน และทำอะไรได้แค่ไหน

## ภาพรวม
- แผนกบัญชีมี 6 ตำแหน่ง ใช้บัญชี AI เดียวกันทั้งแผนก
- **1 ห้องต่อ 1 ตำแหน่ง** ตั้งชื่อห้องตามตาราง ข้อ 1 ห้องจะได้จำงานของตำแหน่งนั้นได้ และ ops_logbook แยกได้ว่าใครทำ
- สิทธิ์ของทุกตำแหน่งใช้นโยบายข้อ 3.1: งานบัญชีทั่วไปทำได้หมด บันทึกบัญชีได้แต่ต้องตรวจ Dr = Cr **ห้ามทำธุรกรรมธนาคารทุกชนิด**
- logbook กลางของแผนก: runbook `kumtsu-acc-team-log` (ถ้ายังไม่มี ให้ห้องแรกที่ตั้งสร้างขึ้นตามขั้น B5) ทุกห้องเขียนที่เดียวกัน แยกคนด้วย tag `by:`

---

## 1. ตำแหน่ง งาน และห้อง

| # | ตำแหน่ง | งานหลัก | ห้อง (tag) | หมวด ops_logbook |
|---|---|---|---|---|
| 1 | หัวหน้าบัญชี | ดูภาพรวม ตรวจงานทีม ปิดงบรายเดือน และจัดการเรื่องโอนเงิน | `room:ACC หัวหน้าบัญชี` | `finance` |
| 2 | AP supplier | เจ้าหนี้ค่าวัตถุดิบและสินค้า ตรวจใบแจ้งหนี้กับใบรับของ | `room:ACC AP supplier` | `finance` (tag `purchasing`) |
| 3 | AP ค่าใช้จ่ายทั่วไป | ค่าเช่า น้ำ ไฟ และค่าใช้จ่ายดำเนินงานอื่น | `room:ACC AP ทั่วไป` | `finance` |
| 4 | AR platforms | รายได้และลูกหนี้จาก Grab, LINE MAN, ShopeeFood กระทบยอดเงินเข้า | `room:ACC AR platforms` | `finance` |
| 5 | AR ทั่วไป | ลูกหนี้แฟรนไชส์ ลูกหนี้ Cloud Kitchen และลูกหนี้อื่น | `room:ACC AR ทั่วไป` | `finance` |
| 6 | GL | บัญชีแยกประเภท งบทดลองรายเดือน และ P&L | `room:ACC GL` | `finance` |

---

## 2. คู่มือและตารางของแต่ละตำแหน่ง

**1. หัวหน้าบัญชี**
- คู่มือ: `runbook-pl-by-branch` · `kumtsu-pl-changelog` · `kumtsu-financial-plan` · `kumtsu-pending-decisions`
- ตาราง: `v_company_pl` · `v_branch_pl` · `pl_segment_month` · `v_pl_segment_compare`
- AI ช่วยได้: สรุปภาพรวมรายเดือน ตรวจงานของทีมจาก ops_logbook และเตรียมรายการที่ต้องจ่าย (ร่างเท่านั้น)
- **การโอนเงินหัวหน้าบัญชีทำเองในระบบธนาคาร** AI ห้ามโอน ห้ามอนุมัติรายการ และห้ามเก็บรหัสเข้าธนาคาร

**2. AP supplier**
- คู่มือ: `kumtsu-branch-gr-vs-to` · `kumtsu-monthly-cogs` · `kumtsu-hq-stock-email-flow`
- ตาราง: ยังไม่มีตารางเจ้าหนี้ใน Supabase
- ⚠️ **ยังไม่มีคู่มืองาน AP** ห้องนี้ต้องให้ผู้ใช้เล่าขั้นตอนจริง แล้วร่าง runbook `kumtsu-acc-ap-supplier` เป็นงานแรก

**3. AP ค่าใช้จ่ายทั่วไป**
- คู่มือ: `runbook-branch-rent-utilities`
- ตาราง: `branch_rent_master` · `branch_rent_monthly` · `branch_master` · `branch_alias`
- ⚠️ ค่าใช้จ่ายอื่นนอกจากค่าเช่า น้ำ ไฟ ยังไม่มีคู่มือ ให้ร่าง `kumtsu-acc-ap-expense` จากที่ผู้ใช้เล่า

**4. AR platforms**
- คู่มือ: `acc-rev-platforms-file` · `runbook-ar-rev-cloudkitchen-ingest` · `runbook-trcloud-revenue-workflow` · `kumtsu-skills-foodstory`
- ตาราง: `ar_sales_platform_monthly` · `ar_sales_brand_monthly` · `ar_platform_gp_rate` · `ar_revenue_tax_monthly`
- กระทบยอดเงินเข้าจาก statement ธนาคารได้ (อ่านและเทียบเท่านั้น ลบไฟล์ statement เมื่อเสร็จ)

**5. AR ทั่วไป**
- คู่มือ: `runbook-ar-rev-cloudkitchen-ingest`
- ตาราง: `ar_franchise_monthly` · `ar_cloud_kitchen_billing` · `ar_cloud_kitchen_rate` · `ar_cloud_kitchen_aging`

**6. GL**
- คู่มือ: `acc-trial-balance-load` · `runbook-branch-month-fact` · `kumtsu-pl-changelog`
- ตาราง: `acc_account` · `acc_tb_month` · `v_acc_tb_month` · `branch_month_fact` · `pl_line`
- ตัวเลขตรวจ: Dr = Cr ทุกเดือน ไม่มีบัญชีที่ไม่สมดุล และยอดยกมาต่อเนื่อง (ตัวเลข golden อยู่ใน `acc-trial-balance-load`)

---

## 3. สกิล
- ระดับ 0 ครบ 6 ตัว และระดับ 1 แถว "บัญชี/การเงิน" ตามนโยบายข้อ 5.3
- ตอนนี้ยังไม่มีสกิล `kumtsu-*` ของแผนกบัญชี งานไหนทำซ้ำครบ 3 รอบ ให้สร้างสกิลตามนโยบายข้อ 5.5 เช่น `kumtsu-acc-trial-balance` (GL) และ `kumtsu-acc-platform-recon` (AR platforms)

---

## 4. ข้อห้ามเฉพาะแผนก (เพิ่มจากนโยบายข้อ 3.1)
- ห้ามอ่านหรือแก้ข้อมูลเงินเดือนและข้อมูล HR
- ห้ามแก้ตารางของตำแหน่งอื่นในแผนก ถ้างานต้องใช้ ให้อ่านอย่างเดียวแล้วบอกห้องเจ้าของ
- งานส่งต่อระหว่างตำแหน่ง (เช่น AP ส่งยอดให้ GL) ให้ลงแถว ops_logbook ที่มีบรรทัด `ค้าง: <อะไร> · รอ: <ตำแหน่ง>`

---

## 5. ข้อความเริ่มต้นของแต่ละห้อง (คุณบ๊อบบี้คัดลอกไปวาง)
```
ห้องนี้คือห้อง ACC <ตำแหน่ง> ของแผนกบัญชี บริษัทคุ้มสึ ใช้โดย <ชื่อเล่น> (<ตำแหน่ง>)

ก่อนทำอย่างอื่น ให้อ่าน Supabase โปรเจกต์ Kumtsu's Project (cokrtednhnunuyvksfhv) ตาราง public.runbooks
1. slug 'kumtsu-new-ai-account-setup' แล้วทำส่วน B ทีละขั้นจนครบ
2. slug 'kumtsu-dept-acc' แล้วใช้งาน คู่มือ ตาราง และข้อห้ามของตำแหน่ง <ตำแหน่ง>
ขั้นไหนทำไม่ได้ ให้หยุดแล้วบอกฉันว่าติดอะไร
```

---

## 6. สถานะห้อง
| ตำแหน่ง | ชื่อคนใช้ | วันที่ตั้งห้อง | สถานะ |
|---|---|---|---|
| หัวหน้าบัญชี | รอแจ้ง | | ยังไม่ตั้ง |
| AP supplier | รอแจ้ง | | ยังไม่ตั้ง |
| AP ค่าใช้จ่ายทั่วไป | รอแจ้ง | | ยังไม่ตั้ง |
| AR platforms | รอแจ้ง | | ยังไม่ตั้ง |
| AR ทั่วไป | รอแจ้ง | | ยังไม่ตั้ง |
| GL | รอแจ้ง | | ยังไม่ตั้ง |

AI ที่ตั้งห้องเสร็จ ให้เติมแถวของตัวเอง เพิ่มเลขฉบับ และลงครบทุกที่

## ประวัติฉบับ
| ฉบับ | วันที่ | เปลี่ยนอะไร |
|---|---|---|
| 1 | 27 ต.ค. 2569 | สร้างจากโครงแผนกบัญชี 6 ตำแหน่งที่คุณบ๊อบบี้แจ้ง · ผู้สั่ง: คุณบ๊อบบี้ · ops_logbook #137 |
