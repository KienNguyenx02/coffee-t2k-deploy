# Netlify Configuration for Frontend
# Hướng dẫn deploy Frontend lên Netlify

# ============================================================================
# CÁCH 1: Dùng netlify.toml (Automatic configuration)
# ============================================================================
# Tạo file frontend/netlify.toml với content:

[build]
# Nếu dùng Vite
command = "npm run build"
publish = "dist"

# Nếu dùng vanilla JS (không cần build)
command = ""
publish = "."

[[redirects]]
# Redirect tất cả requests về index.html (cho SPA)
from = "/*"
to = "/index.html"
status = 200

[context.production.environment]
# Environment variables cho production
VITE_API_URL = "https://coffee-shop-api.onrender.com/api"

[context.preview.environment]
VITE_API_URL = "https://coffee-shop-api.onrender.com/api"

[context.deploy-preview.environment]
VITE_API_URL = "https://coffee-shop-api.onrender.com/api"

[[headers]]
for = "/*"
[headers.values]
  X-Frame-Options = "SAMEORIGIN"
  X-XSS-Protection = "1; mode=block"
  X-Content-Type-Options = "nosniff"
  Referrer-Policy = "strict-origin-when-cross-origin"

# ============================================================================
# CÁCH 2: Manual configuration trong Netlify Dashboard
# ============================================================================

# 1. Đăng nhập vào https://netlify.com

# 2. "Add new site" → "Import an existing project"

# 3. Chọn GitHub provider → Kết nối account

# 4. Chọn coffee-shop-frontend repository

# 5. Cấu hình Build Settings:
#
#    Build command: 
#    - Nếu Vite: npm run build
#    - Nếu vanilla: (để trống)
#
#    Publish directory:
#    - Nếu Vite: dist
#    - Nếu vanilla: .
#
#    Base directory: (để trống)

# 6. Environment Variables:
#    Click "Advanced" → "New variable"
#
#    Key: VITE_API_URL
#    Value: https://coffee-shop-api.onrender.com/api

# 7. Deploy
#    - Click "Deploy site"
#    - Đợi ~1-2 phút
#    - Xem Netlify URL

# ============================================================================
# NETLIFY.TOML FULL EXAMPLE (Vanilla JS)
# ============================================================================

# [build]
# command = ""
# publish = "."
# 
# [[redirects]]
# from = "/*"
# to = "/index.html"
# status = 200
#
# [dev]
# command = "live-server . --port=8888"
# targetPort = 8888
#
# [[headers]]
# for = "/*"
# [headers.values]
#   Access-Control-Allow-Origin = "*"
#   Cache-Control = "max-age=0"

# ============================================================================
# NETLIFY.TOML FULL EXAMPLE (Vite)
# ============================================================================

# [build]
# command = "npm run build"
# publish = "dist"
#
# [[redirects]]
# from = "/*"
# to = "/index.html"
# status = 200
#
# [dev]
# command = "npm run dev"
# targetPort = 5173

# ============================================================================
# UPDATE API.JS HOẶC .ENV
# ============================================================================

# Option 1: Update api.js trực tiếp (Vanilla JS)
# ────────────────────────────────────────────
# File: frontend/assets/js/api.js
# 
# Thay từ:
#   const API = {
#       BASE_URL: 'http://localhost:8081/api',
#       ...
#   };
#
# Thành:
#   const API = {
#       BASE_URL: 'https://coffee-shop-api.onrender.com/api',
#       ...
#   };

# Option 2: Dùng .env (Vite)
# ────────────────────────────────────────────
# Tạo file frontend/.env.production
#   VITE_API_URL=https://coffee-shop-api.onrender.com/api
#
# Trong api.js:
#   const API = {
#       BASE_URL: import.meta.env.VITE_API_URL || 'http://localhost:8081/api',
#       ...
#   };

# ============================================================================
# GIT WORKFLOW
# ============================================================================

# 1. Cập nhật code (api.js hoặc .env)
# 2. Commit & Push:
#    git add .
#    git commit -m "Update API URL to production"
#    git push origin main

# 3. Netlify tự động detect push → Build & Deploy
# 4. Xem status trong https://app.netlify.com

# ============================================================================
# TEST DEPLOYMENT
# ============================================================================

# 1. Mở https://xxxx.netlify.app (URL của Netlify)

# 2. Mở DevTools: F12

# 3. Vào Network tab, thực hiện action:
#    - Xem Products page
#    - Xem Categories
#    - Login
#    - Tạo Order

# 4. Kiểm tra Network requests:
#    - Requests đến https://coffee-shop-api.onrender.com/api/... ✓
#    - Status = 200 ✓
#    - Response có dữ liệu ✓

# 5. Console tab - Không có error ✓

# ============================================================================
# MONITORING & DEBUGGING
# ============================================================================

# Netlify Dashboard - Xem deployed version:
# 1. https://app.netlify.com
# 2. Select site → Deploys tab
# 3. Xem deploy status, logs, timeline

# Test CORS từ browser console:
# fetch('https://coffee-shop-api.onrender.com/api/products', {
#   headers: {'Content-Type': 'application/json'}
# })
# .then(r => r.json())
# .then(d => console.log(d))

# ============================================================================
# TROUBLESHOOTING
# ============================================================================

# ❌ "Failed to fetch"
# Nguyên nhân: Backend API URL sai, hoặc CORS chưa enable
# Giải pháp: 
#   1. Kiểm tra api.js hoặc .env có đúng URL Render?
#   2. Kiểm tra backend CorsConfig có cho phép origin Netlify?
#   3. Commit & push code, Netlify tự động rebuild

# ❌ "Access-Control-Allow-Origin" header error
# Nguyên nhân: Backend CORS chưa config đúng
# Giải pháp:
#   1. Cập nhật backend application-prod.properties
#   2. Thêm spring.mvc.cors.allowed-origins=*
#   3. Rebuild backend → Render tự động redeploy
#   4. Chờ ~2 phút, refresh frontend

# ❌ "Cannot GET /"
# Nguyên nhân: Build command sai, hoặc publish directory sai
# Giải pháp:
#   1. Kiểm tra netlify.toml build & publish settings
#   2. Hoặc cập nhật trong Netlify Dashboard
#   3. Trigger manual deploy

# ❌ "CORS error but API responds 200"
# Nguyên nhân: Backend đã response nhưng không có CORS headers
# Giải pháp:
#   1. Đảm bảo backend @CrossOrigin hoặc CorsConfig đúng
#   2. Restart backend service
#   3. Clear browser cache (Ctrl+Shift+Delete)

# ============================================================================
# PERFORMANCE TIPS
# ============================================================================

# 1. Enable caching
#    [[headers]]
#    for = "/assets/*"
#    [headers.values]
#      Cache-Control = "public, max-age=31536000, immutable"

# 2. Minify CSS/JS (Vite tự động làm)

# 3. Lazy load images
#    <img src="..." loading="lazy" />

# 4. Monitor performance
#    https://app.netlify.com → Analytics tab

# ============================================================================
# NETLIFY URL & DOMAINS
# ============================================================================

# URL mặc định:
# https://[unique-id].netlify.app

# Cấu hình custom domain:
# 1. Netlify Dashboard → Domain settings
# 2. Thêm custom domain (ví dụ: coffee-t2k.com)
# 3. Update DNS records (thường Netlify hướng dẫn)

# ============================================================================
