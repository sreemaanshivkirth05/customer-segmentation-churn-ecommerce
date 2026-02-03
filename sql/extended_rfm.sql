-- extended_rfm.sql
-- Extended RFM features using snapshot date (2011-06-01)

DROP TABLE IF EXISTS extended_rfm;

CREATE TABLE extended_rfm AS
WITH customer_dates AS (
    SELECT
        customer_id,
        MIN(invoice_date) AS first_purchase_date,
        MAX(invoice_date) AS last_purchase_date
    FROM clean_transactions
    WHERE invoice_date < DATE '2011-06-01'
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
    WHERE invoice_date < DATE '2011-06-01'
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
),
rfm_snapshot AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice) AS frequency,
        SUM(quantity * price) AS monetary
    FROM clean_transactions
    WHERE invoice_date < DATE '2011-06-01'
    GROUP BY customer_id
)
SELECT
    r.customer_id,

    DATE_PART(
        'day',
        DATE '2011-06-01' - d.last_purchase_date
    ) AS recency,

    r.frequency,
    r.monetary,

    DATE_PART(
        'day',
        DATE '2011-06-01' - d.first_purchase_date
    ) AS tenure_days,

    r.monetary / NULLIF(r.frequency, 0) AS avg_order_value,

    COUNT(DISTINCT c.stock_code) AS product_diversity,

    g.avg_days_between_purchases

FROM rfm_snapshot r
JOIN customer_dates d
    ON r.customer_id = d.customer_id
JOIN clean_transactions c
    ON r.customer_id = c.customer_id
   AND c.invoice_date < DATE '2011-06-01'
LEFT JOIN avg_gaps g
    ON r.customer_id = g.customer_id
GROUP BY
    r.customer_id,
    d.last_purchase_date,
    r.frequency,
    r.monetary,
    d.first_purchase_date,
    g.avg_days_between_purchases;
