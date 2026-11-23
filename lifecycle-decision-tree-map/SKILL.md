---
name: lifecycle-decision-tree-map
description: Interactive HTML decision-tree map of a team's work along a lifecycle - stages, cases, branches, systems, owners and existing automation. For as-is process maps; vẽ sơ đồ quy trình.
---

# Lifecycle decision-tree map

Turn **all of a team's operational work** into **one interactive HTML file**. The map shows:

- which work happens at which **stage** of a work unit's lifecycle;
- how each **case** branches on conditions;
- which **systems** each step uses and **who** does it;
- which stretches are already **automated**.

**Automation** means anything the company runs instead of a person: RPA bots, scheduled scripts, workflow tools (n8n, Zapier, Power Automate), system integrations or AI agents. In labels, use the company's own word ("RPA", "bot", "automation", "workflow"). Default to "automation".

The default purpose is **understanding the current state**: a newcomer reads the map and knows what the team does, where, with which tools, and what is automated. It shows what runs today, not a future design, and carries no metrics unless asked.

Why a horizontal decision tree: it keeps *condition → consequence* visible and places every case in time. Swimlanes and lists hide the branching. Offer swimlanes only if the user asks for them.

**When to use:** requests like "map our process / workflow", "decision tree of what the team does", "as-is process map", "where is automation running", "vẽ sơ đồ quy trình / cây quyết định / bản đồ công việc của team".

**When not to use:** BPMN or swimlane diagrams, org charts, metric dashboards, or a single small flowchart.

---

## 1. Workflow

1. **Language.** Ask first with AskUserQuestion: English / Vietnamese / Other. The answer sets every label, note and popover. Keep system-native terms as they are (status codes, field names, foreign-language status labels). Reply to the user in the language they write in.
2. **Collect sources before asking open questions.** Ask for SOPs, task lists, assignment tables, the automation inventory and relevant chat threads (files or pasted text). Read them all. Documents answer more, and more accurately, than interviews.
3. **Discovery in three rounds** (section 2). Ask only what the sources do not answer. AskUserQuestion suits choices; for narrative answers, ask in plain text or show a draft for correction.
4. **Playback gate.** Before rendering, show four short tables and get them confirmed:
   - stages;
   - cases per stage;
   - systems;
   - automations.
   Do not render until all four are confirmed.
5. **Build the data** (section 3) and run the **data lint** (section 5).
6. **Render** with the spec in section 4.
7. **Verify** (section 5).
8. **Deliver and iterate**:
   - Publish with the artifact/publishing tool if one exists. On later versions, republish the same artifact.
   - Otherwise save a versioned file, e.g. `<topic>_map_v3.html`.
   - If the session has project notes, record the changes and open questions there.
   - Each round of feedback from the user or the operations team: fix it, then make a new version.

**Stop rule.** After about three discovery rounds, or as soon as answers stop changing the structure, draw. Tag anything still uncertain "to confirm" on the map. Never present inference as fact.

---

## 2. Discovery question bank

### Round 1: frame (always)

- **Purpose and readers.** What is the map for (current state, onboarding, finding automation, redesign)? Who reads it? Who validates it?
- **Names policy.** May real staff names appear, or roles and groups only?
- **Unit.** What moves through the lifecycle? Where does it start, and in which system is it "closed"?
- **Scope.** Which teams are included? How is work done by another team or office marked? Leave out anything still in design.
- **Stages.** Which stages over time? Example: before sale → order & confirmation → before use → during use → after use. For each stage, ask for the happy path and the main branching question (the gate).
- **Recurring work.** Is there work not tied to a single unit (catalogue upkeep, inventory open/close, general partner notices)? Ask whether it is:
  - *preparation done ahead*: put it in the first stage, labelled "recurring, before each unit is sold"; or
  - *able to occur at any stage*: tag it "Cross-stage".
  Do not merge the two kinds. If it touches units that already exist, draw a link to them.
- **Variants.** Does the work differ by product, channel, customer segment, partner or region? If it does, decide between separate cases, a branch, or an overlay filter.
- **Systems inventory.** List every intake channel (helpdesk, shared mailbox, chat, partner portal), core system or source of truth, lookup tool (partner sites and whether they need OTP, extranets, sheets) and note store. For each system ask:
  - Does it lag behind or disagree with another source?
  - If it is a shared mailbox, does it have auto-sort rules, and what is left for a person to handle?
- **Automation inventory.** For each automation, record:
  - name or code;
  - kind;
  - what it does;
  - trigger or schedule;
  - which system it runs on;
  - where exceptions go, and what the recipient does with them.
  If the code or scope is not known, write "unknown". Never guess names.

### Round 2: cases

- **Triggers.** What starts work in each stage? Incoming email, customer question, automation alert, deadline or SLA, partner notice…
- **End.** When does each case end, and what does it produce?
- **Merge or split.** Are two documented cases really one multi-step job? Example: "customer cancels", "partner confirms cancellation" and "late cancellation" are one cancellation flow that differs only by a fee check. Old documents often split work by entry point, so ask how the team thinks about it.
- **Process status.** Defined, rough, or no defined process (everyone does it differently)?
- **Size and impact.** Rough volume (many per day, a few per week, rare), used to order cases. Consequence of a mistake (customer impact, money or status wrong, delay only).

### Round 3: steps (draft first, then correct)

For each case the sources do not cover, write a draft of the steps and ask the user to correct it. Do not ask from a blank page. Checklist:

1. **First step.** What is it, and where is the information looked up?
2. **Branch conditions.** What does the case branch on? Every decision needs at least 2 labelled exits.
3. **Endings.** Where does each branch end?
4. **Exceptions.** For example force majeure, or documents required.
5. **Workarounds.** Actions the system does not allow directly, e.g. a booking cannot be edited, so it is cancelled and re-booked.
6. **Waits.** Waits on outside parties, and through which channel.
7. **Approvals and handoffs.**
   - Which approvals or authority limits apply?
   - Which steps are handed to another team, and is that still true today?
   - Documents drift, so always ask: "is this still how it works now?"
8. **Loops.** E.g. "ask the customer again".

### People and assignment (whenever an assignment table exists)

- **Assignment table.** Is there one? Along which axes (e.g. partner × work type)? Who owns it, and can it change?
- **How to render it.** Render assignment as an **overlay filter** that dims what does not apply. Never render it as tree branches.
- **Gaps in the table.** What does an empty cell mean? Is anyone missing?

---

## 3. Data model

Author the content as one JS object (`DATA`), separate from the renderer. The build inlines both into a single self-contained HTML file. Content changes then touch only `DATA`.

```js
const DATA = {
  meta: { title, lang:'en'|'vi', asOf:'YYYY-MM-DD', unit:'booking', closedMilestone:'Booking closed in ERP',
          automationTerm:'RPA', sources:['SOP v2', 'task list 2026-10'] },
  actors: [ { id:'customer', label:'Customer', icon:'person' }, { id:'team', label:'Ops team' },
            { id:'partner', label:'Supplier' }, { id:'other', label:'HQ team' }, { id:'auto', label:'Automation', icon:'bot' } ],
  systems: [ { id:'ERP', abbr:'ER', name:'ERP', role:'data'|'intake'|'contact'|'auto', note:'' } ],
  automations: [ { id:'BOT1', name:'Auto-confirm', kind:'rpa'|'script'|'workflow'|'integration'|'ai',
                   does:'', schedule:'every 30 min', system:'ERP', exceptionTo:'team', confirmed:true } ],
  overlays: [ { id:'partner', label:'Partner', values:['A','B'], groups:['G1','G2','HQ'],
                matrix:{ 'A': { email:'G1', question:'G2' } } } ],          // optional
  stages: [ { id:'S1', title:'1 · Order and confirmation', sub:'', startMilestone:'Customer orders',
              gate:'Which path does the order take?', happyPath:'Supplier confirms instantly',
              cases:[ { case:'C02', entry:'Confirmation email arrives', exit:'next'|'end', outcome:'Code recorded' } ] } ],
  cases: [ { id:'C02', code:'C02', title:'Record confirmation code',
             process:'defined'|'rough'|'none', inDesign:false, crossStage:false, volume:'high'|'mid'|'low',
             goal:'', trigger:'', risk:'', doc:'', note:'open questions…', automation:['BOT1'],
             appliesTo:{ partner:['A','B'] },                                // optional overlay scope
             steps:[ { id:'b1', type:'trigger'|'task'|'decision'|'end'|'link', actor:'team', title:'', sub:'',
                       systems:['ERP'], people:['Name or role'], detail:'', workType:'email',
                       confirmed:true|false, to:'C14' /* link only */, appliesTo:{ partner:['A'] } } ],
             edges:[ { from:'b1', to:'b2', label:'Yes' } ] } ]
};
```

- **Positions.** There are none in the data. Layout is fully automatic.
- **`process`** describes how well the process is documented. Automation coverage is computed from steps whose actor is `auto`.
- **`confirmed:false`** renders the step with a dashed outline and a "to confirm" chip.
- **`inDesign`** cases are hidden until the user toggles "Show in-design".
- **Cross-case links.** A `link` step jumps to another case (`to`). Edges stay inside one case.

---

## 4. Render spec

### Architecture

- **Layers.** The viewport holds one transformed world (`translate(x,y) scale(k)`) with two layers:
  - an **SVG layer** underneath for frames, spine, wires and zones;
  - an **absolutely positioned DOM layer** on top for cards, labels and notes.
  This keeps text crisp and wrappable.
- **Redraw.** Each change runs `layout()` then `render()`. Re-layout only when expand/collapse state changes. Filters only toggle CSS classes.
- **Fit to view.** A "Fit" helper computes a bounding box and sets the transform. The same helper serves "jump to stage" and rubber-band zoom.

### Sizes (starting values in px)

| Element | Size |
|---|---|
| Step card | 224 × 72 (title max 2 lines, subtitle max 2 lines, line-clamp) |
| End / link / reference card | 204 × 44 |
| Case card | 380 wide; body 118 high; total ~230 including the ports area |
| Stage gate | 280 × 72 |

Spacing:

- Gaps: 12 px vertically between sibling leaves, 28 px between cases.
- Horizontal gap between depth columns: `max(60, min(330, longestEdgeLabel × 6.6 + 30)) + 34`.

### Layout algorithm (tidy tree per case)

1. **Build the tree.** For each case, the roots are steps with no incoming edge. Depth-first, each step's children are its outgoing edges in data order. If a target was already placed in this case, insert a **reference card** "↪ step title" instead of re-drawing it. This handles merges and loops. For a back-edge (to an ancestor) use "↺ back to step title".
2. **Place nodes.** Recursive pass with a running `cursor`:
   - a leaf sits at `cursor`, then `cursor += height + 12`;
   - a parent centres on the midpoint of its first and last child;
   - if the parent would sit above `cursor`, shift the whole subtree down (`shift(t, dy)`).
3. **Columns.** `x` comes from per-depth columns. Column width is the widest card at that depth plus the gap.
4. **Stages.** Each stage gets its own column block. Cases split into an upper half (stacked upward from the spine) and a lower half (stacked downward), so the spine stays centred. Stage frames are rounded rectangles behind each block, with title and subtitle at the top.
5. **Spine.** A horizontal line at `y = 0` running from stage gate to stage gate, ending at the closed milestone. Show the happy-path label on the spine.
6. **Notes.** A case's note goes directly below its expanded step tree, inside the reserved space, so it never overlaps nodes. Source and legend notes go outside the stage blocks (before the first stage and after the last).

### Edges

- **Shape.** Horizontal cubic Bézier: `M x1 y1 C mx y1, mx y2, x2 y2` with `mx` the midpoint. Arrowhead marker.
- **Labels.** Branch labels go in a small pill just left of the target.
- **Stage to case.** Bézier from the gate's right edge to the case card's left-middle, with the entry condition above the card: "If …".
- **Style.** Dashed wires inside cases with no defined process. Automation → person handoffs use the automation colour and a distinct marker.

### Automation zones

- **Grouping.** Take the visible steps with actor `auto`. Group them with union-find over edges that join two such steps.
- **Shape.** For each group, draw a padded rectangle (12 px) with radius 14, a tinted fill and a dashed border (so colour is not the only cue).
- **Label.** "[term] [code] from ‘first step’ to ‘last step’ · hands back to: ‘…’", where the first and last steps are those with no in-group incoming or outgoing edge.
- **Overlap.** A zone must not enclose non-automation cards. If the rectangle would, split it per column.

### Case card

- **Header.** Code, step count, automation chip ("n/N steps automated", if any), process badge, cross-stage tag. Buttons: **i** opens a popover with goal, trigger, risk, documentation and sources; **+/−** expands or collapses the steps.
- **Body.** Title and outcome: "Next: …" or "Ends: …". A case with no defined process gets a red dashed border.
- **System ports** (pattern borrowed from n8n's agent node):
  - Under the card, a short stub per role group, in the order Starts from · Look up / record · Contact · Automated.
  - Each group fans out to circular 2-letter system badges, each with a count of the steps that use that system.
  - Clicking a badge highlights those steps.
  - Use abbreviations and colour, never real brand logos.

### Interaction

- **Navigation.** Pan by drag in Move mode. Zoom with the wheel, a slider, ± buttons and "Fit". In Select mode, drag a rectangle to zoom into it.
- **Toolbar** (top, single row):
  - search across step titles, subtitles, codes and automation names;
  - filters by person, system and each overlay;
  - stage jump buttons;
  - Expand all / Collapse / Show in-design.
- **Filters.** Matching steps stay; the rest dim to about 25 % opacity.
- **Overlay mode.** Each applicable step shows its group chip.
- **Popovers.** Clicking a step opens a detail popover (people, systems, detail, "to confirm" reason). Esc closes popovers.
- **Keyboard.** Cards, badges and buttons are focusable (`tabindex=0`, `role=button`, `aria-label`). Enter activates.
- **No side panels.** Every annotation lives on the canvas as a sticky note: case notes, sources, open questions, legend, assignment table.
- **URL hash.** Persist open cases, active filters and the view in `location.hash`, so a link reopens the same view.

### Visual defaults

- **Tokens.** Light and dark sets. Starting light palette:
  - paper `#eef1f4`, surface `#fff`, ink `#17202a`, muted `#56616d`, line `#d5dce3`, accent `#0f766e`;
  - gate `#a86412` on `#fff7ea`;
  - sticky note `#fff1a6` with ink `#3b3000`.
- **Actor colours.** customer `#2458c6`, team `#0f766e`, partner `#b4530b`, other team `#6d3fc4`, automation `#a1305f`. Every actor also has its own icon, so colour is never the only signal.
- **Process badges.** defined `#1f7a3d`, rough `#8a5700`, none `#b3261e`.
- **Contrast.** Check WCAG AA in both themes.
- **Fonts.** System stack only, with no CDN or webfont: `system-ui, -apple-system, "Segoe UI", Roboto, "Noto Sans", Arial, sans-serif`. This covers Vietnamese diacritics.
- **Legend note.** Always present: actor colours and icons, process badges, automation zone, handoff arrow, "to confirm" style, reference card.

### Scale and print

- **Scale target.** About 40 cases and 400 steps.
- **Default view.** All cases collapsed.
- **Rendering.** One SVG wire layer. No per-frame layout during pan or zoom.
- **Print.** Print CSS hides the toolbar and prints the expanded canvas, fitted, on landscape pages. Optionally offer "Download SVG" of the current view.

---

## 5. Verification

### Data lint (before rendering)

- **Ids.** Unique within each case.
- **Edges.** Every edge endpoint exists in the same case.
- **Links.** Every `link.to` exists in `cases`.
- **Shape.** No unreachable steps. Every decision has at least 2 labelled exits. Every leaf is an `end` or a `link`.
- **References.** Every referenced system, actor, automation and overlay value is defined.
- **Stages.** Every case appears in some stage, or is flagged as intentionally unused.

### Runtime (headless browser such as Playwright, if available)

- **Console.** Zero console errors.
- **Paths.** No `NaN` in any SVG path `d`.
- **Overflow.** After Expand all, every label satisfies `scrollHeight ≤ clientHeight` and `scrollWidth ≤ clientWidth`. Run this in both themes and with one filter active.
- **Screenshots.** Take one of each changed case (jump to its stage, open the card) and review it yourself: branches correct, nothing overlapping, zones enclosing only automation steps, notes clear of the tree.

**Fallback.** If no headless browser is available, run the data lint, then ask the user to open the file and check the changed cases.

---

## 6. Known pitfalls

- **Stale layout.** Redrawing after closing a popover with an old layout gives NaN paths. Keep `hidePop()` (hide only) separate from `closePop()`, and call `hidePop()` before expand or collapse.
- **Overlays eating clicks.** Hint or toast overlays must have `pointer-events: none`.
- **Long labels.** Shorten the text before enlarging cards. Put the long version in `detail`.
- **Hidden-node math.** Zones and wires must use only visible nodes from the current layout.

---

## 7. Worked example (insurance claims, abbreviated)

- **Unit:** claim. **Closed:** "Claim settled or rejected in the core system".
- **Stages:** First notice → Assessment → Decision → Payment → After settlement.
- **Example case:** Assessment · "Document check".
  - Trigger: "Claim registered" (bot).
  - Automated OCR extracts the fields.
  - Decision "All documents present?":
    - Yes → "Assign adjuster".
    - No → "Request missing documents" (customer) → wait → reference card "↺ back to Document check".
  - Automation zone: "Workflow OCR-01 from ‘Claim registered’ to ‘Extract fields’ · hands back to: ‘Request missing documents’".
- **Overlay:** line of business × work type → adjuster group.

---

## 8. Working with the user

- **Keep replies short.** Say what changed and what still needs confirmation.
- **Operations-team feedback.** Compare it with the tree, fix it, and turn the remaining gaps into concrete questions ("where do late-cancelled orders come from?").
- **Posting on the user's behalf** (chat or email): draft first, send only after approval, and reply in the original thread.
- **Prioritising automation.** If the user later wants to rank automation opportunities, that is a separate deliverable. Export the manual steps (case, step, actor, systems, work type) as its starting table.
