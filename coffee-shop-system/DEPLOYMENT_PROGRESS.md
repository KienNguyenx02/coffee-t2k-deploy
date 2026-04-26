# 📋 T2K Coffee Shop - Deployment Progress Tracker

## 🎯 Deployment Status

**Project**: T2K Coffee System  
**Start Date**: 26/04/2026  
**Target**: Deploy to Cloud (PlanetScale, Render, Netlify)

---

## ✅ Công Việc & Progress

### PHASE 1: Database Setup
- [ ] **Công Việc 1**: Tạo PlanetScale database
  - [ ] Tạo account PlanetScale
  - [ ] Tạo database "coffee-t2k"
  - [ ] Lấy connection credentials (HOST, USER, PASSWORD)
  - [ ] Import SQL file (_dbcoffee_t2k.sql)
  - [ ] Verify dữ liệu trong database

**Hướng dẫn**: [PLANETSCALE_SETUP.md](PLANETSCALE_SETUP.md)

---

### PHASE 2: Backend Configuration & Deploy
- [ ] **Công Việc 2**: Cấu hình Backend connection string
  - [ ] Cập nhật application.properties với PlanetScale credentials
  - [ ] Cập nhật application-prod.properties cho Render
  - [ ] Verify format connection string đúng

**Files**: 
- application.properties
- application-prod.properties (đã tạo)

- [ ] **Công Việc 3**: Test API local
  - [ ] Run backend: `mvn spring-boot:run`
  - [ ] Test /api/products
  - [ ] Test /api/categories
  - [ ] Test /api/orders
  - [ ] Verify data từ PlanetScale

**Commands**: [DEPLOYMENT_COMMANDS.sh](DEPLOYMENT_COMMANDS.sh)

- [ ] **Công Việc 4**: Push Backend lên GitHub
  - [ ] Tạo GitHub repository "coffee-shop-backend"
  - [ ] Tạo .gitignore
  - [ ] `git init && git add . && git commit`
  - [ ] `git remote add origin ...`
  - [ ] `git push -u origin main`

- [ ] **Công Việc 5**: Deploy Backend lên Render
  - [ ] Tạo Render account
  - [ ] Create Web Service từ GitHub repo
  - [ ] Cấu hình Build Command: `mvn clean install -DskipTests`
  - [ ] Cấu hình Start Command: `java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod`
  - [ ] Thêm Environment Variables:
    - DB_HOST = xxx-mysql.planetscale.com
    - DB_USER = xxxxx
    - DB_PASSWORD = pscale_pw_xxxxx
    - DB_NAME = coffee-t2k
  - [ ] Deploy & xem logs
  - [ ] Test API endpoint trên Render

**Hướng dẫn**: [backend/RENDER_DEPLOYMENT.md](backend/RENDER_DEPLOYMENT.md)

---

### PHASE 3: Frontend Configuration & Deploy
- [ ] **Công Việc 6**: Cấu hình Frontend API URL
  - [ ] Cập nhật frontend/assets/js/api.js
  - [ ] Thay BASE_URL từ `http://localhost:8081/api` 
  - [ ] Thành `https://coffee-shop-api.onrender.com/api` (thay bằng URL Render thực)
  - [ ] Test local: `npm run dev` hoặc `python -m http.server`

**File**: frontend/assets/js/api.js

- [ ] **Công Việc 7**: Push Frontend lên GitHub
  - [ ] Tạo GitHub repository "coffee-shop-frontend"
  - [ ] Tạo .gitignore
  - [ ] `git init && git add . && git commit`
  - [ ] `git push -u origin main`

- [ ] **Công Việc 8**: Deploy Frontend lên Netlify
  - [ ] Tạo Netlify account
  - [ ] "Import an existing project" từ GitHub
  - [ ] Chọn "coffee-shop-frontend" repo
  - [ ] Cấu hình:
    - Build command: (để trống nếu vanilla, hoặc npm run build)
    - Publish directory: . (hoặc dist nếu Vite)
  - [ ] Deploy & lấy URL (https://xxxx.netlify.app)

**Hướng dẫn**: [frontend/NETLIFY_DEPLOYMENT.md](frontend/NETLIFY_DEPLOYMENT.md)

---

### PHASE 4: CORS & End-to-End Testing
- [ ] **Công Việc 9**: Bật CORS trên Backend
  - [ ] Update CorsConfig.java với Netlify origin
  - [ ] Hoặc update application.properties CORS settings
  - [ ] Commit & push
  - [ ] Render auto-redeploy

**File**: CorsConfig.java

- [ ] **Công Việc 10**: Test End-to-End
  - [ ] Mở Netlify website: https://xxxx.netlify.app
  - [ ] Mở DevTools (F12) → Network tab
  - [ ] Test tất cả features:
    - [ ] Xem Products
    - [ ] Xem Categories
    - [ ] Xem Orders
    - [ ] Login
    - [ ] Any API calls
  - [ ] Kiểm tra Network tab:
    - [ ] Requests đến https://coffee-shop-api.onrender.com/api/...
    - [ ] Status 200 OK
    - [ ] Response có data
  - [ ] Console không có errors

---

## 🔗 URLs & Credentials

### URLs
| Service | URL | Status |
|---------|-----|--------|
| PlanetScale | https://app.planetscale.com | ⬜ Setup |
| Render | https://coffee-shop-api.onrender.com | ⬜ Deploy |
| Netlify | https://xxxx.netlify.app | ⬜ Deploy |
| Backend Local | http://localhost:8081 | ⬜ Testing |

### Credentials (Lưu tại đây hoặc trong .env)
```
PlanetScale:
  HOST: [nhập từ PlanetScale]
  USER: [nhập từ PlanetScale]
  PASSWORD: [nhập từ PlanetScale]
  DATABASE: coffee-t2k

GitHub:
  Backend Repo: https://github.com/YOUR_USERNAME/coffee-shop-backend
  Frontend Repo: https://github.com/YOUR_USERNAME/coffee-shop-frontend

Render:
  Service Name: coffee-shop-api
  URL: https://coffee-shop-api.onrender.com

Netlify:
  Site Name: [tùy theo Netlify]
  URL: https://xxxx.netlify.app
```

---

## 🐛 Troubleshooting Log

### Issue 1: [Your First Issue]
**Description**: 
**Error Message**: 
**Solution**: 
**Resolved**: ⬜

### Issue 2: [Your Second Issue]
**Description**: 
**Error Message**: 
**Solution**: 
**Resolved**: ⬜

---

## 📊 Performance Metrics (Sau Deploy)

| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| API Response Time | < 500ms | ⬜ | ⬜ |
| Frontend Load Time | < 2s | ⬜ | ⬜ |
| Database Queries | < 100ms | ⬜ | ⬜ |
| CORS Requests | 200 OK | ⬜ | ⬜ |
| Uptime | 99.9% | ⬜ | ⬜ |

---

## 📝 Notes & Observations

- Dự án đã có CORS config sẵn trong CorsConfig.java
- Frontend là Vanilla JS, không cần build step
- Backend sử dụng Spring Boot 3.1.0 và Java 17
- Database schema đã định nghĩa, dùng validate mode (không auto-create)
- JWT authentication đã implement
- WebSocket support có sẵn (nếu cần dùng)

---

## ✅ Checklist Trước Khi Go Live

- [ ] Database đã import thành công
- [ ] Backend kết nối được PlanetScale
- [ ] Backend API endpoints đều trả về dữ liệu
- [ ] Backend deploy thành công lên Render (Status = Live)
- [ ] Frontend API URL đã cập nhật
- [ ] Frontend deploy thành công lên Netlify
- [ ] CORS enabled (kiểm tra response headers)
- [ ] End-to-end test thành công
- [ ] Tất cả 3 services (DB, API, Web) accessible
- [ ] Console không có errors
- [ ] Network requests đều 200 OK
- [ ] Data hiển thị đúng từ database

---

## 🎯 Success Criteria

✅ **Deployment thành công khi:**
1. Website Netlify → có thể truy cập
2. Website gọi API Render → API response 200
3. API Render query PlanetScale → dữ liệu trả về
4. Không có CORS errors
5. Không có 404 errors
6. All features work correctly

---

## 📞 Reference Documents

- [DEPLOYMENT_PLAN.md](DEPLOYMENT_PLAN.md) - Hướng dẫn chi tiết
- [DEPLOYMENT_COMMANDS.sh](DEPLOYMENT_COMMANDS.sh) - Commands copy-paste
- [PLANETSCALE_SETUP.md](PLANETSCALE_SETUP.md) - Database setup
- [backend/RENDER_DEPLOYMENT.md](backend/RENDER_DEPLOYMENT.md) - Backend deploy
- [frontend/NETLIFY_DEPLOYMENT.md](frontend/NETLIFY_DEPLOYMENT.md) - Frontend deploy
- [README_DEPLOYMENT.md](README_DEPLOYMENT.md) - Overview tất cả

---

**Last Updated**: 26/04/2026  
**Next Review**: [Your Target Date]  
**Status**: Ready to start deployment
