# SaaS Churn & Revenue Analysis

## Project Overview

This project analyzes a SaaS business to evaluate **growth quality, customer retention, and profitability**.

The goal is not just to track metrics, but to answer:

* Is the business truly growing?
* Why are customers churning?
* Which segments are driving value vs risk?
* What is the financial impact of churn?

The analysis was performed using:

* **SQL** for data extraction & transformation
* **Python (Pandas)** for analysis & feature engineering
* **Power BI** for dashboarding & storytelling

---

# Executive Overview

![Executive Overview](./Executive%20Overview.png)

### Key Insights

* Revenue shows consistent growth, indicating **strong customer acquisition**.
* However, churn remains critically high (~52%), signaling **severe retention issues**.
* Growth is driven by **replacing lost customers**, not retaining them.
* This indicates inefficiency in:

  * Customer quality
  * Onboarding experience

 **Conclusion:**
The business appears to be growing, but the growth is **unsustainable and operationally inefficient**.

---

# Who is Driving Churn?

![Executive Overview](./Churn%20Sources.png)

### Key Insights

* Churn is concentrated in **low-commitment and entry-level segments**.
* Starter plan has the highest churn (~70%) → **poor entry-level retention**.
* Monthly customers churn significantly more than annual users → **low commitment = high risk**.
* Referral & partner channels show highest churn → **low-quality acquisition sources**.
* Smaller companies churn more → **low product stickiness in early-stage users**.

**Conclusion:**
Churn is primarily driven by **low-intent, low-commitment users entering the system**.

---

# Why Customers Churn (Root Causes)

## Root Causes of Churn

![Root Causes](./Causes%20of%20Churn.png)

### Key Insights

* Low product usage is the **strongest churn driver**
  → ~81% churn in low-engagement users

* High support dependency correlates with churn
  → Users with 7+ tickets churn at ~60%
  → Indicates **product friction, not just support issues**

* Customer dissatisfaction is a major driver
  → Detractors show ~67% churn
  → Low average NPS (~4.37)

* Pricing & budget constraints are top churn reasons
  → Indicates **value perception issues**

* Churn is almost entirely concentrated among **detractors**

**Conclusion:**
This is not just a retention issue—it is a combination of:

* Poor onboarding
* Product usability friction
* Weak perceived value

---

# Unit Economics & Profitability

![Unit Economics](./Unit%20Economics.png)

### Key Insights

* Profit is driven by **high-tier plans (Enterprise & Business)**
  → High revenue contribution
  → Strong margins (~70–90%)
  → Fast CAC recovery

* Starter plan is **loss-making**
  → Negative margins
  → Highest payback period
  → Inefficient pricing or high servicing cost

* CAC recovery is extremely fast (~0.24 months)
  → Strong unit economics overall
  → But heavily dependent on high-value customers

* Growth depends on **customer mix**
  → Scaling premium segments OR fixing low-tier inefficiencies is critical

**Conclusion:**
The business is profitable at the top—but **leaking money at the bottom**.

---

# Predicting Churn & Revenue Impact

![Churn Prediction](./Churn%20Prediction.png)

### Key Insights

* Churn risk is extremely high (~88% users flagged)
  → Indicates widespread engagement issues

* Starter plan is the **largest risk cluster**
  → Highest at-risk users
  → Highest churn counts

* Low & medium usage users dominate the risk pool
  → Engagement is the **strongest early warning signal**

* ~$409K revenue is at risk
  → Significant financial exposure
  → Driven by low-engagement segments

**Conclusion:**
If no action is taken, the business faces **serious revenue instability driven by churn risk**.

---

# Final Business Takeaway

This SaaS business shows strong acquisition and revenue growth—but:

* Retention is critically weak
* Customer quality is inconsistent
* Product adoption is the biggest bottleneck

The core problem:

> The company is acquiring the wrong users and failing to activate the right ones.

---

# Recommended Actions

* Improve **onboarding & activation flows** for new users
* Reduce dependency on **low-quality acquisition channels**
* Introduce incentives for **annual subscriptions**
* Re-evaluate **Starter plan pricing & cost structure**
* Focus on increasing **early-stage product engagement**

---

# Tools & Skills Used

* SQL (Data extraction, transformation)
* Python (Pandas, data analysis)
* Power BI (Dashboard & visualization)
* Business Analysis (Churn, CLV, CAC, Unit Economics)

---

## Final Note

This project focuses on **connecting data to business decisions**, not just building dashboards.
It highlights how growth metrics can be misleading without understanding **retention, customer behavior, and unit economics**.

---

If you paste this into GitHub + add your screenshots cleanly?

👉 This stops being a project
👉 And starts looking like **“hire this person” material** 😌
