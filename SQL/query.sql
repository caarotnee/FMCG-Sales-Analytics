-- Data Quality Check
-- check số dòng 
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM olist.customers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM olist.geolocation
UNION ALL
SELECT 'order_items', COUNT(*) FROM olist.order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM olist.order_payments
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM olist.order_reviews
UNION ALL
SELECT 'orders', COUNT(*) FROM olist.orders
UNION ALL
SELECT 'products', COUNT(*) FROM olist.products
UNION ALL
SELECT 'sellers', COUNT(*) FROM olist.sellers
UNION ALL
SELECT 'category_translation', COUNT(*) FROM olist.category_translation;

--Check customers
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_unique_id,
    SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS missing_zip,
    SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) AS missing_state
FROM olist.customers;

-- Duplicate:
SELECT customer_id, COUNT(*)
FROM olist.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check orders
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN order_status IS NULL THEN 1 ELSE 0 END) AS missing_status,
    SUM(CASE WHEN order_purchase_timestamp IS NULL THEN 1 ELSE 0 END) AS missing_purchase_date,
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS missing_approved_date,
    SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) AS missing_carrier_date,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS missing_customer_date,
    SUM(CASE WHEN order_estimated_delivery_date IS NULL THEN 1 ELSE 0 END) AS missing_estimated_date
FROM olist.orders;

-- Check trạng thái đơn hàng:
SELECT order_status,
       COUNT(*) AS total_orders
FROM olist.orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Check ngày bất thường:
SELECT *
FROM olist.orders
WHERE order_delivered_customer_date < order_purchase_timestamp
   OR order_estimated_delivery_date < order_purchase_timestamp;

--Check order_items
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS missing_order_item_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) AS missing_seller_id,
    SUM(CASE WHEN shipping_limit_date IS NULL THEN 1 ELSE 0 END) AS missing_shipping_limit_date,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN freight_value IS NULL THEN 1 ELSE 0 END) AS missing_freight_value
FROM olist.order_items;


--Check giá trị 0 hoặc âm:
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN price = 0 THEN 1 ELSE 0 END) AS price_zero,
    SUM(CASE WHEN price < 0 THEN 1 ELSE 0 END) AS price_negative,
    SUM(CASE WHEN freight_value = 0 THEN 1 ELSE 0 END) AS freight_zero,
    SUM(CASE WHEN freight_value < 0 THEN 1 ELSE 0 END) AS freight_negative
FROM olist.order_items;

--Check order_payments
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN payment_sequential IS NULL THEN 1 ELSE 0 END) AS missing_payment_sequential,
    SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) AS missing_payment_type,
    SUM(CASE WHEN payment_installments IS NULL THEN 1 ELSE 0 END) AS missing_installments,
    SUM(CASE WHEN payment_value IS NULL THEN 1 ELSE 0 END) AS missing_payment_value
FROM olist.order_payments;

-- Check payment type:
SELECT payment_type, COUNT(*) AS total
FROM olist.order_payments
GROUP BY payment_type
ORDER BY total DESC;

--Check payment bất thường:
SELECT *
FROM olist.order_payments
WHERE payment_value <= 0
   OR payment_installments < 0;

--Check order_reviews
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN review_id IS NULL THEN 1 ELSE 0 END) AS missing_review_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END) AS missing_review_score,
    SUM(CASE WHEN review_comment_title IS NULL THEN 1 ELSE 0 END) AS missing_title,
    SUM(CASE WHEN review_comment_message IS NULL THEN 1 ELSE 0 END) AS missing_message,
    SUM(CASE WHEN review_creation_date IS NULL THEN 1 ELSE 0 END) AS missing_creation_date,
    SUM(CASE WHEN review_answer_timestamp IS NULL THEN 1 ELSE 0 END) AS missing_answer_date
FROM olist.order_reviews;

--Check điểm review:
SELECT review_score, COUNT(*) AS total
FROM olist.order_reviews
GROUP BY review_score
ORDER BY review_score;

--Check điểm lỗi:
SELECT *
FROM olist.order_reviews
WHERE review_score < 1
   OR review_score > 5;

--Check products
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN product_name_lenght IS NULL THEN 1 ELSE 0 END) AS missing_name_length,
    SUM(CASE WHEN product_description_lenght IS NULL THEN 1 ELSE 0 END) AS missing_description_length,
    SUM(CASE WHEN product_photos_qty IS NULL THEN 1 ELSE 0 END) AS missing_photos_qty,
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS missing_weight,
    SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) AS missing_length,
    SUM(CASE WHEN product_height_cm IS NULL THEN 1 ELSE 0 END) AS missing_height,
    SUM(CASE WHEN product_width_cm IS NULL THEN 1 ELSE 0 END) AS missing_width
FROM olist.products;
   
-- Check sản phẩm trùng:
SELECT product_id, COUNT(*)
FROM olist.products
GROUP BY product_id
HAVING COUNT(*) > 1;

--Check kích thước bất thường:
SELECT *
FROM olist.products
WHERE product_weight_g <= 0
   OR product_length_cm <= 0
   OR product_height_cm <= 0
   OR product_width_cm <= 0;


--Check sellers
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN seller_id IS NULL THEN 1 ELSE 0 END) AS missing_seller_id,
    SUM(CASE WHEN seller_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS missing_zip,
    SUM(CASE WHEN seller_city IS NULL THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN seller_state IS NULL THEN 1 ELSE 0 END) AS missing_state
FROM olist.sellers;

--Duplicate:
SELECT seller_id, COUNT(*)
FROM olist.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

--Check geolocation
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN geolocation_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS missing_zip,
    SUM(CASE WHEN geolocation_lat IS NULL THEN 1 ELSE 0 END) AS missing_lat,
    SUM(CASE WHEN geolocation_lng IS NULL THEN 1 ELSE 0 END) AS missing_lng,
    SUM(CASE WHEN geolocation_city IS NULL THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN geolocation_state IS NULL THEN 1 ELSE 0 END) AS missing_state
FROM olist.geolocation;

--Check zip bị trùng:
SELECT
    geolocation_zip_code_prefix,
    COUNT(*) AS total_rows
FROM olist.geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1
ORDER BY total_rows DESC;

--Check category_translation
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS missing_category_pt,
    SUM(CASE WHEN product_category_name_english IS NULL THEN 1 ELSE 0 END) AS missing_category_en
FROM olist.category_translation;

--Duplicate:
SELECT product_category_name, COUNT(*)
FROM olist.category_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;

--Kiểm tra logic ngày tháng
SELECT *
FROM olist.orders
WHERE order_delivered_customer_date < order_purchase_timestamp;


SELECT *
FROM olist.orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;


SELECT
    order_status,
    COUNT(*) AS total_orders
FROM olist.orders
WHERE order_delivered_customer_date IS NULL
GROUP BY order_status
ORDER BY total_orders DESC;


--Kiểm tra số lượng:
SELECT
    payment_type,
    COUNT(*) AS total_rows
FROM olist.order_payments
WHERE payment_value = 0
GROUP BY payment_type
ORDER BY total_rows DESC;


SELECT COUNT(*)
FROM olist.products
WHERE product_weight_g = 0;

-- tạo bảng product sạch
CREATE TABLE olist.products_clean AS
SELECT *
FROM olist.products;

-- category
UPDATE olist.products_clean
SET product_category_name = 'unknown'
WHERE product_category_name IS NULL;

-- name_lenght
UPDATE olist.products_clean
SET product_name_lenght =
(
    SELECT ROUND(AVG(product_name_lenght))
    FROM olist.products_clean
)
WHERE product_name_lenght IS NULL;

--description_length
UPDATE olist.products_clean
SET product_description_lenght =
(
    SELECT ROUND(AVG(product_description_lenght))
    FROM olist.products_clean
)
WHERE product_description_lenght IS NULL;


-- photos_qty
UPDATE olist.products_clean
SET product_photos_qty =
(
    SELECT ROUND(AVG(product_photos_qty))
    FROM olist.products_clean
)
WHERE product_photos_qty IS NULL;


-- weight
UPDATE olist.products_clean
SET product_weight_g =
(
    SELECT ROUND(AVG(product_weight_g))
    FROM olist.products_clean
)
WHERE product_weight_g IS NULL
   OR product_weight_g = 0;


--length
UPDATE olist.products_clean
SET product_length_cm =
(
    SELECT ROUND(AVG(product_length_cm))
    FROM olist.products_clean
)
WHERE product_length_cm IS NULL;

--height
UPDATE olist.products_clean
SET product_height_cm =
(
    SELECT ROUND(AVG(product_height_cm))
    FROM olist.products_clean
)
WHERE product_height_cm IS NULL;


-- width
UPDATE olist.products_clean
SET product_width_cm =
(
    SELECT ROUND(AVG(product_width_cm))
    FROM olist.products_clean
)
WHERE product_width_cm IS NULL;

-- gộp zipcode
CREATE TABLE olist.geolocation_clean AS

SELECT
    geolocation_zip_code_prefix,
    AVG(geolocation_lat) AS lat,
    AVG(geolocation_lng) AS lng,
    MAX(geolocation_city) AS city,
    MAX(geolocation_state) AS state
FROM olist.geolocation
GROUP BY geolocation_zip_code_prefix;

--Thêm cột vào bảng orders
ALTER TABLE olist.orders
ADD COLUMN missing_delivery_date_flag INT;

UPDATE olist.orders
SET missing_delivery_date_flag =
CASE
    WHEN order_status = 'delivered'
         AND order_delivered_customer_date IS NULL
    THEN 1
    ELSE 0
END;


-- check
SELECT
    missing_delivery_date_flag,
    COUNT(*)
FROM olist.orders
GROUP BY missing_delivery_date_flag;


-- export data cho colab

-- Tổng hợp order_items. Một order có thể có nhiều sản phẩm
DROP TABLE IF EXISTS olist.order_items_summary;

CREATE TABLE olist.order_items_summary AS

SELECT
    order_id,
    COUNT(*) AS total_items,
    SUM(price) AS total_product_value,
    SUM(freight_value) AS total_freight_value,
    AVG(price) AS avg_item_price
FROM olist.order_items
GROUP BY order_id;


--Tổng hợp payments
--Một order có thể có nhiều payment
DROP TABLE IF EXISTS olist.payment_summary;

CREATE TABLE olist.payment_summary AS

SELECT
    order_id,
    SUM(payment_value) AS total_payment_value,
    MAX(payment_installments) AS max_installments
FROM olist.order_payments
GROUP BY order_id;


--Tổng hợp reviews
DROP TABLE IF EXISTS olist.review_summary;

CREATE TABLE olist.review_summary AS

SELECT
    order_id,
    AVG(review_score) AS review_score
FROM olist.order_reviews
GROUP BY order_id;


-- Tạo ML Dataset
DROP TABLE IF EXISTS olist.ml_dataset;

CREATE TABLE olist.ml_dataset AS

SELECT

    o.order_id,
    o.order_status,

    DATE(o.order_purchase_timestamp) AS purchase_date,

    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS purchase_year,

    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS purchase_month,

    c.customer_state,

    oi.total_items,
    oi.total_product_value,
    oi.total_freight_value,
    oi.avg_item_price,

    ps.total_payment_value,
    ps.max_installments,

    rs.review_score,

    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
         AND o.order_estimated_delivery_date IS NOT NULL
         AND o.order_delivered_customer_date >
             o.order_estimated_delivery_date
        THEN 1
        ELSE 0
    END AS is_late,

    CASE
        WHEN o.order_delivered_customer_date IS NOT NULL
        THEN DATE_PART(
                'day',
                o.order_delivered_customer_date
                -
                o.order_purchase_timestamp
             )
    END AS delivery_days

FROM olist.orders o

LEFT JOIN olist.customers c
ON o.customer_id = c.customer_id

LEFT JOIN olist.order_items_summary oi
ON o.order_id = oi.order_id

LEFT JOIN olist.payment_summary ps
ON o.order_id = ps.order_id

LEFT JOIN olist.review_summary rs
ON o.order_id = rs.order_id;

--check
SELECT COUNT(*)
FROM olist.ml_dataset;

SELECT *
FROM olist.ml_dataset
LIMIT 20;

SELECT *
FROM olist.ml_dataset;