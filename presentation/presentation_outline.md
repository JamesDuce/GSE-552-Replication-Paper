# GSE 552 Replication Project — 5-Minute Presentation Outline
## Jones & Marinescu (2022): Labor Market Impacts of the Alaska Permanent Fund

**Presenter:** James Duce | **Time target:** ~5 minutes | **Reference:** `paper/paper.pdf`

---

## Slide 1: Introduction (~30 seconds)

**Title:** Replicating Jones & Marinescu (2022): Does Universal Cash Reduce Work?

**Bullet points:**
- Paper: "The Labor Market Impacts of Universal and Permanent Cash Transfers: Evidence from the Alaska Permanent Fund"
- Authors: Damon Jones (U Chicago) & Ioana Marinescu (UPenn)
- Journal: American Economic Journal: Economic Policy (2022)

**Speaker notes:**
"My name is James Duce and I'm replicating a 2022 paper by Jones and Marinescu, published in the AEJ: Economic Policy. The paper uses Alaska as a natural experiment to study whether giving everyone unconditional cash reduces how much people work. This is directly relevant to the Universal Basic Income debate."

---

## Slide 2: Research Question (~30 seconds)

**Title:** Does Unconditional Cash Make People Work Less?

**Bullet points:**
- Alaska Permanent Fund Dividend: every resident gets ~$1,000–$2,000/year since 1982
- Universal, permanent, unconditional — no work requirement
- Standard theory predicts: more income → less work (negative income effect)
- Key causal question: does the APF dividend reduce employment?

**Speaker notes:**
"The core question is whether receiving unconditional money reduces work. Standard economics says yes — if you're richer, you buy more leisure. Alaska's dividend is unique because it's given to literally every resident, every year, permanently. There's no phase-out, no means-testing, so it's a clean test of the income effect."

---

## Slide 3: Estimation Technique — Synthetic Control Method (~60 seconds)

**Title:** The Synthetic Control Method (SCM)

**Bullet points:**
- Problem: everyone in Alaska received the dividend — no within-state control group
- SCM builds a "Synthetic Alaska" from a weighted combination of other states
- Weights chosen to match Alaska's pre-1982 labor market as closely as possible
- Donor states with positive weights: Utah, Wyoming, Washington, Nevada, Montana, Minnesota
- Post-1982 divergence = estimated treatment effect

**Equation to show:**
$$\hat{Y}_{0t}(0) = \sum_j w_j^* Y_{jt}, \quad \hat{\alpha}_{0t} = Y_{0t} - \hat{Y}_{0t}(0)$$

**Speaker notes:**
"Since every Alaskan got the dividend, there's no natural comparison group inside Alaska. The authors' solution is the Synthetic Control Method: they take other states — like Utah and Wyoming — and find weights for each that make the weighted average match Alaska's employment rate, demographics, and industry mix before 1982. After 1982, they compare actual Alaska to this 'Synthetic Alaska.' Any gap that opens up is the estimated effect of the dividend."

---

## Slide 4: Why SCM Is Needed (~30 seconds)

**Title:** Why Not Difference-in-Differences?

**Bullet points:**
- DiD needs a valid control group: another state that *didn't* get the treatment
- No such state exists — the treatment is state-wide and universal
- Simple before/after comparison confounds other shocks (oil boom, federal spending)
- SCM is specifically designed for single treated units with good pre-period data

**Speaker notes:**
"You might ask: why not just compare Alaska to some other state? The problem is that Alaska experienced a unique oil boom in the same period, so any simple comparison would conflate the dividend with the oil boom. SCM handles this by using the pre-period data to explicitly construct a valid counterfactual — it lets the data pick the right comparison."

---

## Slide 5: Data (~45 seconds)

**Title:** Data: CPS State-Year Panel, 1977–2014

**Show summary table from paper/paper.pdf (Table: Descriptive Statistics)**

**Bullet points:**
- Source: Current Population Survey (CPS), monthly, all 50 states + D.C.
- Sample: July 1977 – June 2015 (~48.7 million individual observations)
- Unit of analysis: state × year cell
- Treatment: Alaska × post-1982 indicator
- Key outcomes: employment rate, part-time rate, LFP rate, hours worked

**Speaker notes:**
"The data come from the Current Population Survey — the main U.S. labor market survey. It covers all states from 1977 to 2015, giving five pre-treatment years and 33 post-treatment years. The pre-treatment employment rate in Alaska was about 63.9%, and the part-time rate was about 10.3%. These are the benchmarks we're measuring effects against."

---

## Slide 6: What I Replicated (~30 seconds)

**Title:** Replication Target: Table 2 + Figures 2–3

**Show GitHub repo page (https://github.com/jamesduce)**

**Bullet points:**
- Table 2: average treatment effects for all four outcomes (1982–2014)
- Figure 2: employment rate — Alaska vs Synthetic Alaska (1977–2014)
- Figure 3: part-time rate — Alaska vs Synthetic Alaska (1977–2014)
- Replicated in R using the `Synth` package (translated from original Stata code)

**Speaker notes:**
"Here's my GitHub repository showing the full replication pipeline. I replicated Table 2, which is the paper's main result, and the two key figures. The original code is in Stata; I translated it to R using the Synth package, which implements the same quadratic programming solver."

---

## Slide 7: Results (~45 seconds)

**Title:** Results: No Employment Effect, But Part-Time Work Rises

**Show Figure 2 and Figure 3 / Table 2**

**Bullet points:**
- Employment rate: α̂₀ = 0.001, p = 0.942 — **not significant**
- Part-time rate: α̂₀ = 0.018**, p = 0.020 — **significant, +1.8 pp (+17%)**
- LFP rate: α̂₀ = 0.012, p = 0.331 — not significant
- Hours worked: α̂₀ = −0.796, p = 0.084 — marginally significant

**Speaker notes:**
"The main result is in Figure 2: after 1982, actual Alaska's employment rate tracks Synthetic Alaska almost perfectly — no divergence. But Figure 3 shows a clear upward divergence in part-time work. The number: the dividend raised part-time employment by 1.8 percentage points, which is a 17% increase from the pre-period mean. This effect is concentrated among married women."

---

## Slide 8: Interpretation (~45 seconds)

**Title:** Why No Employment Effect? General Equilibrium

**Bullet points:**
- Standard theory: income ↑ → labor supply ↓ → employment ↓
- But: every Alaskan spends the dividend locally → local demand ↑ → labor demand ↑
- Income effect (−0.6 pp) nearly cancelled by demand effect (+0.5 pp) → net ≈ 0
- Part-time increase: income effect operates on the intensive margin (hours), not the extensive margin (employment)

**Speaker notes:**
"Here's the key insight: when everyone in a state gets extra income simultaneously, they spend it locally, boosting demand for restaurants, retail, healthcare — all non-tradable services. That demand boost creates jobs, offsetting the reduction in labor supply. The two effects nearly cancel. But the hours-per-worker margin is different: workers can shift to part-time without those jobs disappearing, so that's where the income effect shows up."

---

## Slide 9: Replication Challenges (~30 seconds)

**Title:** Challenges

**Bullet points:**
- Data size: ~500 MB replication package, requires OpenICPSR account
- Stata → R translation: mapping `synth` command arguments to R's `Synth` package
- Computational time: 1,836 placebo tests ≈ 2–4 hours in R
- CPS variable harmonization: employment status codes change across survey years (1977–2015)

**Speaker notes:**
"The main practical challenges: the data is large and not on GitHub, the code had to be translated from Stata to R, and the placebo inference is computationally intensive — running 1,836 synthetic controls takes a few hours. The lesson: even with a well-documented replication package, translation across software platforms requires careful checking."

---

## Slide 10: Conclusion (~30 seconds)

**Title:** What I Learned

**Bullet points:**
- Universal cash transfers need not reduce employment — GE effects matter
- Income effects operate on the intensive margin (hours) more than the extensive margin (participation)
- SCM provides credible causal inference for single treated units
- Replication teaches you the paper in a way reading it never does

**Speaker notes:**
"The big lesson from this paper is that macro and micro effects of policy can be very different. A micro analysis of individual recipients would find a negative income effect. But at the macro level, the aggregate demand created by universal cash offsets that. For UBI policy: the employment effects may be much smaller than standard labor supply models predict. And the replication process itself was incredibly educational — you don't really understand the synthetic control method until you've implemented it yourself."

---

## Timing Guide

| Slide | Topic | Time |
|---|---|---|
| 1 | Introduction | 0:30 |
| 2 | Research question | 0:30 |
| 3 | Estimation technique (SCM) | 1:00 |
| 4 | Why SCM | 0:30 |
| 5 | Data | 0:45 |
| 6 | What I replicated | 0:30 |
| 7 | Results | 0:45 |
| 8 | Interpretation | 0:45 |
| 9 | Challenges | 0:30 |
| 10 | Conclusion | 0:15 |
| **Total** | | **~6:00** |

*Trim slides 4 and 9 to 20 seconds each to hit exactly 5:00.*
