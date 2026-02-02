-- schema.sql
-- Create raw transactions table for Online Retail dataset

DROP TABLE IF EXISTS raw_transactions;

CREATE TABLE raw_transactions (
    invoice        VARCHAR(20),
    stock_code     VARCHAR(50),
    description    TEXT,
    quantity       INTEGER,
    invoice_date   TIMESTAMP,
    price          NUMERIC(10, 2),
    customer_id    NUMERIC,
    country        VARCHAR(100)
);

