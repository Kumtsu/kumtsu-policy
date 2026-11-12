# Runbook: ดึงยอดขาย ค่า GP ค่าโฆษณา และยอด Net รับเงินจาก GrabMerchant Portal

- **Slug:** `runbook-grab-portal-finance` · **ฉบับที่:** 1 (12 พ.ย. 2569)
- **ห้องต้นทาง:** `room:ANTIGRAVITY BOBBY` · **เจ้าของนโยบาย:** คุณบ๊อบบี้ · **สกิลคู่กัน:** [`kumtsu-grab-portal`](https://github.com/Kumtsu/kumtsu-skills/blob/main/kumtsu/it/kumtsu-grab-portal/SKILL.md), `kumtsu-chrome-devtools`, `kumtsu-acc-ar-daily-revenue`
- **ใช้เมื่อ:** ต้องการดึงยอดขาย GrabFood, ค่า GP / ค่าธรรมเนียมแพลตฟอร์ม, ค่าโฆษณา, รายการปรับรายได้ และยอด Net รับเงินเข้าบัญชีธนาคารจาก `https://merchant.grab.com`

---

## 1. เตรียมความพร้อมและการจำล็อกอิน (กฎความปลอดภัย ข้อ 3 และ ข้อ 6)

1. ใช้ Chrome โปรไฟล์ **`Mister Bobby`** บนเครื่องคุณบ๊อบบี้ (สำหรับ Antigravity ให้เปิด `chrome://inspect/#remote-debugging` และติ๊ก Remote Debugging `127.0.0.1:9222`)
2. เปิดหน้า `https://merchant.grab.com/portal` (หรือหน้า `https://merchant.grab.com/finances`)
3. ตรวจสถานะล็อกอินก่อนดึงข้อมูลทุกครั้ง:
   - หากเด้งไป `weblogin.grab.com/merchant/saved-accounts` หรือพบช่องกรอกรหัสผ่าน / OTP / CAPTCHA **ให้หยุดทันที** และแจ้งคุณบ๊อบบี้กด **Continue** และล็อกอินเอง (AI ห้ามกรอกรหัสผ่านหรือกดผ่าน CAPTCHA แทนคน)
4. **การจำล็อกอินที่ถูกต้อง:** Chrome โปรไฟล์ `Mister Bobby` เก็บ session ไว้ให้อัตโนมัติอยู่แล้ว ห้ามสั่ง logout ห้ามล้าง cookie และ **ห้ามดึง `cookie`, `token` หรือ `password` ออกมาบันทึกในไฟล์ โค้ด หรือ logbook** รวมถึงไม่ hardcode `merchant_group_id` (ให้เรียก `/troy/user-profile/v1/merchant-selector` อ่านค่าแบบไดนามิก)

---

## 2. ขั้นตอนดึงข้อมูลตามวัตถุประสงค์ (3 ช่องทาง)

### ช่องทางที่ 1: ดูยอดสรุปเร็วหรือเช็กยอดโอนเข้าบัญชี (JSON API · <1 วินาที)
รัน `fetch(..., { credentials: 'include' })` ภายในหน้า `merchant.grab.com`:
1. หา `merchantGroupId` จาก `GET /troy/user-profile/v1/merchant-selector` (`merchants[0].id`)
2. **ยอดขายสุทธิ + ยอด Net รับเงินรวม:**
   `GET /mex/finances/v1/transactions/summary?merchant_group_id=<MG>&from=YYYY-MM-DD&to=YYYY-MM-DD&business_line=ALL&currency=THB`
   - ค่าที่ได้: `data.net_sales`, `data.net_earning`, `data.total_orders`
3. **แยกตามสาขา:**
   `GET /mex/finances/v1/transactions?merchant_group_id=<MG>&from=YYYY-MM-DD&to=YYYY-MM-DD&transaction_type=&transaction_status=&transaction_category=&transaction_subcategory=&transaction_paymethod=&limit=200&offset=0&currency=THB`
4. **ยอดโอนเข้าบัญชี (`การจ่ายรายได้` / Settlements):**
   `GET /mex/finances/v1/stores/settlement-summary?merchant_group_id=<MG>&from=YYYY-MM-DD&to=YYYY-MM-DD&currency=THB`
   `GET /mex/finances/v1/stores/settlements?merchant_group_id=<MG>&from=YYYY-MM-DD&to=YYYY-MM-DD&status=&limit=200&offset=0&currency=THB`

### ช่องทางที่ 2: ดาวน์โหลด CSV รายละเอียดทั้งหมด (แนะนำสำหรับคำนวณ GP + Ads + Net แยกแบรนด์/ร้าน)
1. เปิด URL ตรงตามช่วงวัน (แม่นกว่าคลิกปฏิทิน):
   `https://merchant.grab.com/finances?page=tx&startDate=DD/MM/YY&endDate=DD/MM/YY`
2. คลิกปุ่ม **`ดาวน์โหลด`** → เลือก **`รายละเอียดรายการทั้งหมด`** (`All transaction details`, 68 คอลัมน์) → คลิก **`ดาวน์โหลด`**
   - API เบื้องหลัง: `GET /mex/finances/v1/async-transactions-download?merchant_group_id=<MG>&store_ids=all&from=YYYY-MM-DD&to=YYYY-MM-DD&currency=THB` จากนั้น poll `GET /mex/finances/v1/generated-report/<report_id>`
3. ย้ายไฟล์ `~/Downloads/Transaction_Store_<FROM>_to_<TO>_*.csv` เข้า `scratch/` ก่อนประมวลผล

### ช่องทางที่ 3: ดาวน์โหลด Excel ประจำวัน (GMFR) และ Tax Invoice PDF (แท็บ `รายงาน`)
1. เปิด `https://merchant.grab.com/finances?page=re&startDate=DD/MM/YY&endDate=DD/MM/YY`
2. ดาวน์โหลด `GrabMerchant_Reports_DD-Mon-YYYY_to_DD-Mon-YYYY.xlsx` (และ `IM*.pdf` หากต้องใช้ใบกำกับภาษีค่า GP/Ads)
3. ไฟล์นี้มีครบ 4 แท็บ: `สรุป`, `รายการชำระเงิน`, `การจ่ายรายได้` (มีเลขที่ `รหัสการจ่ายรายได้ STH...`, `รหัสใบแจ้งยอดธนาคาร`, `Kasikornthai` และเลขบัญชี 4 หลักท้าย), และ `อภิธานคำศัพท์`
   - ใช้ได้เฉพาะวันที่ปิดยอดย้อนหลัง (`T-1` ขึ้นไป) วันปัจจุบันยังไม่สร้างไฟล์
   - หากอ่านด้วย `openpyxl` ใน Python **ต้องตั้ง `read_only=False`** ไม่งั้นแท็บ `สรุป` จะอ่านว่าง

---

## 3. สูตรรวมยอดและการกระทบยอดจาก CSV 68 คอลัมน์

กรองตามคอลัมน์ `[7] หมวดหมู่`:

1. **แถว `ชำระเงิน` (สถานะ `โอนแล้ว`):**
   - **ยอดขาย Gross (ก่อนส่วนลดร้าน):** `SUM([29] ยอด)`
   - **ส่วนลดที่ร้านออก:** `SUM([35] ส่วนลด (ออกโดยร้าน)) + SUM([36] ส่วนลดค่าจัดส่ง (ออกโดยร้าน))`
   - **ยอดขายสุทธิ (Net Sales):** `SUM([40] ยอดขายสุทธิ)` (เท่ากับ `[29] + [35] + [36]` และตรงกับ `transactions/summary.net_sales` 100%)
   - **ค่า GP และค่าธรรมเนียม (รวม VAT 7% แล้ว):**
     `SUM([44] ค่าธรรมเนียมการตลาด) + SUM([46] ค่าคอมมิชชันแพลตฟอร์ม) + SUM([47] ค่าคอมมิชชันคำสั่งซื้อ) + SUM([48] ค่าคอมมิชชันอื่นของ GrabFood / GrabMart)`
   - **Net หลังหัก GP (`ชำระเงิน`):** `SUM([52] ทั้งหมด)`
   - ⛔ **ห้ามลบ `[57] ภาษีค่าคอมมิชชันฯ` ซ้ำ:** ในแถว `ชำระเงิน` คอลัมน์ `[57]` เป็นเพียง Memo แจกแจง VAT 7% ที่รวมอยู่ใน `[44]+[46]+[47]+[48]` เรียบร้อยแล้ว

2. **แถว `โฆษณา` (สถานะ `โอนแล้ว`):**
   - ค่าโฆษณาก่อน VAT = `SUM([29] ยอด)`
   - VAT 7% ของค่าโฆษณา = `SUM([57] ภาษีฯ)`
   - **ค่าโฆษณารวม VAT ที่หักจริง:** `SUM([52] ทั้งหมด)` (`= [29] + [57]`)

3. **แถว `การปรับรายได้` (สถานะ `โอนแล้ว`):**
   - แยกตาม `[8] รายการย่อย` เช่น `ชดเชยคำสั่งซื้อที่ถูกยกเลิก` (+) และ `หักเงินเพื่อชดเชยผู้สั่งซื้อ` (−) ใช้ `SUM([52] ทั้งหมด)`

4. **ยอด Net รับเงินรวมทั้งวัน:**
   - `SUM([52] ทั้งหมด)` ของทุกแถว (ตรงกับ `transactions/summary.net_earning` และ GMFR ชีต `สรุป`)

---

## 4. กับดักที่เจอจริงและวิธีป้องกัน

1. **ยอดโอน `การจ่ายรายได้` (`page=st`) เป็นรอบ T+1 เวลา ~02:00–03:39 น.:** หน้า `การจ่ายรายได้` ของวันที่ `D` จะโชว์เงินโอนที่มาจากยอดขายวันที่ `D-1` ดังนั้นเมื่อตรวจยอดโอนของวันขาย `11 พ.ย.` ให้ดูที่ GMFR ชีต `การจ่ายรายได้` ของรายงานวันที่ `11 พ.ย.` หรือดูหน้า `page=st` ของวันที่ `12 พ.ย.` (อาจมีส่วนต่างหลักบาทจากรายการตัดรอบข้ามเที่ยงคืน)
2. **เทียบ Grab Portal กับ FoodStory (`fact_sales_daily`) ไม่เท่ากันตรง ๆ:** ฝั่ง POS อาจมีบิลสาขาแฟรนไชส์ บิลยกเลิก หรือวิธีบันทึกส่วนลดต่างจาก GrabPortal จึงห้ามจับมาลบ/ฟันธงว่าผิดก่อนทำกระทบยอดรายสาขา
3. **เทียบกับ runbook บัญชี (`kumtsu-acc-ar-daily-revenue`):** สูตรบัญชีใช้คอลัมน์ `AO` (`ยอดขายสุทธิ [40]`) บวก `BA` (`ทั้งหมด [52]`) เฉพาะแถวปรับรายได้ ซึ่งเป็น **"ยอดรายได้ก่อนหัก GP/Ads"** ส่วนรายงานนี้สรุปทั้ง **ก่อนหัก GP, ค่า GP/Ads, และยอด Net รับเงินหลังหักทั้งหมด**

---

## 5. ข้อมูลอ้างอิงผลทดสอบจริง (ข้อมูลวันขาย 11 พ.ย. 2569 · ทดสอบ 12 พ.ย. 2569)

ตรวจตรงกัน 100% ระหว่าง `transactions/summary` API, CSV 68 คอลัมน์ (`3,555` แถวข้อมูล), และ GMFR Excel (`GrabMerchant_Reports_11-Nov-2026_to_11-Nov-2026.xlsx`):

| รายการ (วันที่ 11 พ.ย. 2569) | จำนวน | ยอดเงิน (บาท) | หมายเหตุ |
|---|---:|---:|---|
| รายการขายที่โอนแล้ว (`ชำระเงิน`) | 2,690 ออเดอร์ | 675,340.00 | Gross (`[29] ยอด`) · ยกเลิก 19 แถว |
| หัก ส่วนลดออกโดยร้าน (อาหาร + ค่าส่ง) | — | -44,059.00 | อาหาร `-43,144.00` + ค่าส่ง `-915.00` |
| **ยอดขายสุทธิ (Net Sales)** | **2,690 ออเดอร์** | **631,281.00** | ตรง API และ GMFR `สรุป` |
| หัก ค่า GP + ค่าธรรมเนียมการตลาด (รวม VAT 7%) | 2,690 แถว | -130,737.65 | คอมมิชชันแพลตฟอร์ม `-112,074.31`, คำสั่งซื้อ `-17,222.24`, อื่น `-157.05`, การตลาด `-1,284.05` (เฉลี่ย **20.71%** ของ Net Sales · VAT memo `-8,552.34`) |
| ยอดหลังหัก GP (`ชำระเงิน` Net) | 2,690 แถว | 500,543.35 | ก่อนหัก Ads และปรับยอด |
| หัก ค่าโฆษณา (Ads รวม VAT 7%) | 840 แถว | -62,845.39 | ก่อน VAT `-58,736.61` + VAT 7% `-4,108.78` |
| บวก/ลบ การปรับรายได้ | 6 แถว | +298.47 | ชดเชยออเดอร์ยกเลิก `+514.80` (4) + หักชดเชยผู้สั่ง `-216.33` (2) |
| **ยอด Net รับเงินรวม (Net Earning)** | **3,555 แถว** | **437,996.43** | ตรง `transactions/summary.net_earning` และ GMFR `สรุป` |
| ยอดโอนเข้าธนาคาร T+1 (12 พ.ย. 02:27–02:29 น.) | 172 รายการ | 437,992.74 | `Success` เข้า Kasikornthai (ต่าง `3.69` บาทจากตัดรอบเที่ยงคืน · เทียบหน้า `page=st` วันที่ 11 พ.ย. = `416,278.87` ซึ่งเป็นยอดของวันขาย 10 พ.ย.) |

**ปิดงานทุกครั้ง:** ลบไฟล์ CSV/Excel ชั่วคราวใน `~/Downloads` และ `scratch/` → ลง `ops_logbook` + อ้างอิงสองทาง → ตรวจ `ops_room_health` ให้ `issues = []`
