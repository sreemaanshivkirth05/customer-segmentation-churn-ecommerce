DROP TABLE IF EXISTS final_customer_features;

CREATE TABLE final_customer_features AS
SELECT
    e.*,
    COALESCE(r.return_count, 0) AS return_count,
    COALESCE(r.return_rate, 0) AS return_rate,
    COALESCE(r.has_returned, 0) AS has_returned
FROM extended_rfm e
LEFT JOIN return_features r
    ON e.customer_id = r.customer_id;

SELECT * FROM final_customer_features LIMIT 20;
