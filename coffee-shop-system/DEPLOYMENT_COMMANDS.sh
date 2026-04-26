#!/bin/bash
# 🚀 T2K Coffee Shop - Deployment Commands
# Copy từng section và paste vào terminal

################################################################################
# CÔNG VIỆC 1: Import SQL vào PlanetScale
################################################################################

# Lệnh import (thay HOST, USER, PASSWORD, DATABASE)
mysql -h HOST -u USER -p DATABASE < _dbcoffee_t2k.sql

# Ví dụ:
# mysql -h coffee-t2k-mysql.planetscale.com -u xxxxx -p coffee_t2k < _dbcoffee_t2k.sql

# Kiểm tra dữ liệu:
mysql -h HOST -u USER -p DATABASE -e "SELECT COUNT(*) as AccountCount FROM account;"
mysql -h HOST -u USER -p DATABASE -e "SELECT COUNT(*) as ProductCount FROM product;"

################################################################################
# CÔNG VIỆC 2: Test Backend Local (Sau khi cấu hình PlanetScale)
################################################################################

# Di chuyển vào thư mục backend
cd backend

# Clean & Build
mvn clean install

# Chạy ứng dụng
mvn spring-boot:run

# Hoặc run jar file sau khi build
java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar

################################################################################
# CÔNG VIỆC 3: Test API từ CLI
################################################################################

# Test Products API
curl -X GET http://localhost:8081/api/products

# Test Categories API
curl -X GET http://localhost:8081/api/categories

# Test Orders API
curl -X GET http://localhost:8081/api/orders

# Test Account/Staffs API
curl -X GET http://localhost:8081/api/staffs

# Test Tables API
curl -X GET http://localhost:8081/api/tables

# Test with headers
curl -X GET http://localhost:8081/api/products \
  -H "Content-Type: application/json" \
  -H "Accept: application/json"

################################################################################
# CÔNG VIỆC 4: Push Backend lên GitHub
################################################################################

# Di chuyển vào backend
cd backend

# Khởi tạo git repository
git init

# Tạo .gitignore cho Java/Maven
cat > .gitignore << 'EOF'
# Compiled class file
*.class

# Log file
*.log

# BlueJ files
*.ctxt

# Mobile Tools for Java (J2ME)
.mtj.tmp/

# Package Files
*.jar
*.war
*.nar
*.ear
*.zip
*.tar.gz
*.rar

# virtual machine crash logs
hs_err_pid*

# IDEs
.idea/
.vscode/
*.swp
*.swo
*~

# Maven
target/
*.class
pom.xml.tag
pom.xml.releaseBackup
pom.xml.versionsBackup
pom.xml.backup
release.properties
dependency-reduced-pom.xml
buildNumber.properties

# Environment
.env
.env.local
*.properties.local

# OS
.DS_Store
Thumbs.db
EOF

# Add tất cả files
git add .

# Commit
git commit -m "Initial commit: Coffee Shop Backend - Spring Boot API"

# Thêm remote origin (THAY YOUR_USERNAME và REPO_NAME)
git remote add origin https://github.com/YOUR_USERNAME/coffee-shop-backend.git

# Rename branch sang main
git branch -M main

# Push
git push -u origin main

################################################################################
# CÔNG VIỆC 5: Cấu hình Build & Deploy trên Render
################################################################################

# Tạo file application-prod.properties (hoặc cập nhật nó)
cat > backend/src/main/resources/application-prod.properties << 'EOF'
# PlanetScale Connection
spring.datasource.url=jdbc:mysql://${DB_HOST}:3306/${DB_NAME}?allowPublicKeyRetrieval=true&useSSL=true
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Hibernate
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
server.port=8080

# CORS
spring.mvc.cors.allowed-origins=*
spring.mvc.cors.allowed-methods=GET,POST,PUT,DELETE,PATCH,OPTIONS
spring.mvc.cors.allowed-headers=*
spring.mvc.cors.allow-credentials=true

# Logging
logging.level.org.springframework.web=INFO
logging.level.org.hibernate=WARN
logging.level.com.t2kcoffee=DEBUG
EOF

# Build lại sau khi thêm config production
mvn clean install

# Commit & push
git add .
git commit -m "Add production configuration for Render deployment"
git push origin main

################################################################################
# CÔNG VIỆC 6: Deploy Manual Test (Trước khi push)
################################################################################

# Build JAR
mvn clean package

# Test chạy JAR với environment variables
DB_HOST=localhost \
DB_USER=root \
DB_NAME=coffee_t2k \
DB_PASSWORD="" \
java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

# Test API sau deploy
curl -X GET http://localhost:8080/api/products

################################################################################
# CÔNG VIỆC 7: Push Frontend lên GitHub
################################################################################

# Di chuyển vào frontend
cd ../frontend

# Khởi tạo git
git init

# Tạo .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
package-lock.json
yarn.lock

# Environment
.env
.env.local
.env.*.local

# Build
dist/
build/
*.log

# IDE
.idea/
.vscode/
*.swp
*.swo
*~
.DS_Store
Thumbs.db

# Cache
.cache/
.eslintcache
EOF

# Add & Commit
git add .
git commit -m "Initial commit: Coffee Shop Frontend - Vanilla JS & HTML/CSS"

# Push (THAY YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/coffee-shop-frontend.git
git branch -M main
git push -u origin main

################################################################################
# CÔNG VIỆC 8: Cấu hình Frontend API URL
################################################################################

# Cập nhật api.js để trỏ tới Render backend
# Edit file: frontend/assets/js/api.js

# Thay dòng:
# const API = {
#     BASE_URL: 'http://localhost:8081/api',

# Thành:
# const API = {
#     BASE_URL: 'https://coffee-shop-api.onrender.com/api',  // Thay bằng URL Render của bạn

# Hoặc (nếu dùng .env)
cat > frontend/.env.production << 'EOF'
VITE_API_URL=https://coffee-shop-api.onrender.com/api
EOF

# Commit & push
git add .
git commit -m "Update API URL to production Render backend"
git push origin main

################################################################################
# CÔNG VIỆC 9: Test Frontend Local
################################################################################

# Nếu dùng Vite
cd frontend
npm install
npm run dev

# Test trên browser: http://localhost:5173
# Mở DevTools (F12) → Network tab
# Thực hiện action và kiểm tra requests

################################################################################
# CÔNG VIỆC 10: Enable CORS trên Backend
################################################################################

# Cập nhật application.properties với CORS config
cat >> backend/src/main/resources/application.properties << 'EOF'

# CORS Configuration
spring.mvc.cors.allowed-origins=http://localhost:3000,http://localhost:8081,https://xxxx.netlify.app
spring.mvc.cors.allowed-methods=GET,POST,PUT,DELETE,PATCH,OPTIONS
spring.mvc.cors.allowed-headers=Authorization,Content-Type,X-Requested-With,Accept
spring.mvc.cors.allow-credentials=true
spring.mvc.cors.max-age=3600
EOF

# Hoặc cập nhật application-prod.properties
cat >> backend/src/main/resources/application-prod.properties << 'EOF'

# CORS Configuration
spring.mvc.cors.allowed-origins=*
spring.mvc.cors.allowed-methods=GET,POST,PUT,DELETE,PATCH,OPTIONS
spring.mvc.cors.allowed-headers=*
spring.mvc.cors.allow-credentials=true
EOF

# Rebuild & test
mvn clean install
mvn spring-boot:run

# Test CORS từ browser console:
# fetch('http://localhost:8081/api/products').then(r=>r.json()).then(d=>console.log(d))

################################################################################
# CÔNG VIỆC 11: Test End-to-End từ Browser
################################################################################

# 1. Mở https://xxxx.netlify.app (Frontend)
# 2. Mở DevTools: F12
# 3. Vào Network tab
# 4. Thực hiện action (xem sản phẩm, login, etc.)
# 5. Kiểm tra requests:
#    - URL phải là https://coffee-shop-api.onrender.com/api/...
#    - Status phải là 200
#    - Response phải có dữ liệu từ PlanetScale

# Test trong console:
fetch('https://coffee-shop-api.onrender.com/api/products')
    .then(r => r.json())
    .then(d => console.log('Products:', d))

################################################################################
# 🔧 COMMANDS HỮU DỤNG
################################################################################

# Xem logs từ Render (cần install Render CLI)
npm install -g render-cli
render logs --service coffee-shop-api

# Xem commit history
git log --oneline

# Xem status
git status

# Kiểm tra remote
git remote -v

# Pull latest changes
git pull origin main

# Rollback commit
git revert HEAD

# Check Java version
java -version

# Check Maven version
mvn -version

# Check MySQL connection
mysql -h HOST -u USER -p --connect-expired-password

# Monitor Render deployment in real-time
# Vào https://dashboard.render.com → Service → Logs

################################################################################
# 🚨 TROUBLESHOOTING COMMANDS
################################################################################

# 1. CORS Error
# ✓ Kiểm tra CORS config
curl -X OPTIONS http://localhost:8081/api/products \
  -H "Origin: http://localhost:3000" \
  -H "Access-Control-Request-Method: GET" \
  -v

# 2. Database Connection Error
# ✓ Test MySQL connection
mysql -h HOST -u USER -p DATABASE -e "SELECT 1"

# 3. Port already in use
# ✓ Kill process trên port 8081
lsof -ti:8081 | xargs kill -9

# 4. Cache issues
# ✓ Clear Maven cache
rm -rf ~/.m2/repository

# 5. Build failures
# ✓ Clean rebuild
mvn clean install -DskipTests

################################################################################
