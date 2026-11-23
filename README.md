# Lifecycle Decision-Tree Map — a Claude skill

A Claude skill that turns **all of a team's operational work** into **one interactive HTML map**. The map lays the work out as a horizontal decision tree along the lifecycle of the thing the team handles, such as a booking, order, insurance claim, job application or support ticket.

The map answers four questions at a glance:

1. **When** does each piece of work happen? Each lifecycle stage is a subtree on a time spine.
2. **What triggers it, and how does it branch?** Each case expands into its steps and decision branches.
3. **Which systems and people are involved?** Each case card has system "ports" and every step names its owner.
4. **What is already automated?** Shaded zones show exactly *from which step to which step* a bot, script, workflow tool, integration or AI agent runs.

The skill is domain-neutral. It was first built for a hotel customer-service team (booking lifecycle, RPA bots, supplier assignment). It works the same way for any team whose work follows a unit through stages.

---

## What you get

- **A single self-contained `.html` file.** It needs no server or internet, and it opens in any browser.
- **Pan, zoom, and drag-to-zoom** on any area.
- **Expandable case cards.** Each card has an info popover (goal, trigger, risk, documentation) and system ports grouped by role: starts from · look up / record · contact · automated.
- **Automation zones** labelled "*[term] [code] from ‘step A’ to ‘step B’ · hands back to ‘…’*".
- **Search and filters** by person, system, and any assignment axis, for example partner × work type. Steps that don't match are dimmed.
- **Sticky notes on the canvas** for open questions, sources and the legend. Steps that are still uncertain are marked **"to confirm"**.
- **Light and dark themes**, keyboard access, and print CSS.

---

## Repository layout

```
lifecycle-decision-tree-map/     ← the skill folder (upload / copy this)
  SKILL.md
docs/
  USAGE.md                       ← step-by-step guide, example prompts for many domains
scripts/
  package.sh                     ← builds lifecycle-decision-tree-map.zip for upload
README.md
```

---

## Install

### Claude apps (claude.ai, desktop, Cowork)

1. Run `bash scripts/package.sh`. It creates `dist/lifecycle-decision-tree-map.zip`, with the skill folder at the root of the zip.
2. In Claude, go to **Customize → Skills**, click **+** → **Create skill** → **Upload a skill**, and choose the zip.
3. Turn the skill on.

Team and Enterprise organisations: an Owner can also provision it for everyone under **Organization settings → Plugins & skills**. Skills require *Code execution and file creation* to be enabled.

### Claude Code

```bash
# personal (all projects)
mkdir -p ~/.claude/skills && cp -R lifecycle-decision-tree-map ~/.claude/skills/

# or per project (shared with the repo)
mkdir -p .claude/skills && cp -R lifecycle-decision-tree-map .claude/skills/
```

Claude picks the skill up automatically when your request matches. You can also call it directly with `/lifecycle-decision-tree-map`.

---

## Quick start

Gather your sources first: SOPs, task lists, an assignment table, the list of bots and automations, and any chat threads that explain the work. Then ask Claude, for example:

> Map all the work our claims team does, from first notice of loss to settlement, as a decision tree. Here are our SOP and the list of automations. Show which systems each step uses and where automation already runs.

Claude will then:

1. **Ask which language the map should use** (English / Vietnamese / other).
2. **Read your sources**, then run **up to three short rounds of questions**:
   - the frame: purpose, unit, stages, systems, automations;
   - the cases;
   - the step details, which it drafts first for you to correct.
3. **Play back four tables** for you to confirm: stages, cases, systems, automations. Nothing is drawn before you confirm them.
4. **Build and check the map**: data lint, a rendering check, and screenshots it reviews itself.
5. **Deliver it** as a published artifact or a versioned file, then iterate on your team's feedback.

See **[docs/USAGE.md](docs/USAGE.md)** for:

- the full guide;
- what to prepare;
- example prompts for different industries;
- how to adapt the vocabulary;
- how to review a map with your operations team.

---

## Adapting to your domain (cheat sheet)

| Concept in the skill | Hotel CS (origin) | Insurance claims | E-commerce orders | Recruiting | IT service desk |
|---|---|---|---|---|---|
| Unit | Booking | Claim | Order | Candidate application | Ticket |
| Stages | Before sale → Booking → Before arrival → Stay → After stay | FNOL → Assessment → Decision → Payment → After settlement | Checkout → Fulfilment → Shipping → Delivery → Returns | Sourcing → Screening → Interviews → Offer → Onboarding | Intake → Triage → Resolution → Closure → Review |
| Typical case | Supplier confirms / room sold out | Missing documents | Address problem | Candidate reschedules | Escalation to L2 |
| Partner actor | Hotel / supplier | Garage, assessor | Carrier, warehouse | Agency, hiring manager | Vendor |
| Automation | RPA bots HTL0xx | OCR workflow, fraud score | Order-routing script | ATS auto-reject rules | Auto-assign, chatbot |
| Assignment overlay | Supplier × work type | Line of business × region | Marketplace × channel | Role family × location | Service × priority |

---

## Design principles

- **Current state first.** The map shows what runs today. Parts still in design stay hidden unless you toggle them on.
- **Inference is never shown as fact.** Uncertain steps are marked "to confirm", and open questions sit in each case's sticky note.
- **Generic about automation.** The map uses your company's word for it (RPA, bot, workflow, automation) and never guesses a bot's name.
- **No real brand logos.** Systems are shown as 2-letter badges.
- **Separate content from rendering.** All content lives in one `DATA` object, so updating the map means editing data, not code.

---

## Tiếng Việt — tóm tắt

Skill giúp Claude vẽ **toàn bộ công việc vận hành của một team** thành **một file HTML tương tác**, dạng cây quyết định nằm ngang theo vòng đời của đơn vị công việc (booking, đơn hàng, hồ sơ claim, ứng viên, ticket…). Sơ đồ cho thấy:

- mỗi việc xảy ra ở giai đoạn nào;
- việc rẽ nhánh theo điều kiện gì;
- dùng hệ thống nào, ai làm;
- đoạn nào đã tự động hoá (RPA, script, công cụ workflow, tích hợp, AI).

Cách dùng:

1. **Cài skill.** Chạy `bash scripts/package.sh`, rồi tải file zip lên Claude ở **Customize → Skills**. Với Claude Code thì copy thư mục `lifecycle-decision-tree-map` vào `~/.claude/skills/`.
2. **Chuẩn bị tài liệu:** SOP, file tổng hợp công việc, bảng phân công, danh sách bot/automation.
3. **Yêu cầu Claude**, ví dụ: *"Vẽ sơ đồ cây quyết định toàn bộ công việc của team [tên] theo vòng đời [đơn vị], kèm hệ thống và chỗ đã có automation."*
4. Claude hỏi ngôn ngữ output, đọc tài liệu, hỏi tối đa 3 vòng, rồi đưa 4 bảng (giai đoạn, case, hệ thống, automation) để bạn xác nhận. Sau đó mới vẽ.

Hướng dẫn chi tiết: [docs/USAGE.md](docs/USAGE.md).
