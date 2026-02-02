DROP TABLE IF EXISTS clean_transactions;

CREATE TABLE clean_transactions AS
SELECT
    invoice,
    stock_code,
    description,
    quantity,
    invoice_date,
    price,
    customer_id,
    country
FROM raw_transactions
WHERE customer_id IS NOT NULL
  AND quantity > 0
  AND price > 0
  AND invoice NOT LIKE 'C%';


SELECT COUNT(*) FROM clean_transactions;

SELECT * FROM clean_transactions LIMIT 5;

