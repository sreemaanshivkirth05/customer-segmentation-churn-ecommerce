-- extended_rfm.sql

DROP TABLE IF EXISTS extended_rfm;

CREATE TABLE extended_rfm AS
WITH customer_dates AS (
    SELECT
        customer_id,
        MIN(invoice_date) AS first_purchase_date,
        MAX(invoice_date) AS last_purchase_date
    FROM clean_transactions
    GROUP BY customer_id
),
purchase_gaps AS (
    SELECT
        customer_id,
        invoice_date,
        LAG(invoice_date) OVER (
            PARTITION BY customer_id
            ORDER BY invoice_date
        ) AS previous_purchase_date
    FROM clean_transactions
),
avg_gaps AS (
    SELECT
        customer_id,
        AVG(
            DATE_PART('day', invoice_date - previous_purchase_date)
        ) AS avg_days_between_purchases
    FROM purchase_gaps
    WHERE previous_purchase_date IS NOT NULL
    GROUP BY customer_id
)
SELECT
    r.customer_id,

    -- Classic RFM
    DATE_PART(
        'day',
        DATE '2011-12-09' - r.last_purchase_date
    ) AS recency,
    r.frequency,
    r.monetary,

    -- Extended Features
    DATE_PART(
        'day',
        DATE '2011-12-09' - d.first_purchase_date
    ) AS tenure_days,

    r.monetary / NULLIF(r.frequency, 0) AS avg_order_value,

    COUNT(DISTINCT c.stock_code) AS product_diversity,

    g.avg_days_between_purchases

FROM rfm_base r
JOIN customer_dates d
    ON r.customer_id = d.customer_id
JOIN clean_transactions c
    ON r.customer_id = c.customer_id
LEFT JOIN avg_gaps g
    ON r.customer_id = g.customer_id
GROUP BY
    r.customer_id,
    r.last_purchase_date,
    r.frequency,
    r.monetary,
    d.first_purchase_date,
    g.avg_days_between_purchases;

SELECT COUNT(*) FROM extended_rfm;
SELECT * FROM extended_rfm LIMIT 5;
