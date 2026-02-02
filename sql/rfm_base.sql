-- rfm_base.sql
-- Create customer-level RFM metrics

DROP TABLE IF EXISTS rfm_base;

CREATE TABLE rfm_base AS
SELECT
    customer_id,
    MAX(invoice_date) AS last_purchase_date,
    COUNT(DISTINCT invoice) AS frequency,
    SUM(quantity * price) AS monetary
FROM clean_transactions
GROUP BY customer_id;

SELECT COUNT(*) FROM rfm_base;

SELECT * FROM rfm_base LIMIT 100;
