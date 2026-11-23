# Usage guide

This guide is for anyone who wants an as-is map of a team's operational work, whatever the industry. You do not need to code.

---

## 1. Is this the right tool?

**Use it when:**

- a team handles a stream of "units" (orders, claims, tickets, applications, bookings…) that move through stages over time;
- the work branches a lot ("if the supplier refuses…", "if documents are missing…");
- you want to see systems, owners and existing automation in the same picture;
- you are onboarding people, documenting a team, or looking for automation opportunities.

**Use something else for:**

| Need | Better fit |
|---|---|
| Formal BPMN notation, or swimlanes by role | A BPMN tool |
| Who reports to whom | An org chart |
| Volumes, SLAs, trends | A dashboard |
| One short procedure (≤ 10 steps) | A simple flowchart |

---

## 2. Prepare your sources (10–30 minutes)

The more you hand over up front, the fewer questions Claude asks. Attach or paste whatever you have:

| Source | Why it helps |
|---|---|
| SOPs / work instructions | The steps and branches for each case |
| Task or responsibility list | Every case the team handles, including recurring work |
| Assignment table (who handles which partner, product or work type) | The person / group overlay |
| List of bots, scripts, workflows and integrations | The automation zones |
| Chat threads or emails where the team explains "how we really do it" | The current practice, which is often newer than the SOP |
| System list (helpdesk, ERP, CRM, partner portals, shared mailboxes) | The system ports |

Messy material is fine. If something is missing, Claude draws a reasonable skeleton and marks it **"to confirm"** instead of inventing facts.

**Privacy.** Before sharing, remove customer personal data. Tell Claude whether real staff names may appear on the map, or only roles.

---

## 3. Ask for the map

Name the team, the unit, roughly where the lifecycle starts and ends, and the sources you are attaching.

**Example prompts**

- **Insurance:** "Map our motor-claims team's work from first notice of loss to settlement as a decision tree. Attached: claims SOP, automation list (OCR intake, fraud scoring), and the adjuster assignment table by region."
- **E-commerce:** "Build a decision-tree map of everything our order-operations team does, from checkout to returns. Show which steps run in Shopify, the WMS and Zendesk, and where our routing scripts already run."
- **Recruiting:** "Map our recruiting coordinators' work from job opening to the new hire's first day. Mark what the ATS automates and who owns each step."
- **IT service desk:** "As-is process map of our service desk, from ticket intake to post-incident review, with the auto-assign rules and the chatbot marked."
- **Logistics:** "Map the import desk's work per shipment, from booking to delivery, including customs holds and carrier exceptions."
- **Tiếng Việt:** "Vẽ sơ đồ cây quyết định toàn bộ công việc của team CS khách sạn theo vòng đời booking, có hệ thống từng bước và chỗ đã có RPA."

---

## 4. What happens next

1. **Language.** Claude asks whether the map should be in English, Vietnamese or another language. System terms (status codes, field names) stay as they are.
2. **Round 1, the frame.** Purpose and readers, the unit and where it closes, stages, scope, recurring work, variants, the systems inventory and the automation inventory.
3. **Round 2, the cases.** What triggers work at each stage, how each case ends, whether two documented cases are really one job, whether a process exists, rough volume, and the cost of a mistake.
4. **Round 3, the steps.** For cases your sources don't cover, Claude drafts the steps and you correct them.
5. **Playback gate.** You confirm four short tables: stages, cases per stage, systems, automations. Nothing is drawn before you confirm.
6. **Map.** Claude builds the HTML, checks it, and delivers it as a shareable artifact or a file such as `claims_map_v1.html`.

Claude stops asking after about three rounds. Anything still open becomes a "to confirm" tag on the map.

---

## 5. Reading the map

- **Spine.** Stages run left to right and end at the "unit closed" milestone.
- **Stage gate.** The main question that splits the stage into cases.
- **Case card.** It carries:
  - a code, a step count, and a process badge (defined / rough / none);
  - an automation chip;
  - **i** for goal, risk and sources, and **+** to expand the steps.
- **System ports** under the card. Each 2-letter badge is a system; the number is how many steps use it. Click a badge to highlight those steps.
- **Step colours and icons** show the actor: customer, your team, partner, other team, automation.
- **Shaded automation zone.** The stretch a bot or workflow runs, and where it hands back to a person.
- **↪ card.** "Same step as on another branch" (the branches merge). **↺ card.** "Loops back".
- **Dashed outline / "to confirm".** Inferred, not yet validated.
- **Toolbar.** Search, filter by person, system or assignment group (non-matching steps dim), jump to a stage, expand or collapse everything.

---

## 6. Review it with the operations team

Send the map to the people who do the work and ask them:

1. Is any case missing? Is any case really part of another?
2. On each "to confirm" step: is this how it works **now**?
3. Is any automation drawn in the wrong place, or does it hand back somewhere else?
4. Does the assignment overlay match reality?

Paste their answers back to Claude ("here is feedback from the team: …"). Claude updates the data, publishes a new version and lists what is still open. A few rounds of this usually turn a draft into a map the team trusts.

---

## 7. Updating later

All content lives in one `DATA` object inside the HTML, so updates are cheap. Tell Claude what changed: a new bot, a new partner, a changed step, a new person in the assignment table. Ask for the next version. Keep earlier versions (`_v1`, `_v2`…) so you can compare them.

---

## 8. From map to automation decisions (optional next step)

The map shows where people still do the work. To decide what to automate next, ask Claude to export the manual steps (case, step, actor, systems, work type) into a table. Then score each step:

| Measure | Formula |
|---|---|
| Hours per month | times per day × minutes × working days ÷ 60 |
| Savings | hours × (% automated − % still checked by a person) |
| Priority | savings ÷ development days × a factor for the cost of mistakes |

This scoring is a separate deliverable. The skill only produces its starting table.

---

## FAQ

**Can it draw swimlanes instead?**
Only if you ask. The default is a horizontal tree because it keeps *condition → consequence* visible, which swimlanes tend to hide.

**Our "automation" is a mix of RPA, Zapier and an AI agent. Is that a problem?**
No. Each automation is recorded with its kind, and the map labels zones with the word your company uses.

**We have no SOPs at all.**
That's fine. Claude will ask more questions and mark more steps "to confirm". Cases with no defined process are shown with a red dashed border, which is useful information in itself.

**Does the file need the internet?**
No. It is one self-contained HTML file with system fonts and no external scripts.
