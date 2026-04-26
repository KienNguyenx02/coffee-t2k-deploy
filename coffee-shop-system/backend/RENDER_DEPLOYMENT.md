# Render Configuration File
# Đặt file này ở gốc backend repo hoặc đặt configuration trong Render dashboard

# ============================================================================
# CÁCH 1: Tạo render.yaml (Automatic deployment configuration)
# ============================================================================
# Tạo file backend/render.yaml với content:

services:
  - type: web
    name: coffee-shop-api
    env: java
    plan: free
    buildCommand: mvn clean install -DskipTests
    startCommand: java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
    envVars:
      - key: DB_HOST
        value: YOUR_PLANETSCALE_HOST
      - key: DB_USER
        value: YOUR_PLANETSCALE_USER
      - key: DB_PASSWORD
        value: YOUR_PLANETSCALE_PASSWORD
      - key: DB_NAME
        value: coffee-t2k
      - key: JAVA_VERSION
        value: "17"

# ============================================================================
# CÁCH 2: Manual configuration trong Render Dashboard
# ============================================================================

# 1. Tạo Web Service trên Render
#    - Vào https://dashboard.render.com
#    - Click "Create +" → "Web Service"
#    - Chọn GitHub repo: coffee-shop-backend

# 2. Cấu hình Service:
#    - Name: coffee-shop-api
#    - Runtime: Java
#    - Region: Singapore (hoặc gần nhất)
#    - Plan: Free (hoặc Starter)

# 3. Build & Deploy:
#    - Build Command: mvn clean install -DskipTests
#    - Start Command: java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod

# 4. Environment Variables (QUAN TRỌNG):
#    Click "Environment" và thêm:
#
#    DB_HOST          = xxx-mysql.planetscale.com
#    DB_USER          = xxxxxxxxxxxxxxxx
#    DB_PASSWORD      = pscale_pw_xxxxxxxxxxxxxxxx
#    DB_NAME          = coffee-t2k
#    JAVA_VERSION     = 17

# 5. Deploy:
#    - Click "Deploy"
#    - Đợi 3-5 phút
#    - Xem logs (đảm bảo không có lỗi)
#    - Status = "Live" (xanh)

# ============================================================================
# KIỂM TRA CÁC STEPS QUAN TRỌNG
# ============================================================================

# ✓ Step 1: Connect GitHub account
#   - Render có thể truy cập repository coffee-shop-backend
#   - Render trigger deploy khi push code

# ✓ Step 2: Environment Variables
#   - Kiểm tra 5 biến ở trên đã được thêm
#   - Không có lỗi typo trong HOST, USER, PASSWORD

# ✓ Step 3: Build Logs
#   - Maven build thành công
#   - Tìm dòng: "BUILD SUCCESS"

# ✓ Step 4: Deploy Logs
#   - Tìm dòng: "Application started"
#   - Port 8080 listening

# ✓ Step 5: Test API
#   - GET https://coffee-shop-api.onrender.com/api/products
#   - Status 200
#   - Response có dữ liệu

# ============================================================================
# TROUBLESHOOTING
# ============================================================================

# ❌ Build Error: "mvn: command not found"
# → Render phải tự động detect Java project, hoặc specify Java version

# ❌ Database Connection Error
# → Kiểm tra Environment Variables
# → Kiểm tra PlanetScale connection string đúng
# → Kiểm tra PlanetScale password không có special characters cần escape

# ❌ Timeout Error (Build takes > 30 minutes)
# → Chuyển sang Starter plan
# → Hoặc optimize pom.xml dependencies

# ❌ "Address already in use :8080"
# → Backend service đã running, restart service

# ❌ WebSocket Connection Failed
# → Frontend config URL không đúng
# → Kiểm tra CORS headers

# ============================================================================
# LOGS & MONITORING
# ============================================================================

# Xem logs real-time:
# 1. Render Dashboard → Service → Logs tab
# 2. Hoặc cài Render CLI:
#    npm install -g render-cli
#    render logs --service coffee-shop-api

# Các log entry quan trọng:
# - "Started CoffeeT2KApplication in X.XXX seconds"
#   → Application khởi động thành công

# - "Connection successful to PlanetScale"
#   → Database connection OK

# - "Tomcat started on port(s): 8080"
#   → Server listening trên port 8080

# ============================================================================
# URL PUBLIC RENDER
# ============================================================================

# Sau khi deploy thành công:
# https://coffee-shop-api.onrender.com

# Test endpoints:
# GET https://coffee-shop-api.onrender.com/api/products
# GET https://coffee-shop-api.onrender.com/api/categories
# GET https://coffee-shop-api.onrender.com/api/orders
# POST https://coffee-shop-api.onrender.com/api/auth/login

# ============================================================================
