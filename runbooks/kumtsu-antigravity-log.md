# Logbook: ห้อง ANTIGRAVITY BOBBY (Kumtsu)

Logbook อย่างเป็นทางการของห้อง **ANTIGRAVITY BOBBY** (`room:ANTIGRAVITY BOBBY`) เก็บรายละเอียดงาน บทเรียนทางเทคนิค กับดักที่เจอ และแผนพัฒนาต่อ ส่วนสรุปและสถานะกลางอยู่ที่ Supabase โปรเจกต์ Kumtsu's Project (`cokrtednhnunuyvksfhv`) ตาราง `public.ops_logbook` (อ่านผ่าน view `ops_logbook_current`)

- เจ้าของห้อง: คุณบ๊อบบี้ · ผู้ปฏิบัติการ: Antigravity (`by:antigravity`)
- เก็บครบ 4 ที่ตามนโยบายกลาง (`kumtsu-master-policy` ฉบับ 15 · กฎเหล็กข้อ 1):
  1. Supabase `public.runbooks` slug `kumtsu-antigravity-log`
  2. Google Drive โฟลเดอร์ `"KUMTSU MODEL AI CLAUDE "` ไฟล์ `kumtsu-antigravity-log.md`
  3. GitHub `Kumtsu/kumtsu-policy` ไฟล์ `runbooks/kumtsu-antigravity-log.md` (แก้ผ่าน branch + PR ห้าม push ตรงเข้า `main`)
  4. ไฟล์ในเครื่อง `/Users/bobby/All Ai/antigravity/kumtsu-antigravity-log.md`

---

## บันทึกเหตุการณ์

### 11 พ.ย. 2569 — เริ่มเปิดใช้ห้อง Antigravity เชื่อมระบบกลางคุ้มสึ
- คุณบ๊อบบี้สั่งเชื่อม Antigravity กับ Supabase, Gmail, Sheets, Drive และเตรียมทดสอบทำรายงานยอดขายรายวัน
- รับทราบนโยบายกลางฉบับ 12 และรับทราบล็อกบุ๊คเล่ม 2569-11 พร้อมเพิ่มสิทธิ์เข้าใช้งาน Gmail, Sheets, Drive CLI (`access_grant`) · ops_logbook #385, #386, #390
- รับทราบนโยบายกลางฉบับ 13 และต่อมาเวลาค่ำ/เช้ามืด 12 พ.ย. รับทราบนโยบายฉบับ 14 (ยกเลิกข้อ 3.2 ข้อยกเว้นล็อกอินแทนคน) ลบข้อ 3.2 ออกจากความจำ สกิล และ `sidecar.json` · ops_logbook #394, #398

### 12 พ.ย. 2569 — รันรายงานยอดขายรายวัน 11-11-2026 สำเร็จครบรอบแรกบน Antigravity
- ตั้ง MCP `chrome-devtools` (`--autoConnect` เชื่อม Chrome โปรไฟล์ Mister Bobby บนพอร์ต `127.0.0.1:9222`) และสร้างงานตั้งเวลา `Kumtsu Daily Sales Report` (`09:00 Asia/Bangkok`, สถานะยังไม่เปิดใช้งานอัตโนมัติ รอทดสอบความเสถียรและคงกฎต้องรอคุณบ๊อบบี้ยืนยันส่ง)
- ดึงข้อมูลยอดขายรายบิลวันที่ 11/11 จาก FoodStory 8,586 แถว (51 สาขา, 2 หน้า, CSV net 1,038,818.50) วางลงชีต `sales daily report 11-2026` ช่วง `A92150:AC100735` ผ่าน `gsheets mutate raw-batch` (`pasteData`) ได้ยอดรายงาน **1,037,765 บาท · 4,614 บิล · เฉลี่ย 224 บาท/บิล** (ตัดบิล Training 1,054 บาท)
- ดึงข้อมูล GR วันที่ 1–11/11 จำนวน 7,993 แถว (`sumDeliver = 588,989.22`, `hqCount = 6,693`) วางลงชีต `Supply Chain Monitor Report 11-2026` แท็บ `data GR branch` ผ่าน `gsheets mutate raw-batch`
- ส่งออก PDF 8 หน้า ตรวจ `pdfcheck` ผ่าน (`ok: true`) และอัปโหลดเข้า Drive โฟลเดอร์เดือน (`1B_A2bHFdK_t0_6YTZWRFRwJm-jsxfv_H`) ตรวจคีย์บิล (`billcheck_report.py`) พบผิด 38/4,565 บิล = 0.83% (สามย่าน 6/101 = 5.9% เกินเกณฑ์)
- หลังคุณบ๊อบบี้ยืนยัน `"ส่งเลย"` ส่งอีเมลครบ 3 ฉบับเวลา 02:36 น. ผ่าน `gmail mutate send-draft` (`1a1cc1c8c0ac0ab6` ไทย, `1a1cc1cbd427cde7` อังกฤษ, `1a1cc1cec8e8a242` Ops) ตรวจ `in:sent` ครบฉบับละ 1 ครั้ง, อัปเดต `SKILL.md` + GitHub `e689f84` + Supabase `kumtsu-daily-sales-report-full` v62 และลบไฟล์ชั่วคราวทั้งหมด · ops_logbook #402

### 12 พ.ย. 2569 — รับทราบนโยบายกลางฉบับ 15 และปรับเช็กลิสต์งานตั้งเวลา
- ตรวจ `public.ops_room_health` พบประกาศฉบับ 15 (ย้ำลง logbook ทุกงานไม่มีข้อยกเว้น + เช็กลิสต์ 5 ข้อ + งานตั้งเวลาต้องมี tag `room:`)
- ซิงก์ `POLICY.md` ในเครื่องให้ตรงกับ Supabase (`md5: 383ee071c196808996a8065ceb8b480e`), ปรับ `sidecar.json` ให้บังคับเช็กลิสต์ 5 ข้อของฉบับ 15 และลงรับทราบฉบับ 15 (`ops_room_health` ขึ้น `issues: []`) · ops_logbook #404

### 12 พ.ย. 2569 — สรุปสิ่งที่เรียนรู้วันนี้และแผนพัฒนาต่อ (บันทึกเอกสารครบ 4 ที่)
- **สิ่งที่เรียนรู้ด้านเทคนิค (Antigravity + เครื่องมือ):**
  1. **CLI Credential Proxy:** คำสั่ง `gmail`, `gsheets`, `gdrive` จะได้รับ credential เฉพาะเมื่อเรียกเป็นคำสั่งระดับบนสุด (top-level command) เท่านั้น ถ้าเรียกผ่าน `python3 subprocess` หรือเชื่อมหลาย CLI ด้วย `&&` จะเกิด error `no credentials found`
  2. **Chrome Remote Debugging (`--autoConnect`):** พึ่งพาพอร์ต `127.0.0.1:9222` และ session FoodStory ที่คนล็อกอินค้างไว้ (ตามนโยบายฉบับ 14 ห้ามกรอกรหัสผ่านหรือกด CAPTCHA แทนคน) และก่อนปิดแท็บหลังจบงานต้องเช็ก `list_pages` เพื่อปิดเฉพาะแท็บที่ AI เปิดเอง ไม่แตะแท็บเดิมของผู้ใช้
  3. **การวางข้อมูลขนาดใหญ่ผ่าน Google API:** `gsheets mutate raw-batch` (`pasteData` TSV) วางยอดขาย 8,586 แถว และ GR 7,993 แถวได้ในคำสั่งเดียว เร็วและลดความเสี่ยง clipboard ชนหรือเบราว์เซอร์สลับบัญชี ส่วน `gmail mutate create-draft` ของ Antigravity CLI รองรับหลายผู้รับและแนบหลายไฟล์ (`PDF + PNG`) พร้อมกัน
  4. **FoodStory DataTables & Sandbox Workspace Boundary:** บน FoodStory ปุ่ม UI ที่ตอบสนองช้าคุมผ่าน DataTables API (`page.len(5000).draw()`, `jQuery.ajax('/api/setDate')` + `table#show_inventory`) ได้แม่นยำ แต่ `evaluate_script` argument `filePath` ไม่สามารถเขียนลงนอก root workspace (`Access denied`) ส่วน `~/Downloads` ต้องย้ายไฟล์ออกเข้า `scratch/` แล้วลบทิ้งหลังส่งงาน
  5. **ช่องว่างระบบ Mirror & Dashboard Publish:** พบว่าโฟลเดอร์ `~/.gemini/` กับ `~/All Ai/antigravity/` เคยไม่ซิงก์กันคนละฉบับ (`ฉบับ 12` vs `ฉบับ 14`) และหน้าเว็บ Claude Artifact (`https://claude.ai/artifact/MXokuCw9ibzUhyVLrfFK9e`) ยังไม่สามารถกด publish จากฝั่ง Antigravity ได้ (อัปเดตได้เฉพาะไฟล์ในเครื่อง `dash/dash_rows.json` และ `dash/exec.html`)
- **สิ่งที่เรียนรู้ด้านข้อมูลยอดขาย 11-11-2569:**
  - แคมเปญ 11.11 ช่วย ShopeeFood ฟื้น +6.5% เป็น 132,265 บาท (ทะลุ 120,000 บาทครั้งแรกใน 4 วัน) แต่ LINE MAN ลด −16.3% โดยแบรนด์คุ้มสึบน LINE MAN (−18.2%) คิดเป็นกว่า 90% ของยอดที่หายไป (สาทร −30.7%, เกษตร −19.7%)
  - สาขาปิดเร็วเรื้อรัง (ลาดกระบัง 5 วันติด) เปิดสายหลังเที่ยง (พระราม 5 5 วันติด) และสามย่านคีย์บิลผิดพุ่ง 5.9% โดยยังไม่มีอีเมลตอบกลับจากพี่แม็ค
- **แผนพัฒนาต่อ (Roadmap):**
  1. **ย้าย Dashboard ยอดขายรายวันออกจาก Claude Artifact:** ปรับให้ `exec.html` / dashboard อ่านข้อมูลจาก Supabase หรือ host ที่ publish จาก CLI ได้ทุกห้อง (ไม่ต้องพึ่ง session ใด session หนึ่ง)
  2. **สคริปต์ซิงก์ห้อง Antigravity อัตโนมัติ:** ทำสคริปต์เทียบ MD5 และซิงก์ไฟล์ `~/.gemini/` กับ `~/All Ai/antigravity/` + Supabase + GitHub (`Kumtsu/kumtsu-policy` branch) เพื่อไม่ให้เวอร์ชันนโยบายหรือ logbook ตกหล่นอีก
  3. **เชื่อมระบบติดตามงาน Ops (Closed-loop tracking):** เนื่องจากไม่มีอีเมลตอบกลับจาก Ops Manager ควรเชื่อมประเด็นสาขาซ้ำซาก (เช่น ปิดก่อนเวลา/คีย์บิลผิด >5% หลายวัน) เข้าแดชบอร์ดหรือรายการติดตามรายสาขาบน Supabase
  4. **ทดสอบความพร้อมก่อนเปิดงานตั้งเวลา `09:00`:** ทดสอบรันแบบกึ่งอัตโนมัติซ้ำอีกรอบ (ตรวจ FoodStory session gate + draft verification) ก่อนพิจารณาเปิดใช้งาน โดยยังคงกฎห้ามส่งอีเมลโดยไม่มีคำสั่งยืนยันของคุณบ๊อบบี้
- อัปเดต `SKILL.md` (`## Gotchas added 2026-11-12`), `memory/antigravity-cli-devtools-notes.md`, `kumtsu-gotchas` (v3) และซิงก์ครบ 4 ที่ (เครื่อง, Supabase, Google Drive, GitHub) · ops_logbook #405
