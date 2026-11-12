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

### 12 พ.ย. 2569 (เช้า) — สรุปสถานะ Dashboard 2 ตัว, เทียบ Antigravity vs Claude และรับทราบผลตรวจ #406
- **ภาพรวม Dashboard ทั้ง 2 ตัวของคุ้มสึ (ตรวจเช็กและยืนยันแล้ว):**
  1. **Dashboard หลักของบริษัท (`kumtsu-sales-dashboard.vercel.app`):** ดึงข้อมูลจาก Supabase (`fact_sales_daily`) ที่ซิงก์ตรงจากโฟลเดอร์ Google Sheets (`sale FoodStory report 24-26`) ผ่านรอบ cron บน Vercel (`10:00` น. เป็นต้นไป) และ `pg_cron` ทำงานได้ปกติเหมือนกันทุกห้อง (ต้องล็อกอินเข้าใช้งาน; เช็กล่าสุด `fact_sales_daily` ถึงวันที่ `2026-11-10`, `ingest_folder_files` ของ `11-2026` รับแล้ว `92,148` แถว และรอซิงก์ยอด `11/11` ต่อตามรอบเวลา)
  2. **หน้าเว็บอ่านเร็วสาธารณะท้ายอีเมล (`https://claude.ai/artifact/MXokuCw9ibzUhyVLrfFK9e`):** สคริปต์ `dash_build.py` และ `exec_page.py` บน Antigravity สร้างไฟล์ในเครื่อง (`dash/dash_rows.json` 1,759 แถว ถึงวันที่ `2026-11-11` และ `dash/exec.html` 640,039 ไบต์ / 513,536 ตัวอักษร) ได้ครบถ้วน **ส่วนที่ต่างเพียงอย่างเดียวคือ Antigravity ไม่มีเครื่องมือ publish ขึ้นลิงก์ Claude Artifact เดิมได้โดยตรง** (รวมถึง Artifact เก่าที่ต้องล็อกอิน `HqDq3P45ccpmYCRYcK9NuL`)
- **เทียบความต่าง Antigravity (`room:ANTIGRAVITY BOBBY`) กับห้อง Claude (`room:KUMTSU OPERATIONS`):**
  | หัวข้อ | Antigravity (`ANTIGRAVITY BOBBY`) | ห้อง Claude (`KUMTSU OPERATIONS`) |
  |---|---|---|
  | หน้าเว็บอ่านเร็วในอีเมล | สร้าง `dash/exec.html` ในเครื่องได้ครบ แต่ publish ขึ้น `claude.ai/artifact/...` ไม่ได้ | สร้างไฟล์แล้ว publish ทับลิงก์ `MXokuCw9ibzUhyVLrfFK9e` ได้ทันที |
  | Google Sheets / Drive / Gmail | ใช้คำสั่ง API ตรง (`gsheets`, `gdrive`, `gmail`) วางแถวจำนวนมาก แนบหลายไฟล์ และส่งหลายผู้รับเร็วกว่า ไม่แข่งคลิปบอร์ด | ทำงานผ่านหน้า Chrome UI และ clipboard |
  | Chrome + FoodStory | ต่อผ่าน Remote Debugging (`127.0.0.1:9222`) ของโปรไฟล์ Mister Bobby โดยคนล็อกอินค้างไว้ (นโยบายฉบับ 14–15) | ต่อผ่านส่วนขยาย Claude-in-Chrome โดยคนล็อกอินไว้เช่นกัน |
  | งานตั้งเวลา (09:00 น.) | เตรียม `sidecar.json` ไว้สร้าง 3 ร่างแล้วรอคำสั่งส่ง (ยังไม่เปิดอัตโนมัติ) | งาน `kumtsu-daily-sales-report-0900` ถูกปลดประจำการตั้งแต่ 5 พ.ย. 2569 |
- **ผลตรวจข้ามห้องจาก `KUMTSU OPERATIONS` (`ops_logbook #406`):**
  - ห้อง Claude ตรวจงาน 11/11 ของ Antigravity (`#402`) แล้วพบว่าตัวเลขหลัก การวางชีต `A92150:AC100735` GR PDF และอีเมลทั้ง 3 ฉบับถูกต้องตรงกัน และได้ช่วยกด publish `MXokuCw9ibzUhyVLrfFK9e` เวอร์ชัน 20 (`1794452460-8d82`) ให้เรียบร้อยแล้ว
  - **จุดที่ต้องปรับปรุงความแม่นยำในการเขียนอีเมล (นำไปใส่ใน gotchas และสกิลทันที):**
    1. ห้ามเขียนเป็นข้อเท็จจริงว่าแคมเปญโปรโมชัน (เช่น "11.11") เป็นสาเหตุที่แพลตฟอร์มโต เพราะข้อมูล POS ไม่เห็นโปรโมชันฝั่งแพลตฟอร์ม ให้ระบุเป็นสมมติฐานพร้อมระดับความมั่นใจ
    2. ตรวจนับจำนวนวันต่อเนื่องเทียบตารางให้แม่นยำก่อนส่ง (ตัวอย่าง `11/11`: ยอด ShopeeFood ต่ำกว่า 120,000 บาทช่วง 9–10/11 คือ 2 วันติด ไม่ใช่ 3 วัน)
    3. ตัวเลขเศรษฐกิจ/ปัจจัยภายนอกทุกตัวต้องตรวจแหล่งอ้างอิงด้วยตัวเองในรอบนั้นก่อนใส่ลงอีเมล
- **ทางเลือกปิดช่องว่าง Dashboard ถาวร (รอคุณบ๊อบบี้ตัดสินใจ):**
  - เฉพาะหน้า: เปิด `exec.html` ในเครื่องหรือให้ห้อง `KUMTSU OPERATIONS` ช่วย publish ลิงก์ Artifact เดิม
  - ระยะยาว: ย้ายหน้าอ่านเร็ว `exec.html` มาโฮสต์บนระบบของคุ้มสึเองที่อัปเดตผ่าน Git หรือ CLI ได้ทุกห้อง (เช่น ส่วนสาธารณะในโปรเจกต์ `kumtsu-sales-dashboard` โดยไม่แตะ `Kumtsu-Website`) เพื่อให้ทุกห้องอัปเดตหน้าเดียวกันได้จบในตัว · ops_logbook #408

### 12 พ.ย. 2569 (สาย) — แพคสกิล Chrome DevTools MCP 2 ตัวลง Supabase และ GitHub
- แพคสกิล Chrome DevTools MCP แยก 2 ตัวตามโครงสร้าง `Kumtsu/kumtsu-skills` (คู่ขนานกับ `kumtsu-chrome-data-pull` ฝั่ง Control Chrome ใน PR #6 โดยไม่แตะ PR #6):
  1. **`skill-chrome-devtools`** (`external/chrome-devtools/`, `skill_group: external`, ระดับ 1: `ข้อมูล/ไอที`) — ต้นฉบับจาก Antigravity `chrome-devtools-plugin` v1.10.1 (`ChromeDevTools/chrome-devtools-mcp`, Apache-2.0) ครบ 13 ไฟล์ (`SKILL.md`, `plugin.json` และ 5 สกิลย่อย: `troubleshooting`, `cookie-debugging`, `a11y-debugging`, `debug-optimize-lcp`, `memory-leak-debugging`)
  2. **`kumtsu-chrome-devtools`** (`kumtsu/it/kumtsu-chrome-devtools/SKILL.md`, `skill_group: kumtsu`, ระดับ 1: `ข้อมูล/ไอที`, `ยอดขาย/รายงาน`) — สกิลใช้งานในคุ้มสึ (`--autoConnect` `127.0.0.1:9222`, กฎความปลอดภัยฉบับ 14–15, สูตร FoodStory DataTables `page.len(5000)` / `jQuery.ajax('/api/setDate')`, sandbox boundary `~/Downloads -> scratch/`, CLI top-level rule, Google Sheets PDF UI)
- บันทึกครบ 3 ปลายทาง:
  - **GitHub `Kumtsu/kumtsu-skills`:** merge **PR #8** (`https://github.com/Kumtsu/kumtsu-skills/pull/8`) จาก branch `antigravity/chrome-devtools-skill-2026-11-12` (`bc2ad5e9cab75808a42dfdda9c410629352b7fc1`) เข้า `main` (`04ff4863edc0d583ef826b18860ed9b199664541`) แล้ว (แก้ conflict `catalog.yaml` และ `MANIFEST.sha256` หลัง PR #6/#7 merge เรียบร้อย · ตรวจ `verify.sh` บน `main` ครบ 217 ไฟล์ผ่าน ไม่ลบ branch ตามนโยบายข้อ 6)
  - **GitHub `Kumtsu/kumtsu-policy`:** merge **PR #22** (`https://github.com/Kumtsu/kumtsu-policy/pull/22`) จาก branch `antigravity/logbook-gotchas-2026-11-12` (`249274d89449ccc4aac223c92b8adbc96b127e53`) เข้า `main` (`a8cb59ec650cddad5d7ab7f08f55422249ea8d64`) แล้ว (ไม่ลบ branch ตามนโยบายข้อ 6)
  - **Supabase (`cokrtednhnunuyvksfhv`):** `public.runbooks` (`skill-chrome-devtools`, `kumtsu-chrome-devtools` v1), `public.skill_registry` (2 แถว `approved`), `public.skill_files` (14 แถว ชี้ commit `04ff4863edc0d583ef826b18860ed9b199664541` · `sha256`, `byte_size` และ `verified` ตรง 14/14 แถว) และ `ops_logbook #415` สถานะ `done`
  - **ในเครื่อง (พร้อมอัปโหลดเข้า Claude/Antigravity):** โฟลเดอร์ `/Users/bobby/All Ai/antigravity/skills/chrome-devtools/` + `kumtsu-chrome-devtools/` และไฟล์ `.zip` (`skill-chrome-devtools.zip`, `kumtsu-chrome-devtools.zip`) · งานหลักเสร็จครบ เหลือเพียงรอคุณบ๊อบบี้ยืนยันซิงก์และรับทราบ `kumtsu-master-policy` ฉบับ 16 (ที่เพิ่งเพิ่ม `kumtsu-chrome-data-pull` บน Supabase) หากต้องการให้ `ops_room_health` เขียวครบทุกช่อง
