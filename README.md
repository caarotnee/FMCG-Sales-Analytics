# 🛒 Olist E-Commerce Analytics & Late Delivery Prediction

## 📌 Giới Thiệu

Đây là dự án Data Analytics được thực hiện trên bộ dữ liệu **Olist Brazilian E-Commerce Dataset**.

Dự án mô phỏng quy trình làm việc thực tế của một Data Analyst từ khâu lưu trữ dữ liệu, xử lý dữ liệu, phân tích dữ liệu, xây dựng mô hình Machine Learning đến trực quan hóa dữ liệu bằng Power BI.

---

## 🎯 Mục Tiêu Dự Án

* Phân tích hoạt động kinh doanh của nền tảng thương mại điện tử Olist.
* Đánh giá hiệu suất bán hàng, khách hàng, sản phẩm và giao hàng.
* Xây dựng mô hình dự đoán đơn hàng giao trễ.
* Trực quan hóa dữ liệu thông qua Dashboard Power BI.
* Đưa ra các insight hỗ trợ ra quyết định kinh doanh.

---

## 🏗️ Quy Trình Thực Hiện

```text
Raw CSV Files
      │
      ▼
 PostgreSQL
      │
      ▼
 SQL Data Cleaning
      │
      ▼
 Clean Dataset
      │
 ┌────┴────┐
 ▼         ▼
Google    Power BI
Colab
 ▼
EDA + Machine Learning
```
<img width="1612" height="950" alt="image" src="https://github.com/user-attachments/assets/63dd9e6f-43d5-45c4-862d-65397afc4061" />
<img width="1608" height="942" alt="image" src="https://github.com/user-attachments/assets/347a2868-80fe-4210-ae66-582deac293f9" />
<img width="1604" height="946" alt="image" src="https://github.com/user-attachments/assets/ad97238c-9eeb-439f-9732-8d805608d7b1" />
<img width="1612" height="950" alt="image" src="https://github.com/user-attachments/assets/2670324f-31a2-4964-afa4-0e68ae025cf8" />

---

## 🗄️ Công Nghệ Sử Dụng

* PostgreSQL
* SQL
* Python
* Pandas
* NumPy
* Matplotlib
* Seaborn
* Scikit-Learn
* Google Colab
* Power BI

---

## 📂 Dữ Liệu

Nguồn dữ liệu:

**Olist Brazilian E-Commerce Dataset**

Các bảng dữ liệu chính:

* customers
* orders
* order_items
* order_payments
* order_reviews
* products
* sellers
* geolocation

Thông tin dữ liệu:

* 99,441 đơn hàng
* 96,096 khách hàng duy nhất
* Giai đoạn từ 09/2016 đến 10/2018

---

## ⚙️ Xử Lý Dữ Liệu Với PostgreSQL & SQL

### Import dữ liệu

Các file CSV được import vào PostgreSQL để xây dựng cơ sở dữ liệu phục vụ phân tích.

### Làm sạch dữ liệu

Các bước xử lý:

* Kiểm tra dữ liệu NULL
* Kiểm tra dữ liệu trùng lặp
* Chuẩn hóa dữ liệu
* Tạo các trường phân tích

Các feature được xây dựng:

* purchase_year
* purchase_month
* delivery_days
* total_items
* total_product_value
* total_freight_value
* total_payment_value
* avg_item_price
* review_score

Biến mục tiêu:

```text
is_late
```

* 1 = Giao hàng trễ
* 0 = Giao hàng đúng hạn

---

## 📊 Phân Tích Dữ Liệu (EDA)

Thực hiện trên Google Colab bằng Python.

Các nội dung phân tích:

### Doanh Thu

* Doanh thu theo tháng
* Doanh thu theo bang
* Doanh thu theo phương thức thanh toán

### Sản Phẩm

* Top danh mục theo doanh thu
* Top danh mục theo số lượng bán
* Chi phí vận chuyển theo danh mục

### Khách Hàng

* Phân bố khách hàng theo bang
* Doanh thu trên mỗi khách hàng
* Phân bố điểm đánh giá

### Giao Hàng

* Thời gian giao hàng
* Tỷ lệ giao hàng trễ
* Mối quan hệ giữa giao hàng và đánh giá khách hàng

---

## 🤖 Machine Learning

### Bài toán

Dự đoán khả năng giao hàng trễ của đơn hàng.

Biến mục tiêu:

```text
is_late
```

Thuật toán sử dụng:

```text
Random Forest Classifier
```

### Kết quả mô hình

| Metric    | Score  |
| --------- | ------ |
| Accuracy  | 96.29% |
| Precision | 84.91% |
| Recall    | 64.35% |
| F1 Score  | 73.21% |

---

## 🔍 Feature Importance

Top yếu tố ảnh hưởng đến giao hàng trễ:

| Feature             | Importance |
| ------------------- | ---------- |
| delivery_days       | 46.57%     |
| review_score        | 9.59%      |
| total_freight_value | 7.92%      |
| total_payment_value | 6.93%      |
| avg_item_price      | 6.41%      |

Kết quả cho thấy:

* Thời gian giao hàng là yếu tố ảnh hưởng lớn nhất.
* Đánh giá khách hàng liên quan chặt chẽ đến hiệu suất giao hàng.
* Chi phí vận chuyển cao làm tăng nguy cơ giao hàng trễ.

---

## 📈 Power BI Dashboard

Power BI được kết nối trực tiếp với PostgreSQL để xây dựng Dashboard tương tác.

### Dashboard 1 – Executive Overview

* Total Revenue
* Total Orders
* Unique Customers
* Average Review
* Average Order Value
* Revenue Trend
* Revenue by State
* Revenue by Payment Type

### Dashboard 2 – Product Analysis

* Product Performance
* Category Revenue
* Quantity Sold
* Seller Distribution
* Freight Cost Analysis

### Dashboard 3 – Customer Analysis

* Customer Distribution
* Revenue by State
* Review Score Analysis
* Revenue Per Customer

### Dashboard 4 – Delivery & Review Performance

* Average Delivery Days
* Late Orders
* Late Rate
* Delivery Trend
* Review Performance

---

## 💡 Business Insights

### Revenue

* Tổng doanh thu đạt hơn 16 triệu USD.
* Thanh toán bằng Credit Card chiếm gần 80% doanh thu.

### Customer

* Bang São Paulo (SP) có số lượng khách hàng và doanh thu cao nhất.
* Điểm đánh giá trung bình đạt 4.1/5 sao.

### Product

* Health & Beauty là danh mục có doanh thu cao nhất.
* Watches & Gifts và Bed Bath Table là các nhóm sản phẩm bán chạy.

### Delivery

* Tỷ lệ giao hàng trễ khoảng 7.9%.
* Các bang có thời gian giao hàng dài thường có tỷ lệ giao hàng trễ cao hơn.

### Machine Learning

* Mô hình Random Forest đạt Accuracy 96.29%.
* Delivery Days, Review Score và Freight Value là các yếu tố ảnh hưởng mạnh nhất đến khả năng giao hàng trễ.

---

## 👨‍💻 Tác Giả

**Khánh Linh**

