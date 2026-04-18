-- Check total rows in both datasets
SELECT COUNT(*) FROM subscriptions;
SELECT COUNT(*) FROM monthly_revenue;

-- Preview data
SELECT * FROM subscriptions;
SELECT * FROM monthly_revenue;

-- Check missing values in key columns
SELECT 
  COUNT(*) - COUNT(churn_date) AS missing_churn_date,
  COUNT(*) - COUNT(churn_reason) AS missing_churn_reason,
  COUNT(*) - COUNT(feature_usage_pct) AS missing_usage,
  COUNT(*) - COUNT(nps_score) AS missing_nps
FROM subscriptions;

-- Check inconsistent churn records
SELECT *
FROM subscriptions
WHERE churned = 1 AND churn_date IS NULL;

SELECT *
FROM subscriptions
WHERE churned = 0 AND churn_date IS NOT NULL;

-- Check date ranges
SELECT 
  MIN(signup_date) AS earliest_signup,
  MAX(signup_date) AS latest_signup
FROM subscriptions;

-- Check invalid churn dates
SELECT COUNT(*)
FROM subscriptions
WHERE churn_date < signup_date;

-- Check category values
SELECT DISTINCT plan FROM subscriptions;
SELECT DISTINCT billing_cycle FROM subscriptions;
SELECT DISTINCT acquisition_channel FROM subscriptions;
SELECT DISTINCT company_size FROM subscriptions;
SELECT DISTINCT churn_reason FROM subscriptions;

-- Distribution checks
SELECT plan, COUNT(*) FROM subscriptions GROUP BY plan;
SELECT billing_cycle, COUNT(*) FROM subscriptions GROUP BY billing_cycle;
SELECT churned, COUNT(*) FROM subscriptions GROUP BY churned;

-- Row count
SELECT COUNT(*) AS total_rows FROM monthly_revenue;

-- Date range
SELECT 
  MIN(month) AS start_month,
  MAX(month) AS end_month
FROM monthly_revenue;

-- Missing values
SELECT 
  COUNT(*) - COUNT(total_active_customers) AS missing_active,
  COUNT(*) - COUNT(new_customers) AS missing_new,
  COUNT(*) - COUNT(churned_customers) AS missing_churned,
  COUNT(*) - COUNT(monthly_churn_rate_pct) AS missing_churn_rate,
  COUNT(*) - COUNT(total_mrr) AS missing_mrr,
  COUNT(*) - COUNT(avg_revenue_per_customer) AS missing_arpu,
  COUNT(*) - COUNT(customer_acquisition_cost) AS missing_cac
FROM monthly_revenue;

-- Logical checks
SELECT *
FROM monthly_revenue
WHERE 
  total_active_customers < 0 OR
  new_customers < 0 OR
  churned_customers < 0 OR
  total_mrr < 0;

SELECT *
FROM monthly_revenue
WHERE churned_customers > total_active_customers;

-- Validate churn rate calculation
SELECT 
  month,
  churned_customers,
  total_active_customers,
  (churned_customers * 100.0 / total_active_customers) AS calculated_churn_rate,
  monthly_churn_rate_pct
FROM monthly_revenue;

-- Calculate overall churn using reliable churn flag
SELECT 
  COUNT(*) AS total_customers,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_customers,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate_pct
FROM subscriptions;

-- View monthly churn trend
SELECT 
  month,
  total_active_customers,
  churned_customers,
  monthly_churn_rate_pct
FROM monthly_revenue
ORDER BY month;

-- Identify high churn months
SELECT *
FROM monthly_revenue
WHERE monthly_churn_rate_pct >= 10
ORDER BY month;

-- Segmentation Analysis

SELECT 
  acquisition_channel,
  COUNT(*) AS total_users,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_users,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM subscriptions
GROUP BY acquisition_channel
ORDER BY churn_rate DESC;

SELECT 
  plan,
  COUNT(*) AS total_users,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_users,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM subscriptions
GROUP BY plan
ORDER BY churn_rate DESC;

-- Billing Cycle

SELECT 
  billing_cycle,
  COUNT(*) AS total_users,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_users,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM subscriptions
GROUP BY billing_cycle;

-- Company Size

SELECT 
  company_size,
  COUNT(*) AS total_users,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_users,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM subscriptions
GROUP BY company_size
ORDER BY churn_rate DESC;

-- Behavioral Analysis 

SELECT 
  CASE 
    WHEN feature_usage_pct < 30 THEN 'Low Usage'
    WHEN feature_usage_pct BETWEEN 30 AND 70 THEN 'Medium Usage'
    ELSE 'High Usage'
  END AS usage_bucket,
  COUNT(*) AS total_users,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_users,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM subscriptions
GROUP BY usage_bucket
ORDER BY churn_rate DESC;

-- NPS

SELECT 
  CASE 
    WHEN nps_score < 6 THEN 'Detractors'
    WHEN nps_score BETWEEN 6 AND 8 THEN 'Neutral'
    ELSE 'Promoters'
  END AS nps_group,
  COUNT(*) AS total_users,
  SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) AS churned_users,
  (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS churn_rate
FROM subscriptions
GROUP BY nps_group
ORDER BY churn_rate DESC;

-- At Risk User

SELECT 
  COUNT(*) AS total_users,
  SUM(CASE WHEN feature_usage_pct < 30 THEN 1 ELSE 0 END) AS at_risk_users
FROM subscriptions;

-- Top 3 churn reasons
SELECT 
  churn_reason,
  COUNT(*) AS total
FROM subscriptions
WHERE LOWER(churned) = 'yes'
GROUP BY churn_reason
ORDER BY total DESC
LIMIT 3;

-- Churn reasons by plan
SELECT 
  plan,
  churn_reason,
  COUNT(*) AS total
FROM subscriptions
WHERE LOWER(churned) = 'yes'
GROUP BY plan, churn_reason
ORDER BY plan, total DESC;

-- MRR trend over time
SELECT month, total_mrr, total_active_customers
FROM monthly_revenue
ORDER BY month;

-- Net Revenue Retention (NRR)
SELECT 
  month,
  total_mrr,
  LAG(total_mrr) OVER (ORDER BY month) AS prev_mrr,
  (total_mrr * 1.0 / LAG(total_mrr) OVER (ORDER BY month)) * 100 AS nrr_pct
FROM monthly_revenue;

-- CLV By Plan

SELECT 
  plan,
  AVG(monthly_revenue) AS avg_mrr,
  (1.0 / 
    (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*))
  ) AS estimated_lifespan,
  AVG(monthly_revenue) * 
  (1.0 / 
    (SUM(CASE WHEN LOWER(churned) = 'yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*))
  ) AS clv
FROM subscriptions
GROUP BY plan;

-- CAC

SELECT AVG(customer_acquisition_cost) AS avg_cac
FROM monthly_revenue;