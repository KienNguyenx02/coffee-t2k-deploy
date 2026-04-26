# 🚀 Kế Hoạch Deploy T2K Coffee System (Local → Cloud)

## 📋 Tóm Tắt
- **Backend**: Spring Boot 3.1.0 (Java 17) → Render
- **Frontend**: Vanilla JS + HTML/CSS → Netlify
- **Database**: MySQL → PlanetScale
- **Mục tiêu**: Netlify → Render API → PlanetScale Database

---

## ✅ CÔNG VIỆC 1: Tạo Database PlanetScale & Import SQL

### 1.1 Tạo tài khoản PlanetScale
1. Vào [PlanetScale.com](https://planetscale.com)
2. Đăng ký free account (hoặc dùng GitHub login)
3. Tạo organization mới

### 1.2 Tạo Database
1. Click **"Create database"**
2. Đặt tên: `coffee-t2k` (hoặc tùy chọn)
3. Chọn Region gần nhất (VN → Singapore)
4. Tạo Development database (không cần Production)

### 1.3 Lấy Connection String
1. Vào **Database → Connect**
2. Chọn **"Connect with: MySQL client"**
3. Sẽ hiện connection string: `mysql://username:password@host/database`
4. **Lưu lại**:
   - HOST: `xxx-mysql.planetscale.com`
   - USER: `xxxxxxxxxxxx`
   - PASSWORD: `pscale_pw_xxxxxxxxxxxx`
   - DB: `coffee-t2k`
   - PORT: `3306`

### 1.4 Import SQL File
#### Cách 1: Dùng MySQL CLI
```bash
# Mở Terminal/Command Prompt
mysql -h HOST -u USER -p -D DB < _dbcoffee_t2k.sql

# Nhập password khi được yêu cầu
```

#### Cách 2: Dùng GUI (DBeaver/MySQL Workbench)
1. Kết nối tới PlanetScale bằng connection string trên
2. Import file `_dbcoffee_t2k.sql`

#### Cách 3: Dùng Terminal MySQL
```bash
mysql -h localhost -u root -p
> USE coffee_t2k;
> SOURCE C:\path\to\_dbcoffee_t2k.sql;
```

**✓ Hoàn thành khi**: Database có data, kiểm tra bằng:
```bash
mysql -h HOST -u USER -p -D coffee-t2k -e "SELECT COUNT(*) FROM account;"
```

---

## ✅ CÔNG VIỆC 2: Cấu Hình Connection String Backend → PlanetScale

### 2.1 Cập Nhật `application.properties`

**File**: [backend/application.properties](backend/application.properties)

```properties
# PlanetScale Connection
spring.datasource.url=jdbc:mysql://HOST:3306/coffee-t2k?allowPublicKeyRetrieval=true&useSSL=true
spring.datasource.username=USER
spring.datasource.password=PASSWORD
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Hibernate config (QUAN TRỌNG: Dùng validate để không thay đổi schema)
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

# Upload
spring.servlet.multipart.enabled=true
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
app.upload.dir=./uploads/images

# Server
server.port=8081

# CORS (sẽ update sau)
spring.mvc.cors.allowed-origins=*
spring.mvc.cors.allowed-methods=GET,POST,PUT,DELETE,OPTIONS,PATCH
spring.mvc.cors.allowed-headers=Authorization,Content-Type,X-Requested-With

# Logging
logging.level.org.springframework.web=INFO
logging.level.org.hibernate=WARN
```

### 2.2 Test Connection Locally
```bash
# Di chuyển vào folder backend
cd backend

# Build & Run
mvn clean install
mvn spring-boot:run

# Kiểm tra logs, nếu không có lỗi → OK!
```

**✓ Hoàn thành khi**: Ứng dụng khởi động thành công, không có lỗi database

---

## ✅ CÔNG VIỆC 3: Test API Local Sau Khi Đổi DB

### 3.1 Kiểm Tra Các API Endpoints
```bash
# Test Account/Login
curl -X GET http://localhost:8081/api/staffs

# Test Products
curl -X GET http://localhost:8081/api/products

# Test Categories
curl -X GET http://localhost:8081/api/categories

# Test Orders
curl -X GET http://localhost:8081/api/orders
```

### 3.2 Kiểm Tra Dữ Liệu
- Mở Postman/Thunder Client
- GET: `http://localhost:8081/api/products` → Phải có sản phẩm
- GET: `http://localhost:8081/api/categories` → Phải có danh mục
- GET: `http://localhost:8081/api/orders` → Phải có đơn hàng

**✓ Hoàn thành khi**: Tất cả API trả về dữ liệu đúng từ PlanetScale

---

## ✅ CÔNG VIỆC 4: Push Backend Lên GitHub

### 4.1 Tạo GitHub Repository
1. Vào [GitHub.com](https://github.com)
2. Click **"New repository"**
3. Tên: `coffee-shop-backend` (hoặc tùy chọn)
4. Chọn **Public** hoặc **Private**
5. Tạo repository (không chọn .gitignore, README)

### 4.2 Push Code Lên GitHub
```bash
# Di chuyển vào folder backend
cd backend

# Tạo .gitignore để không push sensitive files
# Copy content từ: https://www.toptal.com/developers/gitignore/api/java,maven

# Khởi tạo git repo
git init
git add .
git commit -m "Initial commit: Coffee Shop Backend"

# Remote tới GitHub (replace YOUR_USERNAME/YOUR_REPO)
git remote add origin https://github.com/YOUR_USERNAME/coffee-shop-backend.git
git branch -M main
git push -u origin main
```

### 4.3 Thêm `application-prod.properties` Cho Render
**File**: `backend/src/main/resources/application-prod.properties`

```properties
# PlanetScale Connection (lấy từ Render Environment Variables)
spring.datasource.url=jdbc:mysql://${DB_HOST}:3306/${DB_NAME}?allowPublicKeyRetrieval=true&useSSL=true
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}

spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

spring.servlet.multipart.enabled=true
spring.servlet.multipart.max-file-size=10MB

server.port=8080
logging.level.org.springframework.web=INFO
```

**✓ Hoàn thành khi**: Code đã push lên GitHub, có thể xem trên GitHub repository

---

## ✅ CÔNG VIỆC 5: Deploy Backend Lên Render

### 5.1 Tạo Tài Khoản Render
1. Vào [Render.com](https://render.com)
2. Đăng ký bằng GitHub hoặc Email

### 5.2 Tạo New Web Service
1. Click **"Create +"** → **"Web Service"**
2. Chọn **"Deploy an existing Git repository"**
3. Kết nối GitHub account, chọn `coffee-shop-backend` repo
4. Cấu hình:
   - **Name**: `coffee-shop-api` (hoặc tùy chọn)
   - **Runtime**: Java
   - **Build Command**: `mvn clean install`
   - **Start Command**: `java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod`
   - **Plan**: Free (hoặc Starter)

### 5.3 Thêm Environment Variables
Trong Render dashboard, vào **Environment**:
```
DB_HOST=xxxxx-mysql.planetscale.com
DB_USER=xxxxxxxxxxxxxx
DB_PASSWORD=pscale_pw_xxxxxxxxxxxxxx
DB_NAME=coffee-t2k
```

### 5.4 Deploy
1. Click **"Deploy"**
2. Đợi 3-5 phút (xem logs)
3. Nếu xanh ✓ → Deploy thành công!
4. Lấy URL public: `https://coffee-shop-api.onrender.com` (tên có thể khác)

**✓ Hoàn thành khi**: 
- Status = "Live" (xanh)
- Có thể truy cập `https://your-app.onrender.com/api/products`

---

## ✅ CÔNG VIỆC 6: Cấu Hình Frontend API_URL → Render Backend

### 6.1 Cập Nhật API Base URL

**File**: [frontend/assets/js/api.js](frontend/assets/js/api.js)

Đổi từ:
```javascript
const API = {
    BASE_URL: 'http://localhost:8081/api',
    ...
};
```

Thành:
```javascript
const API = {
    BASE_URL: 'https://coffee-shop-api.onrender.com/api', // Thay bằng URL Render của bạn
    ...
};
```

### 6.2 Hoặc Dùng Environment Variable (Nâng Cao)
Tạo file: `frontend/.env.production`
```
VITE_API_URL=https://coffee-shop-api.onrender.com/api
```

Trong `api.js`:
```javascript
const API = {
    BASE_URL: import.meta.env.VITE_API_URL || 'http://localhost:8081/api',
    ...
};
```

### 6.3 Test Local
```bash
# Nếu dùng Vite
npm run dev

# Test gọi API từ frontend → Render backend
# Kiểm tra Network tab trong DevTools
```

**✓ Hoàn thành khi**: Frontend gọi được API từ Render backend (chưa cần CORS vì chưa đến Netlify)

---

## ✅ CÔNG VIỆC 7: Push Frontend Lên GitHub

### 7.1 Tạo GitHub Repository Cho Frontend
1. Click **"New repository"**
2. Tên: `coffee-shop-frontend`
3. Tạo repository

### 7.2 Push Code
```bash
# Di chuyển vào folder frontend
cd frontend

# Tạo .gitignore
echo "node_modules/" > .gitignore
echo ".env.local" >> .gitignore
echo "dist/" >> .gitignore

# Initialize git
git init
git add .
git commit -m "Initial commit: Coffee Shop Frontend"

git remote add origin https://github.com/YOUR_USERNAME/coffee-shop-frontend.git
git branch -M main
git push -u origin main
```

**✓ Hoàn thành khi**: Code đã push lên GitHub

---

## ✅ CÔNG VIỆC 8: Deploy Frontend Lên Netlify

### 8.1 Tạo Tài Khoản Netlify
1. Vào [Netlify.com](https://netlify.com)
2. Đăng ký bằng GitHub

### 8.2 Deploy From GitHub
1. Click **"Add new site"** → **"Import an existing project"**
2. Chọn **GitHub** provider
3. Chọn `coffee-shop-frontend` repository
4. Cấu hình:
   - **Build command**: `npm run build` (nếu Vite) hoặc bỏ trống nếu vanilla JS
   - **Publish directory**: `dist` (nếu Vite) hoặc `.` (nếu vanilla JS)
   - **Base directory**: bỏ trống

### 8.3 Cấu Hình Environment Variables (nếu cần)
Trong Netlify → **Site settings → Environment variables**:
```
VITE_API_URL=https://coffee-shop-api.onrender.com/api
```

### 8.4 Deploy
- Click **"Deploy"**
- Đợi ~1 phút
- Lấy URL: `https://xxxx.netlify.app`

**✓ Hoàn thành khi**: 
- Status = "Published"
- Có thể truy cập website qua `https://xxxx.netlify.app`

---

## ✅ CÔNG VIỆC 9: Bật CORS Backend (@CrossOrigin)

### 9.1 Cập Nhật CorsConfig

**File**: [backend/src/main/java/com/t2kcoffee/config/CorsConfig.java](backend/src/main/java/com/t2kcoffee/config/CorsConfig.java)

```java
package com.t2kcoffee.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins(
                    "http://localhost:3000",
                    "http://localhost:8081",
                    "https://xxxx.netlify.app"  // Thay bằng URL Netlify của bạn
                )
                .allowedMethods("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}
```

### 9.2 Hoặc Dùng @CrossOrigin Trên Controller
```java
@RestController
@RequestMapping("/api/products")
@CrossOrigin(origins = {"http://localhost:3000", "https://xxxx.netlify.app"}, allowCredentials = "true")
public class ProductController {
    // ...
}
```

### 9.3 Cập Nhật `application.properties`
```properties
# CORS Config
spring.mvc.cors.allowed-origins=http://localhost:3000,http://localhost:8081,https://xxxx.netlify.app
spring.mvc.cors.allowed-methods=GET,POST,PUT,DELETE,PATCH,OPTIONS
spring.mvc.cors.allowed-headers=*
spring.mvc.cors.allow-credentials=true
spring.mvc.cors.max-age=3600
```

### 9.4 Test CORS
```bash
# Từ browser (F12 → Console)
fetch('https://coffee-shop-api.onrender.com/api/products', {
    method: 'GET',
    headers: {'Content-Type': 'application/json'}
})
.then(r => r.json())
.then(d => console.log(d))
```

**✓ Hoàn thành khi**: CORS headers có trong response (Access-Control-Allow-Origin)

---

## ✅ CÔNG VIỆC 10: Test End-to-End (Netlify → Render → PlanetScale)

### 10.1 Test Flow
1. Mở `https://xxxx.netlify.app` (Frontend)
2. Mở **Developer Tools** (F12) → **Network** tab
3. Thực hiện action:
   - Xem sản phẩm
   - Xem danh mục
   - Xem đơn hàng
   - Login

### 10.2 Kiểm Tra
- **Network tab**: Requests đến `https://coffee-shop-api.onrender.com/api/...` ✓
- **Response**: Dữ liệu hiển thị đúng ✓
- **Database**: Dữ liệu từ PlanetScale ✓

### 10.3 Troubleshooting

#### ❌ CORS Error
```
Access to XMLHttpRequest blocked by CORS policy
```
**Giải pháp**: 
- Kiểm tra URL Netlify trong CorsConfig
- Kiểm tra `@CrossOrigin` annotations trên controllers
- Clear browser cache

#### ❌ 404 Not Found
```
GET https://coffee-shop-api.onrender.com/api/products 404
```
**Giải pháp**:
- Kiểm tra endpoint có tồn tại trên backend
- Kiểm tra Render deployment status (xem logs)

#### ❌ Connection Timeout
```
Request timeout after 30s
```
**Giải pháp**:
- Kiểm tra Render app đang running
- Kiểm tra PlanetScale connection
- Restart Render deployment

### 10.4 Performance Monitoring
```javascript
// Frontend - Thêm vào console
performance.measure('API Call', 'navigationStart');
fetch('https://coffee-shop-api.onrender.com/api/products')
    .then(r => r.json())
    .then(d => {
        performance.mark('API End');
        console.log('Time:', performance.getEntriesByName('API Call')[0].duration + 'ms');
    })
```

**✓ Hoàn thành khi**: 
- Website hoạt động trên Netlify
- Tất cả dữ liệu từ PlanetScale hiển thị đúng
- Không có lỗi CORS, 404, hoặc timeout

---

## 📊 Tóm Tắt URLs

| Service | URL | Status |
|---------|-----|--------|
| Database | PlanetScale | ✓ |
| Backend | `https://coffee-shop-api.onrender.com` | ✓ |
| Frontend | `https://xxxx.netlify.app` | ✓ |

---

## 🆘 Liên Hệ & Hỗ Trợ

- **PlanetScale Docs**: https://planetscale.com/docs
- **Render Docs**: https://render.com/docs
- **Netlify Docs**: https://docs.netlify.com
- **Spring Boot CORS**: https://spring.io/guides/gs/rest-service-cors/

---

**Tạo ngày**: 26/04/2026  
**Dự án**: T2K Coffee Shop Management System
