SELECT v.vendor_id, v.name, SUM(ft.amount) AS total_sales
FROM Financial_Transactions ft
JOIN Vendors v ON ft.vendor_id = v.vendor_id
WHERE ft.status = 'success'
GROUP BY v.vendor_id, v.name
ORDER BY total_sales DESC
LIMIT 10;

SELECT DATE(ft.timestamp) AS sale_date, SUM(ft.amount) AS daily_sales
FROM Financial_Transactions ft
WHERE ft.status = 'success'
GROUP BY sale_date
ORDER BY sale_date;

SELECT ft.transaction_id, ft.amount, ft.timestamp
FROM Financial_Transactions ft
WHERE ft.amount > (SELECT AVG(amount) * 3 FROM Financial_Transactions);

CREATE INDEX idx_transactions_user_id ON Financial_Transactions(user_id);
CREATE INDEX idx_transactions_vendor_id ON Financial_Transactions(vendor_id);
CREATE INDEX idx_transactions_timestamp ON Financial_Transactions(timestamp);

CREATE TABLE Financial_Transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vendor_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status ENUM('success', 'failed', 'pending') NOT NULL,
    type ENUM('debit', 'credit') NOT NULL,
    timestamp DATETIME NOT NULL
) PARTITION BY RANGE (YEAR(timestamp)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025)
);


CREATE TABLE Financial_Transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    vendor_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) NOT NULL,
    status ENUM('success', 'failed', 'pending') NOT NULL,
    type ENUM('debit', 'credit') NOT NULL,
    timestamp DATETIME NOT NULL
) PARTITION BY RANGE (YEAR(timestamp)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026)
);


EXPLAIN ANALYZE
SELECT * FROM Financial_Transactions WHERE user_id = 12345;
