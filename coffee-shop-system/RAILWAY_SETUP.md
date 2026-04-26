# Railway MySQL Setup for Coffee Shop

## 🚂 Railway Dashboard - Lấy Connection Info

### **Trong Railway Dashboard:**

1. Project → MySQL service
2. Click **Variables** tab
3. Sẽ thấy các biến:
   ```
   MYSQL_HOST        = (chứa .railway.internal hoặc domain)
   MYSQL_DATABASE    = railway
   MYSQL_PASSWORD    = (random password)
   MYSQL_PORT        = 3306
   MYSQL_USER        = root
   DATABASE_URL      = mysql://root:PASSWORD@HOST:3306/railway
   ```

4. **LƯU LẠI** những giá trị này (sẽ dùng sau)

---

## 📝 Connection String Formats

### Local Testing
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/coffee_t2k
spring.datasource.username=root
spring.datasource.password=
```

### Railway Production (Render)
```properties
spring.datasource.url=jdbc:mysql://MYSQL_HOST:3306/railway?allowPublicKeyRetrieval=true&useSSL=true
spring.datasource.username=root
spring.datasource.password=MYSQL_PASSWORD
```

---

## 🔄 Workflow

### **Hiện Tại (Local Development)**
```
Local Frontend
    ↓
Local Backend (localhost:8081)
    ↓
Local MySQL (localhost:3306) - hiện tại
```

### **Sau Deploy (Production)**
```
Netlify Frontend
    ↓
Render Backend
    ↓
Railway MySQL ← sẽ kết nối qua biến môi trường
```

---

## ⚙️ Các Bước Tiếp Theo

### 1. Test Local Trước (MySQL local)
```bash
cd backend
mvn clean install
mvn spring-boot:run

# Test API
curl http://localhost:8081/api/products
```

### 2. Sau khi confirm local OK
```bash
# Thêm MYSQL_HOST, MYSQL_PASSWORD vào Render
# Khi deploy lên Render → tự động kết nối Railway MySQL
```

### 3. Render sẽ chạy:
```
java -jar target/coffee-t2k.jar --spring.profiles.active=prod
```
(với biến môi trường MYSQL_HOST, MYSQL_PASSWORD)

---

## 🆘 Troubleshooting Railway

### ❌ "Cannot connect to Railway MySQL"
```bash
# Check connection locally trước
mysql -h MYSQL_HOST -u root -p railway

# Hoặc test từ DBeaver
```

### ❌ "java.sql.SQLException: Cannot create connection"
- Kiểm tra MYSQL_HOST, PASSWORD đúng không
- Kiểm tra Railway MySQL service đang running
- Kiểm tra firewall/network access

### ✅ Connection Thành Công Khi:
```
mysql> SELECT COUNT(*) FROM account;
+----------+
| COUNT(*) |
|    3     |
+----------+
```

---

## 📋 Checklist Công Việc 1

- [ ] Tạo Railway account
- [ ] Create MySQL service
- [ ] Lấy connection info (MYSQL_HOST, PASSWORD, DATABASE)
- [ ] Import SQL vào Railway:
  - [ ] Cách 1: DBeaver import
  - [ ] Hoặc Cách 2: MySQL CLI
- [ ] Verify dữ liệu (SELECT COUNT FROM account)
- [ ] Test local connection
- [ ] Backup MYSQL_HOST, MYSQL_PASSWORD

---

**Hoàn thành Công Việc #1 khi dữ liệu đã import thành công vào Railway MySQL!**
