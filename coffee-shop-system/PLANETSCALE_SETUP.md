# PlanetScale Setup & SQL Import Guide
# Hướng dẫn tạo database PlanetScale và import SQL

# ============================================================================
# BƯỚC 1: Tạo Tài Khoản PlanetScale
# ============================================================================

# 1. Vào https://planetscale.com
# 2. Click "Sign up" (hoặc "Sign in with GitHub")
# 3. Nhập email, password hoặc đăng nhập GitHub
# 4. Xác thực email (nếu cần)
# 5. Lựa chọn organization hoặc tạo mới

# ============================================================================
# BƯỚC 2: Tạo Database
# ============================================================================

# 1. Vào https://app.planetscale.com
# 2. Click "Create a new database" hoặc "Create" button
# 3. Điền:
#    - Database name: coffee-t2k (hoặc tên khác)
#    - Region: Singapore (gần Việt Nam nhất)
#    - Chọn "Development" database (free)
# 4. Click "Create database"
# 5. Đợi ~1 phút để database được tạo

# ============================================================================
# BƯỚC 3: Lấy Connection Information
# ============================================================================

# 1. Vào PlanetScale Dashboard
# 2. Click vào database "coffee-t2k"
# 3. Click "Connections" hoặc "Connect"
# 4. Chọn "Connect with: MySQL client"
# 5. Sẽ hiện connection string dạng:
#
#    mysql://[user]:[password]@[host]/[database]
#
#    Ví dụ:
#    mysql://xxxxx_xxxxx:pscale_pw_xxxxxxxxxxxxx@coffee-t2k-mysql.planetscale.com/coffee-t2k
#
# 6. Từ đó, tách ra:
#    - HOST: coffee-t2k-mysql.planetscale.com
#    - USER: xxxxx_xxxxx
#    - PASSWORD: pscale_pw_xxxxxxxxxxxxx
#    - DATABASE: coffee-t2k
#    - PORT: 3306 (default)

# ============================================================================
# BƯỚC 4: Chuẩn Bị SQL File
# ============================================================================

# File SQL hiện có tại:
# _dbcoffee_t2k.sql

# File này chứa:
# - CREATE TABLE statements
# - INSERT statements (dữ liệu mẫu)
# - Indexes, Primary Keys, Foreign Keys

# Nếu chưa có SQL dump từ local MySQL, tạo bằng cách:
# mysqldump -u root -p coffee_t2k > _dbcoffee_t2k.sql

# ============================================================================
# BƯỚC 5: Import SQL vào PlanetScale (Cách 1: MySQL CLI)
# ============================================================================

# Đầu tiên cài MySQL Client (nếu chưa có):
# Windows: https://dev.mysql.com/downloads/mysql/
# Mac: brew install mysql-client
# Linux: sudo apt install mysql-client

# Terminal command:
# ────────────────────────────────────────────────
# mysql -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] < _dbcoffee_t2k.sql
#
# Ví dụ (thay bằng credentials thực):
# mysql -h coffee-t2k-mysql.planetscale.com \
#   -u xxxxx_xxxxx \
#   -p"pscale_pw_xxxxxxxxxxxxx" \
#   coffee-t2k < _dbcoffee_t2k.sql
#
# Hoặc nhập password khi được yêu cầu (an toàn hơn):
# mysql -h coffee-t2k-mysql.planetscale.com \
#   -u xxxxx_xxxxx \
#   -p \
#   coffee-t2k < _dbcoffee_t2k.sql
# (nhập password khi được yêu cầu)

# Kiểm tra import thành công:
# mysql -h [HOST] -u [USER] -p[PASSWORD] [DATABASE] \
#   -e "SELECT COUNT(*) as account_count FROM account;"

# ============================================================================
# BƯỚC 5: Import SQL (Cách 2: DBeaver GUI - Dễ Nhất)
# ============================================================================

# 1. Download DBeaver Community: https://dbeaver.io/download/
# 2. Cài đặt
# 3. Mở DBeaver
# 4. "Database" → "New Database Connection"
# 5. Chọn "MySQL" → "Next"
# 6. Điền connection info:
#    - Hostname: coffee-t2k-mysql.planetscale.com
#    - Port: 3306
#    - Database: coffee-t2k
#    - Username: xxxxx_xxxxx
#    - Password: pscale_pw_xxxxxxxxxxxxx
#    - Check "Save password locally" (tùy chọn)
# 7. Click "Test Connection" → phải thành công
# 8. Click "Finish"
# 9. Mở connection mới tạo
# 10. "SQL Editor" → "New SQL Script"
# 11. "File" → "Open SQL Script" → chọn _dbcoffee_t2k.sql
# 12. Click "Execute" (hoặc Ctrl+Enter)
# 13. Chờ import hoàn tất

# ============================================================================
# BƯỚC 5: Import SQL (Cách 3: MySQL Workbench)
# ============================================================================

# 1. Mở MySQL Workbench
# 2. "Database" → "Manage Connections"
# 3. "New" → Điền connection info:
#    - Connection Name: PlanetScale Coffee
#    - Hostname: coffee-t2k-mysql.planetscale.com
#    - Port: 3306
#    - Username: xxxxx_xxxxx
#    - Password: pscale_pw_xxxxxxxxxxxxx
# 4. Test connection
# 5. Double-click connection để mở
# 6. "File" → "Open SQL Script" → chọn _dbcoffee_t2k.sql
# 7. Ctrl+Enter hoặc click lightning icon để execute

# ============================================================================
# BƯỚC 5: Import SQL (Cách 4: Web UI PlanetScale)
# ============================================================================

# 1. Vào https://app.planetscale.com
# 2. Click database → "Import"
# 3. Upload file _dbcoffee_t2k.sql
# 4. Chọn "Import SQL" hoặc "Import from file"
# 5. Đợi import hoàn tất

# ============================================================================
# BƯỚC 6: Kiểm Tra Dữ Liệu Sau Import
# ============================================================================

# 1. Mở terminal hoặc MySQL client
# 2. Kết nối tới PlanetScale:
#    mysql -h [HOST] -u [USER] -p [DATABASE]

# 3. Chạy các query kiểm tra:

# Kiểm tra bảng tồn tại:
# SHOW TABLES;

# Đếm account:
# SELECT COUNT(*) FROM account;

# Đếm sản phẩm:
# SELECT COUNT(*) FROM product;

# Đếm đơn hàng:
# SELECT COUNT(*) FROM cafeorder;

# Xem data account:
# SELECT * FROM account LIMIT 5;

# Xem data sản phẩm:
# SELECT * FROM product LIMIT 5;

# Xem struktur bảng:
# DESCRIBE account;
# DESCRIBE product;

# ============================================================================
# BƯỚC 7: Configuration cho Backend Java
# ============================================================================

# Cập nhật file: backend/application.properties

# spring.datasource.url=jdbc:mysql://[HOST]:3306/[DATABASE]?allowPublicKeyRetrieval=true&useSSL=true
# spring.datasource.username=[USER]
# spring.datasource.password=[PASSWORD]
# spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Ví dụ:
# spring.datasource.url=jdbc:mysql://coffee-t2k-mysql.planetscale.com:3306/coffee-t2k?allowPublicKeyRetrieval=true&useSSL=true
# spring.datasource.username=xxxxx_xxxxx
# spring.datasource.password=pscale_pw_xxxxxxxxxxxxx

# ============================================================================
# BƯỚC 8: Test Connection từ Java Backend
# ============================================================================

# 1. Cập nhật application.properties (bước 7)
# 2. Chạy backend:
#    mvn spring-boot:run
# 3. Xem logs, tìm message như:
#    "HikariPool-1 - Connection is valid"
#    "Started CoffeeT2KApplication"
#    → OK, connection thành công!

# 4. Test API:
#    curl http://localhost:8081/api/products
#    → Phải có dữ liệu từ PlanetScale

# ============================================================================
# 🚨 TROUBLESHOOTING
# ============================================================================

# ❌ "Access denied for user 'xxx'@'xxx' (using password: YES)"
# Nguyên nhân: Username, password, hoặc database name sai
# Giải pháp:
#   1. Copy lại connection string từ PlanetScale
#   2. Kiểm tra từng thành phần: HOST, USER, PASSWORD, DATABASE
#   3. Không có khoảng trắng thừa
#   4. Special characters trong password cần escape

# ❌ "java.sql.SQLException: Cannot create a PoolableConnectionFactory"
# Nguyên nhân: Connection string sai định dạng
# Giải pháp:
#   1. Format: jdbc:mysql://HOST:PORT/DATABASE?allowPublicKeyRetrieval=true&useSSL=true
#   2. Kiểm tra port = 3306
#   3. Kiểm tra tên database đúng

# ❌ "Table 'coffee-t2k.account' doesn't exist"
# Nguyên nhân: SQL import chưa thành công
# Giải pháp:
#   1. Kiểm tra import status
#   2. Chạy lại: mysql -h HOST -u USER -p < _dbcoffee_t2k.sql
#   3. Kiểm tra SHOW TABLES; trong MySQL

# ❌ "COLLATION 'utf8mb4_unicode_ci' is not valid for CHARACTER SET 'utf8'"
# Nguyên nhân: SQL file có charset mismatch
# Giải pháp:
#   1. Sửa SQL file: SET NAMES utf8mb4;
#   2. Hoặc import lại với collation đúng

# ❌ "SSL_ERROR_UNKNOWN_CA_ALERT"
# Nguyên nhân: useSSL=true nhưng certificate không hợp lệ
# Giải pháp:
#   1. Thêm: &allowPublicKeyRetrieval=true
#   2. Connection string:
#      jdbc:mysql://HOST:3306/DB?allowPublicKeyRetrieval=true&useSSL=true&serverTimezone=UTC

# ============================================================================
# BEST PRACTICES
# ============================================================================

# 1. Backup dữ liệu định kỳ
#    mysqldump -h HOST -u USER -p DB > backup_$(date +%Y%m%d).sql

# 2. Không share connection string trong code
#    → Dùng environment variables

# 3. Giới hạn user permissions (nếu PlanetScale support)

# 4. Monitor database size
#    SELECT COUNT(*) FROM information_schema.tables;

# 5. Regular maintenance
#    OPTIMIZE TABLE account, product, cafeorder;

# ============================================================================
# NEXTJS STEPS AFTER DATABASE SETUP
# ============================================================================

# 1. ✓ Database created & SQL imported
# 2. ✓ Connection string configured in application.properties
# 3. → Next: Configure Backend (Render deployment)
# 4. → Next: Configure Frontend API URL
# 5. → Next: Deploy Backend (Render)
# 6. → Next: Deploy Frontend (Netlify)
# 7. → Next: Enable CORS
# 8. → Next: End-to-end testing

# ============================================================================
