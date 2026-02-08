-- churn_label.sql
-- Relative churn based on recency distribution

DROP TABLE IF EXISTS modeling_dataset;

CREATE TABLE modeling_dataset AS
WITH recency_threshold AS (
    SELECT
        PERCENTILE_CONT(0.70) 
        WITHIN GROUP (ORDER BY recency) AS churn_cutoff
    FROM final_customer_features
)
SELECT
    f.*,
    CASE
        WHEN f.recency >= r.churn_cutoff THEN 1
        ELSE 0
    END AS churn_flag
FROM final_customer_features f
CROSS JOIN recency_threshold r;


SELECT churn_flag, COUNT(*)
FROM modeling_dataset
GROUP BY churn_flag;

SELECT *
FROM modeling_dataset;
