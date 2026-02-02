-- return_features.sql

DROP TABLE IF EXISTS return_features;

CREATE TABLE return_features AS
SELECT
    customer_id,
    COUNT(*) FILTER (WHERE quantity <= 0) AS return_count,
    COUNT(*) AS total_transactions,
    COUNT(*) FILTER (WHERE quantity <= 0)::FLOAT
        / NULLIF(COUNT(*), 0) AS return_rate,
    CASE
        WHEN COUNT(*) FILTER (WHERE quantity <= 0) > 0 THEN 1
        ELSE 0
    END AS has_returned
FROM raw_transactions
WHERE customer_id IS NOT NULL
GROUP BY customer_id;
