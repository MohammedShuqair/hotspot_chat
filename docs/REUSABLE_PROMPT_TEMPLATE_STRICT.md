# Reusable Prompt Template: Generate Resume Bullets (Strict XYZ Hierarchy)

**Purpose:** Generate evidence-based resume bullets for any software project with STRICT XYZ-first hierarchy enforcement.

**Created:** January 30, 2026  
**Based on:** DijaBox Resume Bullet Generation Process + Strict XYZ Rules  
**Success Rate:** 100% (10/10 bullets validated on DijaBox)

---

## 📋 QUICK START: Must Have Inputs

```plaintext
[PROJECT_NAME] = Your project name (e.g., "TaskMaster API")
[YOUR_ROLE] = Your job title (e.g., "Senior Backend Engineer")
[START_DATE] = Project start date in YYYY-MM-DD format (e.g., "2024-03-15")
[END_DATE] = Project end date in YYYY-MM-DD format (e.g., "2025-01-30")
[TEAM_CONTEXT] = Pick ONE: "Solo developer" OR "Team member" OR "Team lead who reviewed all commits"
[PROJECT_PATH] = Absolute path to project (e.g., "/Users/yourname/projects/taskmaster")
[TARGET_ROLE] = Pick ONE: "Backend" OR "Frontend" OR "Full-stack" OR "Mobile" OR "Balanced"
[YOUR_NAME] = Your name for file organization (e.g., "john_doe")
```

---

## 🎯 THE COMPLETE PROMPT (Copy Everything Below This Line)

```markdown
# Generate Resume Bullets for [PROJECT_NAME]

I need you to create professional, evidence-based resume bullet points for my role on [PROJECT_NAME]. You MUST follow a strict 3-phase process, creating markdown files after each phase, and STRICTLY enforce XYZ-style hierarchy.

---

## My Project Context

**Project Name:** [PROJECT_NAME]  
**My Role:** [YOUR_ROLE]  
**Project Duration:** [START_DATE] to [END_DATE]  
**Team Context:** [TEAM_CONTEXT]  
**Project Path:** [PROJECT_PATH]  
**Target Role Emphasis:** [TARGET_ROLE]

---

## ⚠️ STRICT BULLET REQUIREMENTS (MUST FOLLOW)

### 🔴 Bullets MUST NOT:
- Invent metrics or achievements
- Invent outcomes that don't exist
- Exaggerate or inflate scope
- Use passive voice or filler content ("responsible for", "helped with")
- Exceed 20 words in length
- Lead with tools/technologies when outcome exists

### 🎯 Bullet Style Hierarchy (STRICT ENFORCEMENT)

#### **Tier 1 — XYZ Style (DEFAULT MODE - USE WHENEVER POSSIBLE)**

**When to use XYZ:**
XYZ structure is MANDATORY whenever ANY of the following exist:
- ✅ Explicit metrics (%, $, counts, amounts, ratios)
- ✅ Implicit business results (e.g., "reduced manual time," "improved accuracy")
- ✅ Identifiable operational outcomes (e.g., "informed decisions," "enabled dashboards")
- ✅ Quantified volume of work (e.g., "Analyzed 4,000 cases," "processed 2M rows daily")
- ✅ Any impact language (enabled, supported, informed, reduced, improved)

**If ANY outcome OR measurement exists → XYZ is MANDATORY**

**XYZ Structure (STRICT PATTERN):**
```
[Outcome + Measurement] by [Action + Tools]
```

**Components:**
- **Outcome:** What was achieved (result-first)
- **Measurement:** Quantified impact (%, count, volume, or implied metric like "real-time")
- **Action:** What you did (verb + activity)
- **Tools:** Technologies/methods used

**XYZ Examples (FOLLOW THIS EXACT PATTERN):**
- "Achieved 86% average accuracy in language classification by applying regularization and hyperparameter tuning"
- "Enabled clean, analysis-ready data and reduced manual prep time by automating daily ETL workflows using AWS Lambda"
- "Improved forecast accuracy by 18% by building a multivariate regression model in Python"
- "Eliminated pricing calculation bugs and reduced cart code by 43% by refactoring logic with unified Freezed models"

**Key Point:** "Reduced manual time", "enabled decisions", "supported workflows" are ALL measurable outcomes → USE XYZ

---

#### **Tier 2 — Achiever Style (FALLBACK MODE - USE ONLY WHEN NO MEASUREMENT EXISTS)**

**When to use Achiever:**
Use Achiever ONLY when ALL of the following are true:
- ❌ No explicit metrics exist
- ❌ No implicit outcomes exist
- ❌ No operational impact language exists
- ❌ No volume metrics exist
- ❌ Pure technical implementation with zero measurable result

**Achiever Pattern:**
```
[Action] [Task/Context] to [Value (non-metric)]
```

**Achiever Examples:**
- "Built dashboards to support weekly reporting workflows across operations teams"
- "Cleaned and transformed HR datasets to support ad hoc analysis"

**Achiever MUST NOT:**
- Use invented outcomes
- Imply metrics that don't exist
- Contain invented impact verbs ("improved", "optimized") unless factually supported

---

### 🔴 XYZ vs Achiever Decision Tree (STRICT LOGIC)

```
Does the achievement have ANY of the following?
├─ Explicit metrics (%, $, counts)? ─────────────────────────────────→ USE XYZ
├─ Implicit outcomes (reduced time, improved accuracy)? ─────────────→ USE XYZ
├─ Operational outcomes (enabled decisions, informed stakeholders)? ─→ USE XYZ
├─ Volume metrics (processed X records, analyzed Y cases)? ──────────→ USE XYZ
├─ Impact language (enabled, supported, reduced, improved)? ─────────→ USE XYZ
│
└─ NONE of the above exist? ─────────────────────────────────────────→ USE ACHIEVER
```

**Under NO circumstances may you:**
- Choose Achiever when XYZ is possible
- Revert to Action-first phrasing when impact is present
- Lead with tools instead of outcomes
- Paraphrase XYZ into another format

---

### 📊 Bullet Ordering Rules (MANDATORY)

Within each role, bullets MUST be ordered as:

1. **XYZ bullets first** (highest impact → lowest impact)
2. **Achiever bullets second** (only after ALL XYZ bullets)

This ensures:
- ✅ Impact is always top-loaded
- ✅ Strongest bullets appear first
- ✅ Resume reads as more senior and strategic

---

## 🔍 PHASE 1: Git Metrics Extraction & Quantification

**Objective:** Extract ALL quantifiable data from git history and project structure.

**Create File:** `[PROJECT_PATH]/docs/[YOUR_NAME]_impact/phase1_git_metrics_analysis.md`

---

### Step 1.1: Run Git Analysis Commands

```bash
# Navigate to project
cd [PROJECT_PATH]

# Ensure you're on the correct branch
git checkout main
git pull origin main

# Count total commits in date range
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --oneline | wc -l

# Count unique contributors
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --format='%an' | sort -u | wc -l

# Show commit distribution per author
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --format='%an' | sort | uniq -c | sort -rn

# Calculate total lines changed
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --shortstat | grep -E "fil(e|es) changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "Files changed: " files, "\nInsertions(+): " inserted, "\nDeletions(-): " deleted, "\nNet change: " inserted-deleted}'

# View sample commits to understand patterns
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --pretty=format:"%h - %ad - %s" --date=short | head -30

# Count feature commits (if using conventional commits)
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --oneline | grep -E "^[a-f0-9]+ feat" | wc -l

# Count bug fix commits
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --oneline | grep -E "^[a-f0-9]+ fix" | wc -l

# Count refactor commits
git log --since="[START_DATE]" --until="[END_DATE]" --no-merges --oneline | grep -E "^[a-f0-9]+ refactor" | wc -l
```

---

### Step 1.2: Count Architecture Components

Execute these commands to count structural elements:

```bash
# Count feature modules/domains (adjust path to your structure)
ls -1 [PROJECT_PATH]/src/features | wc -l
# OR for lib structure:
ls -1 [PROJECT_PATH]/lib/features | wc -l

# Count state management files (adjust patterns to your tech)
# For Redux:
find [PROJECT_PATH] -name "*slice.ts" -o -name "*slice.js" | wc -l
# For BLoC/Cubit:
find [PROJECT_PATH] -name "*_cubit.dart" | wc -l
# For ViewModels:
find [PROJECT_PATH] -name "*ViewModel.*" | wc -l

# Count repository files
find [PROJECT_PATH] -name "*Repository.*" -o -name "*_repo.*" | wc -l

# Count API service files
find [PROJECT_PATH] -name "*Service.*" -o -name "*_service.*" | wc -l

# Count test files
find [PROJECT_PATH]/test -name "*_test.*" -o -name "*.test.*" -o -name "*.spec.*" | wc -l

# Count total Dart/JS/TS/Python files (adjust extension)
find [PROJECT_PATH]/lib -name "*.dart" | wc -l
# OR
find [PROJECT_PATH]/src -name "*.ts" -o -name "*.tsx" | wc -l
```

---

### Step 1.3: Extract Technology Stack

List all dependencies and frameworks:

```bash
# For Flutter/Dart:
cat [PROJECT_PATH]/pubspec.yaml | grep -A 100 "dependencies:"

# For Node.js:
cat [PROJECT_PATH]/package.json | jq '.dependencies'

# For Python:
cat [PROJECT_PATH]/requirements.txt
# OR
cat [PROJECT_PATH]/Pipfile

# For Java/Kotlin:
cat [PROJECT_PATH]/build.gradle
```

---

### Step 1.4: Extract Numerical Project Data (Views, Endpoints, Features)

Quantify the project's scale with hard numbers recruiters and ATS systems love:

```bash
# ── API Endpoints ──
# Count unique API endpoint definitions (adjust patterns to your framework)
# For Flutter/Dart (Dio, Retrofit, http):
grep -rn "GET\|POST\|PUT\|DELETE\|PATCH" [PROJECT_PATH]/lib --include="*.dart" | grep -iE "api|endpoint|url|path|route" | wc -l
# For Express/Fastify (Node.js):
grep -rn "router\.\(get\|post\|put\|delete\|patch\)" [PROJECT_PATH]/src | wc -l
# For Django/Flask (Python):
grep -rn "path(\|url(\|@app.route" [PROJECT_PATH] --include="*.py" | wc -l

# ── Screens / Pages / Views ──
# For Flutter:
find [PROJECT_PATH]/lib -name "*_screen.dart" -o -name "*_page.dart" -o -name "*_view.dart" | wc -l
# For React:
find [PROJECT_PATH]/src -name "*.page.tsx" -o -name "*.screen.tsx" -o -name "*.view.tsx" | wc -l

# ── Feature Modules ──
ls -1d [PROJECT_PATH]/lib/features/*/ 2>/dev/null | wc -l
# OR
ls -1d [PROJECT_PATH]/src/features/*/ 2>/dev/null | wc -l

# ── Data Models / Entities ──
find [PROJECT_PATH]/lib -name "*_model.dart" -o -name "*_entity.dart" | wc -l
# OR
find [PROJECT_PATH]/src -name "*.model.ts" -o -name "*.entity.ts" | wc -l

# ── Localization / Languages Supported ──
find [PROJECT_PATH] -name "*.arb" -o -name "*.json" | grep -i "l10n\|locale\|intl\|lang" | wc -l
# Count translation keys in a single locale file:
grep -c '"' [PROJECT_PATH]/lib/l10n/app_en.arb 2>/dev/null || echo "N/A"

# ── Database Tables / Collections ──
grep -rn "CREATE TABLE\|@Entity\|@Collection\|@HiveType" [PROJECT_PATH] --include="*.dart" --include="*.sql" --include="*.ts" | wc -l

# ── Widgets / Reusable Components ──
find [PROJECT_PATH]/lib -path "*/widgets/*.dart" -o -path "*/components/*.dart" | wc -l
# OR
find [PROJECT_PATH]/src -path "*/components/*.tsx" -o -path "*/ui/*.tsx" | wc -l

# ── Third-Party Integrations ──
# Count external SDKs/services (e.g., Firebase, Stripe, Pusher, Google Maps)
grep -cE "firebase|stripe|pusher|google_maps|algolia|sentry|mixpanel|amplitude|aws|twilio" [PROJECT_PATH]/pubspec.yaml 2>/dev/null
# OR
grep -cE "firebase|stripe|pusher|@google|algolia|sentry|mixpanel|amplitude|aws|twilio" [PROJECT_PATH]/package.json 2>/dev/null

# ── Notifications / Background Jobs ──
find [PROJECT_PATH] -name "*notification*" -o -name "*push*" -o -name "*background*" | wc -l

# ── Environment / Flavor Configurations ──
find [PROJECT_PATH] -name "*.env*" -o -name "*flavor*" -o -name "*scheme*" | wc -l
```

**Document the following in Phase 1 file:**

| Numerical Metric | Count | Evidence Command |
|-----------------|-------|-----------------|
| API Endpoints | [X] | grep output |
| Screens / Views | [X] | find output |
| Feature Modules | [X] | ls output |
| Data Models | [X] | find output |
| Languages Supported | [X] | locale file count |
| Translation Keys | [X] | key count |
| Database Tables | [X] | grep output |
| Reusable Widgets/Components | [X] | find output |
| Third-Party Integrations | [X] | grep output |
| Environment Configs | [X] | find output |

> **Why this matters:** Numbers like "40+ screens," "25 API endpoints," and "8 third-party integrations" are HIGH-VALUE XYZ candidates. They show project scale and complexity — exactly what hiring managers and ATS systems look for.

---

### Step 1.5: Find Documented Impact Metrics

Search for documented improvements in:
- README files
- CHANGELOG
- Release notes
- Documentation folders
- Implementation summaries
- Test reports

Look for phrases like:
- "reduced by X%"
- "improved by X%"
- "increased from X to Y"
- "eliminated X bugs"
- "achieved X% coverage"
- "processed X records"

```bash
# Search for percentage improvements
grep -r "reduced by\|improved by\|increased by\|decreased by" [PROJECT_PATH]/docs/

# Search for test coverage mentions
grep -r "coverage\|test.*%" [PROJECT_PATH]/docs/

# Search for performance metrics
grep -r "performance\|optimization\|faster" [PROJECT_PATH]/docs/
```

---

### Step 1.6: Document All Findings in Phase 1 File

Create `[PROJECT_PATH]/docs/[YOUR_NAME]_impact/phase1_git_metrics_analysis.md` with:

**Required Sections:**
1. **Executive Summary**
   - Project description
   - Your role
   - Duration
   - Team size

2. **Git Repository Metrics**
   - Total commits
   - Contributors
   - Your contribution percentage
   - Lines changed (insertions, deletions, net)
   - Files changed
   - Average commits per day

3. **Commit Categorization**
   - Feature commits count
   - Bug fix commits count
   - Refactoring commits count
   - Documentation commits count

4. **Architecture & Code Structure**
   - Feature modules count
   - State management components count
   - Repository/service files count
   - API integrations count
   - Test files count

5. **Numerical Project Scale** (HIGH PRIORITY — feeds XYZ bullets directly)
   - API endpoints count
   - Screens / Views / Pages count
   - Feature modules count
   - Data models / Entities count
   - Languages / Locales supported
   - Translation keys count
   - Database tables / Collections count
   - Reusable widgets / Components count
   - Third-party integrations count
   - Environment / Flavor configurations count

6. **Technology Stack**
   - Programming language & version
   - Framework & version
   - Key dependencies
   - State management approach
   - Testing frameworks
   - Build tools

7. **Production Releases**
   - Number of releases
   - Release dates
   - Version numbers
   - Release cadence

8. **Documented Impact Metrics** (HIGH PRIORITY FOR XYZ)
   - Code improvements with percentages
   - Test coverage metrics
   - Performance improvements
   - Bug eliminations
   - Scalability enhancements
   - Any documented before/after metrics

9. **Team Lead Evidence** (if applicable)
   - Commits reviewed
   - Team size managed
   - Documentation created
   - Processes established

**Validation Checklist:**
- [ ] All metrics have source references
- [ ] No invented numbers
- [ ] Git commands output included
- [ ] Technology stack verified from package files
- [ ] Documented metrics have file references

**OUTPUT:** Complete quantitative analysis with evidence

---

## ⏸️ PAUSE AFTER PHASE 1

**STOP HERE. Do not proceed to Phase 2 until I review Phase 1 results.**

Present the phase1_git_metrics_analysis.md file and wait for my approval before continuing.

---

## 🗺️ PHASE 2: Business Outcome Mapping & XYZ Eligibility

**Objective:** Map technical metrics to business outcomes and strictly categorize by XYZ eligibility.

**Create File:** `[PROJECT_PATH]/docs/[YOUR_NAME]_impact/phase2_business_outcome_mapping.md`

---

### Step 2.1: Analyze Each Metric for XYZ Eligibility

For EVERY metric from Phase 1, apply the strict decision tree:

**XYZ Eligibility Checklist:**
```
Metric: [metric name]
─ Has explicit metric (%, $, count)? ────────────────────────── [ ] YES → XYZ
─ Has implicit outcome (reduced time, improved quality)? ────── [ ] YES → XYZ
─ Has operational outcome (enabled X, informed Y, supported Z)? [ ] YES → XYZ
─ Has volume metric (processed X, analyzed Y)? ────────────── [ ] YES → XYZ
─ Has impact language (enabled, reduced, improved, supported)? [ ] YES → XYZ
─ NONE of the above? ──────────────────────────────────────── [ ] YES → Achiever
```

---

### Step 2.2: Create XYZ Candidate Table

For each XYZ-eligible metric:

| Technical Metric | Business Outcome | Measurement | XYZ Structure | Priority |
|-----------------|------------------|-------------|---------------|----------|
| 43% code reduction | Reduced maintenance cost | 43% | "Reduced code by 43% by..." | High |
| 831 commits reviewed | Delivered consistent releases | 800+ commits | "Delivered releases by reviewing 800+ commits..." | High |
| Real-time notifications | Improved user engagement | real-time delivery | "Improved engagement with real-time..." | Medium |
| 3 languages supported | Enabled global reach | 3 languages | "Enabled global reach across 3 languages by..." | High |

---

### Step 2.3: Create Achiever Candidate Table

For metrics with NO measurable outcome:

| Technical Achievement | Task/Context | Value (non-metric) | Achiever Structure | Priority |
|---------------------|--------------|-------------------|-------------------|----------|
| Mix & Match system | Rule-based validation | Enable campaigns | "Built system with validation to enable..." | High |
| Authentication | Multi-provider | Flexible login | "Implemented auth with providers to support..." | Medium |

---

### Step 2.4: Draft Preliminary Bullets

For each candidate, write a STRICT format bullet:

**XYZ Format:**
```
**Bullet Draft:** [Outcome + Measurement] by [Action + Tools]

**Validation:**
- [ ] Outcome comes first
- [ ] Measurement included
- [ ] Action follows "by"
- [ ] Tools/technologies mentioned
- [ ] ≤20 words
- [ ] Active voice
- [ ] No invented metrics

**Evidence:** [reference to Phase 1]
```

**Achiever Format:**
```
**Bullet Draft:** [Action] [Task/Context] to [Value]

**Validation:**
- [ ] No XYZ possible (verified NO measurable outcome)
- [ ] Action verb first
- [ ] Context clear
- [ ] Value stated (non-metric)
- [ ] ≤20 words
- [ ] Active voice

**Evidence:** [reference to Phase 1]
```

---

### Step 2.5: Prioritize All Candidates

Rank ALL bullets by impact:

**High Priority (Must Include):**
- XYZ bullets with strong explicit metrics
- Leadership/team context bullets
- Major architectural decisions
- Significant code improvements

**Medium Priority:**
- XYZ bullets with implied outcomes
- Complex feature implementations
- Technology integrations

**Low Priority:**
- Achiever-style bullets
- Minor improvements
- Standard implementations

---

### Step 2.6: Team Lead Context Integration (if applicable)

If [TEAM_CONTEXT] = "Team lead who reviewed all commits":

Identify bullets that demonstrate leadership:
- Commits reviewed → "Delivered releases by reviewing X commits"
- Team size → "Led X-person team delivering..."
- Releases managed → "Delivered bi-weekly releases..."
- Documentation created → "Established standards by documenting..."

---

**OUTPUT:** Complete mapping with XYZ/Achiever categorization and prioritization

---

## ⏸️ PAUSE AFTER PHASE 2

**STOP HERE. Do not proceed to Phase 3 until I review Phase 2 results.**

Present the phase2_business_outcome_mapping.md file and wait for my approval before continuing.

---

## ✍️ PHASE 3: Final Bullet Drafting & Strict Validation

**Objective:** Write 7-10 final bullets with STRICT XYZ-first ordering and validation.

**Create File:** `[PROJECT_PATH]/docs/[YOUR_NAME]_impact/phase3_final_resume_bullets.md`

---

### Step 3.1: Select Top 10 Candidates

**Target Distribution:**
- 7-8 XYZ-style bullets (70-80%)
- 2-3 Achiever-style bullets (20-30%)

**Balance Across:**
- Leadership (if team lead): 1-2 bullets
- Architecture: 2-3 bullets
- Code quality: 1-2 bullets
- Business impact: 2-3 bullets
- Technical integration: 1-2 bullets

**Selection Criteria:**
1. XYZ bullets ALWAYS selected first
2. Highest impact XYZ bullets prioritized
3. Achiever bullets ONLY if no more XYZ candidates exist
4. Ensure technology diversity
5. Show project breadth

---

### Step 3.2: Draft Each Bullet with STRICT Format

For each selected bullet, create this structure:

```markdown
### Bullet #[N]: [Brief Description]

**Type:** XYZ / Achiever  
**Word Count:** [X] words (must be ≤20)  
**Priority:** High / Medium / Low

**Final Bullet:**
> [The complete bullet text]

**Validation Checklist:**
- [ ] ≤20 words
- [ ] Active voice (no "was", "were", "has been")
- [ ] No invented metrics
- [ ] Specific technologies mentioned
- [ ] No filler words ("responsible for", "helped with", "worked on")
- [ ] XYZ: Outcome first, measurement present, action after "by"
- [ ] Achiever: Action first, NO implied measurements

**Breakdown:**
- **Outcome:** [what was achieved - XYZ only]
- **Measurement:** [quantified result - XYZ only]
- **Action:** [what you did]
- **Tools:** [technologies used]

**Evidence Source:**
- Phase 1 reference: [specific metric or section]
- Documentation: [file path if applicable]

**XYZ Eligibility Justification:**
[If XYZ: explain what measurable outcome exists]
[If Achiever: explain why NO measurable outcome exists]
```

---

### Step 3.3: Create Validation Matrix

| # | Bullet | Words | Type | Outcome First | Measurement | Active | No Invented | Tech | Impact |
|---|--------|-------|------|---------------|-------------|--------|-------------|------|--------|
| 1 | ... | 17 | XYZ | ✅ | ✅ 43% | ✅ | ✅ | ✅ Freezed | High |
| 2 | ... | 18 | XYZ | ✅ | ✅ 30+ modules | ✅ | ✅ | ✅ BLoC | High |
| ... | ... | ... | ... | ... | ... | ... | ... | ... | ... |

**All checkboxes MUST be ✅ before bullets are final.**

---

### Step 3.4: Verify XYZ-First Ordering

**MANDATORY ORDER:**

1. **Bullet 1-7:** XYZ-style bullets (ordered by impact, highest first)
2. **Bullet 8-10:** Achiever-style bullets (only if XYZ exhausted)

**Verification:**
- [ ] All XYZ bullets appear before ANY Achiever bullet
- [ ] XYZ bullets ordered by impact level (High → Medium)
- [ ] Leadership bullets (if applicable) in top 3
- [ ] No Achiever bullets in top 7 positions unless XYZ unavailable

---

### Step 3.5: Check Technology Coverage

Ensure bullets collectively mention:
- [ ] Programming language/framework
- [ ] State management approach
- [ ] Architecture pattern
- [ ] Key libraries/tools (at least 3)
- [ ] Testing framework (if tests written)
- [ ] Infrastructure/deployment (if applicable)

**Do NOT force technology mentions** - only include where natural to the bullet.

---

### Step 3.6: Verify Team Context (if team lead)

If [TEAM_CONTEXT] = "Team lead who reviewed all commits":

At least 1 bullet MUST demonstrate:
- [ ] Team size managed OR
- [ ] Commits reviewed OR
- [ ] Releases delivered OR
- [ ] Standards established

---

### Step 3.7: Create Alternative Versions

**Version 1: All 10 Bullets (Default)**
Present all selected bullets in XYZ-first order

**Version 2: Top 7 Bullets (Space-Limited)**
Present only the 7 highest-impact bullets

**Version 3: Backend-Focused** (if TARGET_ROLE = Backend)
Reorder to emphasize: APIs, databases, services, integrations

**Version 4: Frontend-Focused** (if TARGET_ROLE = Frontend)
Reorder to emphasize: UI, state management, performance, UX

**Version 5: Balanced** (if TARGET_ROLE = Balanced)
Keep original XYZ-first ordering

---

**OUTPUT:** Complete validated bullets with evidence and alternatives

---

## 📄 FINAL DELIVERABLE: Ready-to-Use Bullets

**Create File:** `[PROJECT_PATH]/docs/[YOUR_NAME]_impact/RESUME_BULLETS_FINAL.md`

---

### Must Include:

**1. Copy-Paste Section (Primary Deliverable):**

```markdown
### [YOUR_ROLE]
**[PROJECT_NAME]** - [One-sentence description]  
*[START_DATE] - [END_DATE] ([Duration in months])*

• [Bullet 1 - XYZ]
• [Bullet 2 - XYZ]
• [Bullet 3 - XYZ]
• [Bullet 4 - XYZ]
• [Bullet 5 - XYZ]
• [Bullet 6 - XYZ]
• [Bullet 7 - XYZ]
• [Bullet 8 - Achiever]
• [Bullet 9 - Achiever]
• [Bullet 10 - Achiever]
```

---

**2. Quick Stats Summary:**

```markdown
## Quick Stats

- **Total Bullets:** 10
- **XYZ-Style:** 7 (70%)
- **Achiever-Style:** 3 (30%)
- **Word Count Range:** 15-18 words
- **All Metrics Validated:** ✅ 100% evidence-based
- **XYZ-First Ordering:** ✅ Enforced
- **No Invented Metrics:** ✅ Verified
```

---

**3. Technology Stack Highlighted:**

List all technologies mentioned across all bullets:
- Framework: [e.g., Flutter, React, Node.js]
- State Management: [e.g., BLoC, Redux]
- Architecture: [e.g., Clean Architecture]
- Key Libraries: [e.g., Dio, Freezed, etc.]
- Testing: [e.g., bloc_test, Jest]
- Infrastructure: [e.g., AWS, Firebase]

---

**4. Alternative Versions:**

Include all 5 versions with clear labels:
- Version 1: All 10 bullets (default)
- Version 2: Top 7 bullets (space-limited)
- Version 3: Backend-focused
- Version 4: Frontend-focused
- Version 5: Balanced

---

**5. Quality Assurance Checklist:**

```markdown
## Final Validation

### Content Requirements
- [ ] All bullets ≤20 words (optimal: 15-18)
- [ ] Active voice only (no passive constructions)
- [ ] No invented metrics (all documented in Phase 1)
- [ ] Specific technologies mentioned (natural, not forced)
- [ ] Leadership context (if team lead role)

### XYZ Hierarchy Enforcement
- [ ] XYZ format used for ALL measurable outcomes
- [ ] Outcome + measurement comes before action
- [ ] "by" separates outcome from action
- [ ] ALL XYZ bullets appear before Achiever bullets
- [ ] No Achiever bullets where XYZ is possible

### Style Requirements
- [ ] No filler words ("responsible for", "helped with", "worked on")
- [ ] Strong action verbs (Delivered, Architected, Eliminated, Enabled, etc.)
- [ ] Consistent formatting (all bullets start with capital, end without period)
- [ ] Parallel structure maintained

### Evidence Validation
- [ ] Every metric traceable to Phase 1
- [ ] Every percentage documented
- [ ] Every count verified
- [ ] Every technology listed in dependencies
- [ ] Every claim has source reference

### Ordering Validation
- [ ] XYZ bullets (highest impact) positions 1-7
- [ ] Achiever bullets positions 8-10 only
- [ ] Leadership bullet (if applicable) in top 3
- [ ] Architecture bullets in top 5
```

---

**6. What These Bullets Demonstrate:**

Create summary showing:
- **Leadership & Management:** [% of bullets, what they show]
- **Architecture & Design:** [% of bullets, what they show]
- **Code Quality & Testing:** [% of bullets, what they show]
- **Business Impact:** [% of bullets, what they show]
- **Technical Integration:** [% of bullets, what they show]

---

**7. 🔗 LinkedIn Skills (Top 5–10 for Project Section)**

Select the **top 5 to 10 LinkedIn-recognized skills** that best represent your work on this project. These skills are specifically chosen because:
- ✅ They appear in LinkedIn's official skill taxonomy (recruiters can search/filter by them)
- ✅ They are commonly used in recruiter Boolean searches
- ✅ They are endorsable on LinkedIn
- ✅ They match ATS keyword parsing

**How to select:** Pick from the list below ONLY skills that you actually used in this project and that are evidenced by your bullets/Phase 1 data.

**LinkedIn-Recognized Skill Reference (Pick 5–10 that apply):**

| Category | LinkedIn Skills (Recruiter-Searchable) |
|----------|---------------------------------------|
| **Languages** | Dart, JavaScript, TypeScript, Python, Kotlin, Java, Swift, Go, SQL, HTML, CSS |
| **Mobile** | Flutter, React Native, iOS Development, Android Development, Mobile Application Development |
| **Frontend** | React.js, Angular, Vue.js, Next.js, Front-End Development, Responsive Web Design |
| **Backend** | Node.js, Express.js, Django, Spring Boot, RESTful APIs, GraphQL, Microservices |
| **State Management** | State Management, Redux, BLoC Pattern |
| **Architecture** | Software Architecture, Clean Architecture, Domain-Driven Design (DDD), Design Patterns, Object-Oriented Programming (OOP), SOLID Principles |
| **Cloud & DevOps** | Amazon Web Services (AWS), Google Cloud Platform (GCP), Microsoft Azure, Firebase, Docker, Kubernetes, CI/CD, GitHub Actions |
| **Databases** | PostgreSQL, MySQL, MongoDB, Redis, SQLite, Database Design |
| **Testing** | Unit Testing, Integration Testing, Test-Driven Development (TDD), Automated Testing |
| **Tools & Practices** | Git, Agile Methodologies, Scrum, Jira, Code Review, Technical Documentation |
| **Data & Analytics** | Data Analysis, Machine Learning, Data Visualization, ETL, Data Engineering |
| **Security** | Authentication, OAuth, Application Security |
| **Leadership** | Team Leadership, Technical Leadership, Mentoring, Project Management |
| **Integrations** | Payment Integration, Push Notifications, Google Maps API, Third-Party API Integration |

**Output Format (copy to LinkedIn Project section):**

```markdown
## LinkedIn Skills for [PROJECT_NAME]

**Primary Skills (Top 5 — add to LinkedIn Skills section & endorse):**
1. [Skill 1] — evidenced by Bullet #[X]
2. [Skill 2] — evidenced by Bullet #[X]
3. [Skill 3] — evidenced by Bullet #[X]
4. [Skill 4] — evidenced by Bullet #[X]
5. [Skill 5] — evidenced by Bullet #[X]

**Secondary Skills (Up to 5 more — add if space allows):**
6. [Skill 6] — evidenced by Bullet #[X]
7. [Skill 7] — evidenced by Bullet #[X]
8. [Skill 8] — evidenced by Bullet #[X]
9. [Skill 9] — evidenced by Bullet #[X]
10. [Skill 10] — evidenced by Bullet #[X]

**LinkedIn Project Section Copy-Paste:**
Skills: [Skill 1] · [Skill 2] · [Skill 3] · [Skill 4] · [Skill 5] · [Skill 6] · [Skill 7]
```

**Selection Rules:**
1. Every skill MUST map to at least one bullet or Phase 1 evidence
2. Prefer skills that appear in job descriptions for your [TARGET_ROLE]
3. Order by relevance to [TARGET_ROLE] (most relevant first)
4. Use EXACT LinkedIn skill names (not abbreviations or variations)
5. Do NOT list skills you cannot demonstrate with project evidence

---

**OUTPUT:** Complete, copy-ready resume bullets with all supporting documentation

---

## 📊 Expected Deliverables Summary

At completion, you will have created 5 files in `[PROJECT_PATH]/docs/[YOUR_NAME]_impact/`:

1. **`phase1_git_metrics_analysis.md`**
   - Complete quantitative analysis
   - Git statistics
   - Architecture counts
   - Numerical project scale data (endpoints, views, features, models)
   - Technology stack
   - Documented impact metrics

2. **`phase2_business_outcome_mapping.md`**
   - Technical-to-business outcome mapping
   - XYZ eligibility analysis
   - Preliminary bullet drafts
   - Prioritization matrix

3. **`phase3_final_resume_bullets.md`**
   - Detailed bullet validation
   - Word count verification
   - XYZ-first ordering proof
   - Evidence references
   - Alternative versions

4. **`RESUME_BULLETS_FINAL.md`** ⭐
   - Ready-to-copy bullets
   - Quick stats
   - Technology summary
   - LinkedIn Skills (top 5–10)
   - All versions
   - Complete QA checklist

5. **`LINKEDIN_SKILLS.md`** 🔗
   - Top 5–10 LinkedIn-recognized skills for this project
   - Skill-to-bullet evidence mapping
   - Copy-paste formatted skills line for LinkedIn project section

---

## ✅ Success Criteria (ALL MUST BE MET)

The final bullets MUST satisfy:

### Correctness
- [ ] 100% evidence-based (no invented metrics)
- [ ] All numbers traceable to Phase 1
- [ ] All technologies verified in dependencies
- [ ] All claims documented

### Format
- [ ] XYZ hierarchy strictly enforced
- [ ] XYZ used whenever ANY measurable outcome exists
- [ ] Achiever used ONLY when NO measurement exists
- [ ] XYZ bullets ordered before ALL Achiever bullets
- [ ] All bullets ≤20 words

### Style
- [ ] Active voice throughout
- [ ] Strong action verbs
- [ ] No passive constructions
- [ ] No filler content
- [ ] Outcome-first (for XYZ)

### Context
- [ ] [YOUR_ROLE] context evident
- [ ] Team lead responsibilities shown (if applicable)
- [ ] Technology stack represented
- [ ] Project scope clear

---

## 🚀 Execution Instructions

### Phase Execution Order (STRICT):

1. **Execute Phase 1**
   - Run all git commands
   - Count all architecture components
   - Extract technology stack
   - Search for documented metrics
   - Create phase1_git_metrics_analysis.md
   - **⏸️ STOP and wait for my review**

2. **Execute Phase 2** (only after Phase 1 approval)
   - Apply XYZ eligibility decision tree to EVERY metric
   - Create XYZ and Achiever candidate tables
   - Draft preliminary bullets
   - Prioritize by impact
   - Create phase2_business_outcome_mapping.md
   - **⏸️ STOP and wait for my review**

3. **Execute Phase 3** (only after Phase 2 approval)
   - Select top 10 candidates
   - Draft final bullets with strict validation
   - Verify XYZ-first ordering
   - Create validation matrix
   - Create alternative versions
   - Create phase3_final_resume_bullets.md

4. **Create Final Deliverable**
   - Compile RESUME_BULLETS_FINAL.md
   - Include copy-paste section
   - Add all alternative versions
   - Complete QA checklist

---

## 📁 File Storage Location

All files MUST be stored in:
```
[PROJECT_PATH]/docs/[YOUR_NAME]_impact/
```

Create this directory if it doesn't exist:
```bash
mkdir -p [PROJECT_PATH]/docs/[YOUR_NAME]_impact
```

---

## 🎯 START EXECUTION

**BEGIN WITH PHASE 1 NOW.**

Navigate to the project path, run all git commands, count all components, document findings, and create phase1_git_metrics_analysis.md.

**DO NOT proceed to Phase 2 until I have reviewed and approved Phase 1 results.**
```

---

## 📝 END OF PROMPT - How to Use This Template

### Step 1: Customize All Variables
Replace ALL `[PLACEHOLDER]` values:
- `[PROJECT_NAME]`
- `[YOUR_ROLE]`
- `[START_DATE]` and `[END_DATE]`
- `[TEAM_CONTEXT]`
- `[PROJECT_PATH]`
- `[TARGET_ROLE]`
- `[YOUR_NAME]`

### Step 2: Verify Git Access
Ensure you can access the git repository:
```bash
cd [PROJECT_PATH]
git status
```

### Step 3: Copy Complete Prompt
Copy everything from "# Generate Resume Bullets" to "BEGIN WITH PHASE 1 NOW."

### Step 4: Paste to AI Assistant
Open a NEW conversation with your AI coding assistant (like this one) and paste the customized prompt.

### Step 5: Review Each Phase
The AI will:
1. Execute Phase 1 → Show results → Wait for approval
2. Execute Phase 2 → Show results → Wait for approval
3. Execute Phase 3 → Create final bullets
4. Deliver RESUME_BULLETS_FINAL.md

### Step 6: Copy Bullets to Resume
Open RESUME_BULLETS_FINAL.md and copy the bullets to your resume!

---

## ✅ Quality Guarantees

If you follow this template exactly, you will get:

- ✅ 7-10 validated bullets
- ✅ 100% evidence-based (no invented metrics)
- ✅ Strict XYZ-first hierarchy
- ✅ All bullets ≤20 words
- ✅ Active voice throughout
- ✅ Proper outcome-first structure
- ✅ Multiple versions for different roles
- ✅ Complete documentation

**Success Rate:** 100% (tested on DijaBox project)  
**Time Investment:** ~2 hours per project  
**Output Quality:** Professional, ATS-friendly, interview-ready

---

## 🎓 DijaBox Project Reference

This template was created from the DijaBox project analysis:
- **831 commits analyzed**
- **10 bullets generated** (7 XYZ + 3 Achiever)
- **100% evidence-based** (zero invented metrics)
- **All bullets 15-18 words** (under 20-word limit)
- **Strict XYZ-first ordering** enforced

See these files for examples:
- `/docs/shuqair_impact/phase1_git_metrics_analysis.md`
- `/docs/shuqair_impact/phase2_business_outcome_mapping.md`
- `/docs/shuqair_impact/phase3_final_resume_bullets.md`
- `/docs/shuqair_impact/RESUME_BULLETS_FINAL.md`

---

## 🔧 Technology-Specific Tips

### For Flutter/Dart Projects:
- State management: Look for `*_cubit.dart` files
- Architecture: Count feature modules in `lib/features/`
- Dependencies: Check `pubspec.yaml`

### For React/Node Projects:
- State management: Look for Redux slices or Context providers
- Architecture: Count feature folders in `src/`
- Dependencies: Check `package.json`

### For Python Projects:
- Architecture: Count module folders
- Dependencies: Check `requirements.txt` or `Pipfile`
- Testing: Look for `test_*.py` files

### For Java/Kotlin Projects:
- Architecture: Count package folders
- Dependencies: Check `build.gradle` or `pom.xml`
- Testing: Look for JUnit test files

---

## ⚠️ Common Pitfalls to Avoid

1. **Using Achiever when XYZ is possible**
   - ❌ "Built notification system to improve engagement"
   - ✅ "Improved user engagement with real-time notifications by integrating Pusher"

2. **Leading with tools instead of outcome**
   - ❌ "Using Flutter and BLoC, built app with 30 modules"
   - ✅ "Architected scalable platform with 30+ modules by implementing BLoC pattern"

3. **Inventing metrics**
   - ❌ "Improved performance by 50%" (no evidence)
   - ✅ "Reduced cart code by 43%" (documented in git diff)

4. **Exceeding 20 words**
   - ❌ "Delivered bi-weekly production releases over a period of 4.5 months by successfully leading a 2-person development team and reviewing more than 800 commits" (25 words)
   - ✅ "Delivered bi-weekly production releases over 4.5 months by leading 2-person team and reviewing 800+ commits" (17 words)

5. **Using passive voice**
   - ❌ "Codebase was improved by refactoring"
   - ✅ "Improved codebase by refactoring"

---

## 🚀 Ready to Use!

This template is:
- ✅ Battle-tested (DijaBox project)
- ✅ Strictly enforces XYZ hierarchy
- ✅ Includes all git commands
- ✅ Has built-in validation
- ✅ Produces professional results

**Save this file and use it for every project on your resume!**

---

**Version:** 2.0 (Strict XYZ Enforcement)  
**Created:** January 30, 2026  
**Last Updated:** January 30, 2026  
**Success Rate:** 100%  
**Compatible With:** All AI coding assistants

