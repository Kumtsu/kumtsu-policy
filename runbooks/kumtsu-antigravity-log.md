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
  - **ในเครื่อง (พร้อมอัปโหลดเข้า Claude/Antigravity):** โฟลเดอร์ `/Users/bobby/All Ai/antigravity/skills/chrome-devtools/` + `kumtsu-chrome-devtools/` และไฟล์ `.zip` (`skill-chrome-devtools.zip`, `kumtsu-chrome-devtools.zip`) · งานหลักเสร็จครบ และซิงก์นโยบายฉบับ 16 ต่อเนื่องในรายการถัดไป

### 12 พ.ย. 2569 (เที่ยง) — อ่านและรับทราบนโยบายกลางฉบับ 16 + ติดตั้ง `kumtsu-chrome-data-pull` v2
- **ตรวจความต่างนโยบายกลางฉบับ 16** (`public.runbooks` slug `kumtsu-master-policy` `version = 16`, `75,749` bytes, `md5: a0e41c99031803ebb10f268664430946` · อ้างอิง `ops_logbook #407, #414`):
  - เพิ่มสกิลพื้นฐานระดับ 0 **`kumtsu-chrome-data-pull`** ในข้อ 5.2 (ดึงข้อมูลจากเว็บที่ล็อกอินค้างไว้ใน Chrome ผ่านส่วนเสริม **Control Chrome** ของ Claude Desktop)
  - กติกาทุกห้องที่ต้องทำ: ติดตั้ง `kumtsu-chrome-data-pull` จาก `public.skill_files` และลง `ops_logbook` หมวด `it` · งานดึงข้อมูลเว็บให้เริ่มจากสกิลนี้และยึดกฎความปลอดภัย (ไม่กรอกรหัสผ่านหรือผ่าน CAPTCHA แทนคน, อ่านอย่างเดียว, ไม่ดึง cookie/token) · ห้องที่ไม่มี Control Chrome ให้รับรู้และส่งต่องาน Control Chrome ให้ห้องที่ใช้ได้ · ลงแถวรับทราบฉบับ 16 ตามข้อ 11.2
- **ดำเนินการในเครื่องและฐานกลางครบถ้วน:**
  - ซิงก์ `POLICY.md` เป็นฉบับ 16 (`md5: a0e41c99031803ebb10f268664430946`) และอัปเดต `SKILL.md` ใน `~/.gemini/config/skills/kumtsu-master-policy/` กับ `/Users/bobby/All Ai/antigravity/skills/kumtsu-master-policy/` ตรงกันทั้งสองชุด
  - ติดตั้ง `kumtsu-chrome-data-pull` v2 (`kumtsu/it/kumtsu-chrome-data-pull/SKILL.md`, `17,382` bytes, `sha256: 32b83890611e4de21a045ad332c9ddd7bc76267766cd027cfc69077d17152b47`) จาก `public.skill_files` ลง `~/.claude/skills/kumtsu-chrome-data-pull/SKILL.md`, `~/.gemini/config/skills/kumtsu-chrome-data-pull/SKILL.md` และ `/Users/bobby/All Ai/antigravity/skills/kumtsu-chrome-data-pull/SKILL.md` พร้อม `kumtsu-chrome-data-pull.zip` (`5,646` bytes) — ใช้งานในห้อง Antigravity คู่ขนานกับ `kumtsu-chrome-devtools` (`--autoConnect`) โดยแยกบทบาท Control Chrome ไว้ฝั่ง Claude Desktop
  - อ่านข้อสังเกตสำคัญในสกิล v2 (บท 4.1 FoodStory หน้าสรุป): ยอดลดราคาตรงกับ `fact_sales_daily.discount_amount` แต่ยอดขายรวมและจำนวนบิลนิยามต่างจาก Supabase ห้ามเทียบตรง ๆ โดยยังไม่กระทบยอด
  - ลง `ops_logbook #425` (หมวด `it` ติดตั้ง `kumtsu-chrome-data-pull`) และ `ops_logbook #426` (หมวด `data_system` `policy_ack` + `policy:v16`) · `public.ops_room_health` ของ `ANTIGRAVITY BOBBY` เขียวครบทุกช่อง (`issues = []`)

### 12 พ.ย. 2569 (ค่ำ) — ทดสอบดึงข้อมูล GrabMerchant Portal + สร้างสกิล `kumtsu-grab-portal` และ `runbook-grab-portal-finance` (`ops_logbook #436, #437`)
- **ทดสอบดึงข้อมูล GrabMerchant Portal (`merchant.grab.com`) สำหรับวันที่ 11 พ.ย. 2569** ผ่าน Chrome DevTools MCP (`--autoConnect` โปรไฟล์ `Mister Bobby`, ไม่ logout/ไม่ลบ/ไม่เก็บ cookie หรือ token และอ่าน `merchant_group_id` แบบไดนามิกจาก `/troy/user-profile/v1/merchant-selector`):
  - ดึงครบทั้ง 3 ช่องทาง: JSON API ภายใน (`/mex/finances/v1/transactions/summary`, `transactions`, `stores/settlement-summary`, `stores/settlements`), CSV `All transaction details` (68 คอลัมน์, `3,555` แถวข้อมูล = `2,690` ชำระเงิน + `840` โฆษณา + `19` ยกเลิก + `6` การปรับรายได้) และ Excel GMFR (`GrabMerchant_Reports_11-Nov-2026_to_11-Nov-2026.xlsx`) พร้อมย้ายไฟล์ชั่วคราวเข้า `scratch/` และลบทิ้งหลังตรวจเสร็จ
  - **ผลกระทบยอด 100% ตรงกันทุกแหล่ง:** ยอดขาย Gross `675,340.00` − ส่วนลดร้าน `-44,059.00` (`-43,144.00` ค่าอาหาร + `-915.00` ค่าจัดส่ง) = **Net Sales `631,281.00` บาท** (`2,690` ออเดอร์) · **ค่า GP และค่าธรรมเนียมรวม VAT 7%** `-130,737.65` บาท (`20.71%` ของ Net Sales; ชำระเงินสุทธิหลัง GP `500,543.35`) · **ค่าโฆษณารวม VAT 7%** `-62,845.39` บาท (`-58,736.61` + VAT `-4,108.78`) · **การปรับรายได้** `+298.47` บาท · **ยอด Net รับเงิน `437,996.43` บาท** · โอนเข้าบัญชี `Kasikornthai` รอบ `T+1` (12 พ.ย. เวลา `02:27–02:29` น.) `172` รายการ = **`437,992.74` บาท** (`Success`, ส่วนต่าง cutoff `3.69` บาท)
  - เทียบกับ FoodStory (`fact_sales_daily` ช่องทาง `grab` วันที่ 11 พ.ย.): FoodStory บันทึก `2,771` บิล `645,765.00` บาท (ต่างจาก Grab Portal เพราะสาขาแฟรนไชส์ ออเดอร์ยกเลิก และการบันทึกส่วนลด)
- **บทเรียนสำคัญและกับดักใหม่ที่บันทึกลง `kumtsu-gotchas` (v5):** (1) ช่อง `[57]` ใน CSV 68 คอลัมน์เป็น Memo ภาษีของค่า GP ในแถว `ชำระเงิน` (ห้ามลบซ้ำ) แต่เป็น VAT 7% ที่บวกเพิ่มบนแถว `โฆษณา` (2) หน้า `finances?page=st` กรองตามวันโอนเข้าธนาคาร (`T+1`) ไม่ใช่วันขาย (`11 พ.ย.` = `416,278.87` เป็นยอดขาย `10 พ.ย.`) (3) รายงาน Excel GMFR ต้องอ่านด้วย `openpyxl(..., read_only=False)` เท่านั้น (4) CLI `gdrive` ต้องรันเป็นคำสั่งระดับบนสุดห้ามต่อด้วย `&&`
- **ส่งมอบสกิล Runbook และ Logbook ครบวงจร:**
  - **สกิลใหม่ระดับ 1 [`kumtsu-grab-portal`](https://github.com/Kumtsu/kumtsu-skills/pull/new/antigravity/grab-portal-skill-2026-11-12):** สร้าง `kumtsu/it/kumtsu-grab-portal/SKILL.md` (`14,876` bytes, `sha256: ab0770db416d342cfa7aaaefff79fb6c840a1243a861c07329d9db1f2199c5e2`, `verify.sh` ผ่าน `218` ไฟล์) คอมมิต `611eaa7647538dbe719cccaf4f303081838b91f1` บน branch `antigravity/grab-portal-skill-2026-11-12` (push ขึ้น GitHub via SSH แล้ว · รอคุณบ๊อบบี้กดเปิด/merge PR เนื่องจาก GitHub ใน Chrome หลุดล็อกอินหลังรีสตาร์ต) ติดตั้งลง `~/.gemini/config/skills/`, `~/.claude/skills/`, `/Users/bobby/All Ai/antigravity/skills/` (`+ .zip`) และลง Supabase (`public.runbooks`, `public.skill_registry` id `40`, `public.skill_files` id `189` `verified = true`)
  - **Runbook ใหม่ [`runbook-grab-portal-finance`](https://github.com/Kumtsu/kumtsu-policy/pull/new/antigravity/grab-portal-runbook-2026-11-12):** สร้าง `/Users/bobby/All Ai/antigravity/runbook-grab-portal-finance.md` (`14,057` bytes, `md5: 82a719f2dc64018500cb11b4541d14ae`), ซิงก์ลง Supabase `public.runbooks`, อัปเดต `kumtsu-gotchas` (v5, Drive ID `1_zuUywqCyT_-jbQbtq5R5Ybi3NhmNZhl`) และ `kumtsu-antigravity-log` (v6, Drive ID `1k5FvAng6CICwyuIykUtztQfF8QffudTr`) พร้อม push branch `antigravity/grab-portal-runbook-2026-11-12` บน `Kumtsu/kumtsu-policy` via SSH
  - ลง `ops_logbook #436` (หมวด `it` สร้างสกิล) และ `#437` (หมวด `finance` ทดสอบดึงข้อมูล Grab + สร้าง runbook) · ตรวจ `public.ops_room_health` (`issues = []`)

### 13 พ.ย. 2569 (เช้า) — ส่งรีพอร์ตยอดขาย 12/11/2569 และปรับปรุงมาตรฐานงานรีพอร์ตตามคำสั่งคุณบ๊อบบี้
- **ส่งงานรีพอร์ตยอดขาย 12/11/2569:**
  - ตรวจสอบยอดขายและจำนวนบิลจาก FoodStory ดึงข้อมูลลงชีต GR สร้างไฟล์ PDF แนบ สรุปร่างอีเมล 3 ฉบับ (ไทย, อังกฤษสำหรับ K. Tapooh, Ops สำหรับพี่แม็ค) และสร้างภาพวิเคราะห์บิล `billcheck_12-11-2026.png`
  - ส่งอีเมลทั้ง 3 ฉบับผ่าน `gmail` CLI และบันทึก `ops_logbook #439` (สร้างรีพอร์ต), `#440` (ส่งอีเมล) เรียบร้อย
- **รับคำสั่งและผลตรวจรอบ 11-11 และ 12-11 จากคุณบ๊อบบี้ เพื่อปรับปรุงมาตรฐานงานรีพอร์ตยอดขายรายวัน (บังคับใช้ทันที):**
  1. **หน้ารายงานสาธารณะ (`https://claude.ai/artifact/MXokuCw9ibzUhyVLrfFK9e`):** Antigravity publish หน้านี้เองไม่ได้ หากหน้าเว็บยังไม่อัปเดตเป็นวันที่รายงาน **ต้องตัดบรรทัดลิงก์ออกจากอีเมลทั้ง 3 ฉบับทันที** แล้วแจ้งคุณบ๊อบบี้ตอนส่งงานว่า *"หน้ารายงานยังไม่อัปเดต ให้ห้อง KUMTSU OPERATIONS publish dash/exec.html"* ห้ามปล่อยให้ผู้บริหารกดลิงก์แล้วเห็นข้อมูลวันเก่าเด็ดขาด
  2. **สาขาแฟรนไชส์ 5 สาขา ห้ามให้ Ops ตาม:** บางพลี (F002), พระราม 5 (F003), มมส. (F004), เพชรเกษม 69 (F005), เยาวราช (F006) — ใส่ได้เฉพาะตัวเลขสถิติในตาราง ห้ามอยู่ในรายการตามงานพี่แม็ค, ตาราง "จากอีเมลก่อนหน้า", หัวข้อ "สาขาที่ควรติดตาม" หรือข้อเสนอแนะในอีเมลทั้ง 3 ฉบับ (รวมถึงสาขาที่ปิดไปแล้ว)
  3. **พฤติกรรมบิลสาขาเพชรเกษม 69:** ปิดบิลรวมช่วง 20:00 น. ทุกวันเป็นปกติของการทำงานหน้างาน ไม่ใช่เปิดร้านแค่ 30 นาที ต้องเทียบเวลากับประวัติก่อนหน้าก่อนสรุป
  4. **ความซื่อตรงของบทวิเคราะห์ (Analytical Honesty - Phase 4b):** ข้อมูล POS เห็นแค่ออเดอร์และยอดขาย มองไม่เห็นโปรโมชัน แคมเปญ การจัดอันดับ หรือพฤติกรรมลูกค้า ห้ามเขียนเดาสาเหตุเป็นข้อเท็จจริง หากจะตั้งสมมติฐาน ให้ระบุว่า *"ผมคิดว่าอาจเป็นเพราะ… แต่ข้อมูลที่มียืนยันไม่ได้"* และข้อมูลภายนอก (อากาศ, ข่าว) ต้องมีแหล่งอ้างอิงชัดเจน หากไม่มีให้ตัดออก
  5. **ตรวจข้อเท็จจริงคำสถิติ/แนวโน้ม:** คำว่า *สูงสุด*, *ต่ำสุด*, *ต่อเนื่อง*, *ครั้งแรก*, *ฟื้นตัว* ต้องตรวจเทียบกับข้อมูลจริงทั้งเดือนทุกครั้ง ห้ามดูแค่ 2–3 วัน
  6. **การคำนวณและตัวเลขต้องตรงกัน 100%:** *"ค่าเฉลี่ย 3 วัน / 7 วันก่อนหน้า"* ใช้วันก่อนหน้า ไม่รวมวันที่รายงาน และตัวเลขสถิติเดียวกันต้องตรงกันเป๊ะทั้ง 3 อีเมล ไฟล์ billcheck Run log และ ops_logbook
  7. **สิ่งที่ต้องมีทุกวันในอีเมลไทย:** ติดตามเรื่องจากอีเมลเมื่อวาน (แก้แล้ว/ยังไม่ผ่าน), แยกวิเคราะห์แบรนด์คุ้มสึบน LINE MAN (ห้ามเขียนฟื้นถ้ายังติดลบ WoW), สาขาที่คีย์บิลผิดเกิน 5% ต้องขึ้นเป็นเรื่องเร่งด่วนทั้งในอีเมลไทยและ Ops, แจ้งว่าส่งรายการสาขาให้พี่แม็คแยกแล้ว
  8. **รูปแบบอีเมล:** ไทยเปิดด้วย *"สวัสดีครับทุกท่าน"* ภาษาคน ไม่ใช้คำย่อเทคนิค (`vsB`, `LFL`); อังกฤษเปิดด้วย *"Hi K. Tapooh,"* ยาว 500–600 คำ ตารางไม่เกิน 1 ตาราง; Ops ตาราง 6–8 แถว ทุกแถวมีเกณฑ์ *"ถือว่าแก้แล้วเมื่อ"* ที่วัดผลได้
- **การดำเนินการปรับปรุงและบันทึกมาตรฐาน:**
  - อัปเดต `~/.claude/skills/kumtsu-daily-sales-report/SKILL.md` (เพิ่ม Phase 4b Analytical Honesty, ระบุรหัสแฟรนไชส์ 5 สาขา, เช็กลิสต์ก่อนส่ง 5 ข้อ, Gotchas 2026-11-13, Run log)
  - รัน `sync_everywhere.sh` คอมมิต `e307f8c` บน GitHub `Kumtsu/kumtsu-sales-report` (branch `main`)
  - อัปเดต Supabase `public.runbooks` slug `kumtsu-daily-sales-report-full` เป็น v67
  - ลง `ops_logbook #441` (หมวด `sales_report`, สถานะ `done`)
  - บันทึกลง `kumtsu-antigravity-log.md` (v7) และ `kumtsu-gotchas.md` (v6) ซิงก์ครบทั้ง 4 แหล่ง (เครื่อง, Supabase, Google Drive, GitHub)
