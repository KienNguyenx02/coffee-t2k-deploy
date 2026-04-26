# 🚀 T2K Coffee Shop - Cloud Deployment Guide

## 📚 Danh Sách Hướng Dẫn

Dự án này bao gồm các file hướng dẫn chi tiết cho việc deploy từ local lên cloud:

### 📖 Files Chính

1. **[DEPLOYMENT_PLAN.md](DEPLOYMENT_PLAN.md)** ⭐ **START HERE**
   - Hướng dẫn chi tiết từng bước (10 công việc)
   - Giải thích từng bước cần làm gì
   - Troubleshooting cho từng vấn đề
   - Best practices

2. **[DEPLOYMENT_COMMANDS.sh](DEPLOYMENT_COMMANDS.sh)**
   - Tất cả commands sẵn sàng copy-paste
   - Organized by sections (1-10)
   - Git commands, Maven commands, curl tests
   - Troubleshooting commands

3. **[PLANETSCALE_SETUP.md](PLANETSCALE_SETUP.md)**
   - Hướng dẫn tạo database trên PlanetScale
   - 4 cách import SQL (CLI, DBeaver, Workbench, Web UI)
   - Kiểm tra dữ liệu
   - Troubleshooting database issues

4. **[backend/RENDER_DEPLOYMENT.md](backend/RENDER_DEPLOYMENT.md)**
   - Hướng dẫn deploy Backend lên Render
   - 2 cách: render.yaml hoặc Manual
   - Environment variables cần thiết
   - Monitoring & logs

5. **[frontend/NETLIFY_DEPLOYMENT.md](frontend/NETLIFY_DEPLOYMENT.md)**
   - Hướng dẫn deploy Frontend lên Netlify
   - netlify.toml configuration
   - Environment variables cho API URL
   - Testing & monitoring

### 🔧 Code Files

6. **[backend/src/main/resources/application-prod.properties](backend/src/main/resources/application-prod.properties)**
   - Production configuration cho Render
   - Database connection settings
   - CORS configuration
   - Logging levels

7. **[backend/src/main/java/com/t2kcoffee/config/CorsConfig.java](backend/src/main/java/com/t2kcoffee/config/CorsConfig.java)**
   - CORS configuration
   - Allow origins, methods, headers
   - Static file serving

---

## 🎯 Quick Start (5 phút overview)

### Kiến Trúc Hệ Thống
```
Frontend (Netlify)
    ↓ HTTP Requests
Backend (Render Java Spring Boot)
    ↓ JDBC Connection
Database (PlanetScale MySQL)
```

### 10 Công Việc Chính

| # | Công Việc | Status | File |
|---|-----------|--------|------|
| 1 | Tạo PlanetScale DB & import SQL | ⬜ | PLANETSCALE_SETUP.md |
| 2 | Cấu hình Backend connection string | ⬜ | application.properties |
| 3 | Test API local | ⬜ | DEPLOYMENT_COMMANDS.sh |
| 4 | Push Backend lên GitHub | ⬜ | DEPLOYMENT_COMMANDS.sh |
| 5 | Deploy Backend lên Render | ⬜ | backend/RENDER_DEPLOYMENT.md |
| 6 | Cấu hình Frontend API URL | ⬜ | frontend/assets/js/api.js |
| 7 | Push Frontend lên GitHub | ⬜ | DEPLOYMENT_COMMANDS.sh |
| 8 | Deploy Frontend lên Netlify | ⬜ | frontend/NETLIFY_DEPLOYMENT.md |
| 9 | Bật CORS trên Backend | ⬜ | CorsConfig.java |
| 10 | Test End-to-End | ⬜ | DEPLOYMENT_PLAN.md |

---

## 🚀 Bắt Đầu Ngay

### Bước 1: Đọc Kế Hoạch
```bash
# Mở file chính
# -> DEPLOYMENT_PLAN.md
```

### Bước 2: Chuẩn Bị Credentials
Bạn sẽ cần:
- GitHub account
- PlanetScale account (free)
- Render account (free)
- Netlify account (free)

### Bước 3: Chạy Commands
```bash
# Copy từ DEPLOYMENT_COMMANDS.sh
# Paste vào terminal của bạn
# Thay thế YOUR_USERNAME, HOST, USER, PASSWORD
```

---

## 💾 Database Setup (QUAN TRỌNG)

### PlanetScale Connection String Format
```
mysql://USER:PASSWORD@HOST/DATABASE
```

### Backend Connection String
```properties
spring.datasource.url=jdbc:mysql://HOST:3306/DATABASE?allowPublicKeyRetrieval=true&useSSL=true
spring.datasource.username=USER
spring.datasource.password=PASSWORD
```

**Lưu ý**: 
- Thay HOST = xxx-mysql.planetscale.com
- Thay USER = credentials từ PlanetScale
- Thay PASSWORD = password từ PlanetScale
- Thay DATABASE = coffee-t2k

---

## 🔗 URLs & Endpoints

### Environments
| Environment | URL | Status |
|-----------|-----|--------|
| Local | http://localhost:8081 | 💻 Development |
| Render | https://coffee-shop-api.onrender.com | 🌐 Production |
| Netlify | https://xxxx.netlify.app | 🌐 Production |
| PlanetScale | planetscale.com | 🗄️ Production DB |

### Key Endpoints
```
GET    /api/products        - List sản phẩm
GET    /api/categories      - List danh mục
GET    /api/orders          - List đơn hàng
GET    /api/staffs          - List nhân viên
POST   /api/auth/login      - Đăng nhập
```

---

## 🛠️ Technology Stack

### Backend
- **Framework**: Spring Boot 3.1.0
- **Language**: Java 17
- **Build**: Maven
- **Database**: MySQL 8 (via JPA/Hibernate)
- **Security**: JWT + Spring Security
- **WebSocket**: For real-time updates
- **CORS**: Enabled

### Frontend
- **Type**: Vanilla JavaScript + HTML/CSS
- **API Client**: Fetch API
- **Auth**: JWT Token (localStorage)
- **Build**: Static files (no build step needed)

### Database
- **Type**: MySQL 8
- **Provider**: PlanetScale
- **Tables**: account, product, cafeorder, categories, etc.

### Hosting
- **Backend**: Render (Java Web Service)
- **Frontend**: Netlify (Static Site)
- **Database**: PlanetScale (MySQL as a Service)

---

## 🔒 Security Checklist

- [ ] CORS configured properly
- [ ] JWT token validation on backend
- [ ] Database credentials in environment variables (not hardcoded)
- [ ] HTTPS enforced on all services
- [ ] No sensitive data in logs
- [ ] SQL injection prevention (JPA/Hibernate)
- [ ] CSRF protection enabled

---

## 📊 Monitoring & Debugging

### Check Backend Status
```bash
curl https://coffee-shop-api.onrender.com/api/products
```

### Check Frontend Status
```
Visit: https://xxxx.netlify.app
Open DevTools: F12
Check Network tab for API calls
```

### View Logs
```bash
# Render backend logs
npm install -g render-cli
render logs --service coffee-shop-api

# Netlify deployment logs
# Via: https://app.netlify.com
```

---

## 🆘 Troubleshooting

### Common Issues

#### ❌ CORS Error
**Message**: `Access to XMLHttpRequest blocked by CORS policy`

**Solution**:
1. Check CorsConfig.java
2. Verify Netlify origin in allowedOrigins
3. Restart backend service
4. Clear browser cache

#### ❌ 404 Not Found
**Message**: `GET /api/products 404`

**Solution**:
1. Check endpoint exists in controller
2. Check Render deployment logs
3. Restart service

#### ❌ Database Connection Error
**Message**: `Connection refused` or `Access denied`

**Solution**:
1. Verify PlanetScale credentials
2. Check environment variables in Render
3. Test connection locally first

#### ❌ Netlify Deployment Failed
**Message**: `Build failed` or `Deploy failed`

**Solution**:
1. Check build command in netlify.toml
2. Check API_URL environment variable
3. Check GitHub repo accessibility

---

## 📈 Performance Tips

1. **Database**
   - Add indexes on frequently queried columns
   - Optimize queries
   - Monitor connection pool size

2. **Backend**
   - Enable response compression
   - Use caching (Redis if needed)
   - Monitor memory usage

3. **Frontend**
   - Minify CSS/JS (use bundler)
   - Lazy load images
   - Enable browser caching
   - Use CDN for static assets

---

## 🆙 Updates & Maintenance

### Deploying Updates

```bash
# 1. Make code changes
# 2. Test locally
# 3. Commit & push
git add .
git commit -m "Feature: description"
git push origin main

# 4. Render auto-deploys backend
# 5. Netlify auto-deploys frontend
```

### Rollback

```bash
# GitHub
git revert HEAD
git push origin main

# Render/Netlify auto-redeploy old version
```

---

## 📚 Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [PlanetScale Docs](https://planetscale.com/docs)
- [Render Documentation](https://render.com/docs)
- [Netlify Documentation](https://docs.netlify.com)
- [MySQL Documentation](https://dev.mysql.com/doc/)

---

## 📞 Support

### When You Get Stuck

1. **Check logs first**
   - Browser DevTools (F12)
   - Render Dashboard
   - Netlify Dashboard
   - MySQL client

2. **Read troubleshooting section in each guide**

3. **Search GitHub issues** for similar problems

4. **Ask in communities**
   - Stack Overflow
   - Spring Community
   - Render Support

---

## ✅ Checklist Before Going Live

- [ ] Database imported successfully
- [ ] Backend tests locally with PlanetScale
- [ ] Backend deployed on Render
- [ ] Frontend updated with Render API URL
- [ ] Frontend deployed on Netlify
- [ ] CORS enabled on backend
- [ ] End-to-end testing passed
- [ ] All 3 services (DB, API, Web) accessible
- [ ] No console errors on frontend
- [ ] API responses correct in Network tab

---

## 🎉 Success Indicators

✅ You're done when:
1. Visit Netlify URL → Website loads
2. Click any button → API calls Render backend
3. Render API → queries PlanetScale database
4. See real data from your database
5. No CORS errors
6. No 404 errors
7. All features work (products, categories, orders)

---

## 📅 Timeline

Estimated time to completion:
- Database setup: 10-15 minutes
- Backend configuration: 5-10 minutes
- Frontend configuration: 5 minutes
- GitHub push: 5 minutes
- Render deployment: 10-15 minutes
- Netlify deployment: 5-10 minutes
- Testing & troubleshooting: 15-30 minutes

**Total: 1-2 hours** (đã bao gồm troubleshooting)

---

## 📝 Notes

- Keep credentials safe (use environment variables)
- Don't commit `.properties` files with real credentials
- Monitor free tier limits (Render, Netlify, PlanetScale)
- Set up alerts for production issues
- Document any custom configurations

---

**Tạo ngày**: 26/04/2026  
**Dự án**: T2K Coffee Shop Management System  
**Status**: Ready for cloud deployment
