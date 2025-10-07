# 🚀 T2K Coffee - Hướng Dẫn Chạy Hệ Thống

## ✅ **Trạng thái hiện tại:**
- ✅ Backend đang chạy trên port 8081
- ✅ Ngrok tunnel hoạt động: `https://impetrative-jenelle-rightly.ngrok-free.dev`
- ✅ Database kết nối thành công
- ✅ WebSocket sẵn sàng
- ✅ Mobile app đã được cấu hình

## 🚀 **Cách chạy hệ thống:**

### 1. **Backend (Spring Boot)**
```bash
cd backend
mvn spring-boot:run
```
- Chạy trên: `http://localhost:8081`
- API docs: `http://localhost:8081/api/products`

### 2. **Ngrok (Cho mobile testing)**
```bash
ngrok http 8081
```
- Public URL: `https://impetrative-jenelle-rightly.ngrok-free.dev`
- WebSocket: `wss://impetrative-jenelle-rightly.ngrok-free.dev/ws`

### 3. **Flutter Mobile App**
```bash
cd t2k_coffee_mobile
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run
```

### 4. **Web Interface**
- Mở trình duyệt: `http://localhost:8080`
- Admin: `http://localhost:8080/admin/dashboard.html`
- Staff: `http://localhost:8080/staff/dashboard.html`
- Customer: `http://localhost:8080/index.html`

## 🧪 **Tài khoản test:**

| Role | Username | Password |
|------|----------|----------|
| Admin | `admin` | `admin123` |
| Staff | `staff` | `staff123` |
| Customer | `customer` | `customer123` |

## 🎯 **Test Flow:**

### **Customer Flow:**
1. Đăng nhập với `customer` / `customer123`
2. Xem menu và thêm sản phẩm vào giỏ
3. Chọn size, đá, đường, topping
4. Thanh toán (mang đi/tại chỗ)
5. Theo dõi trạng thái đơn hàng

### **Staff Flow:**
1. Đăng nhập với `staff` / `staff123`
2. Xem dashboard và nhận thông báo đơn hàng mới
3. Cập nhật trạng thái: Processing → Preparing → Ready → Completed
4. Quản lý đơn hàng theo tab

### **Admin Flow:**
1. Đăng nhập với `admin` / `admin123`
2. Xem tổng quan hệ thống
3. Quản lý sản phẩm, nhân viên, báo cáo

## 🔧 **Troubleshooting:**

### **API không kết nối được:**
```bash
# Test API
curl -H "ngrok-skip-browser-warning: true" https://impetrative-jenelle-rightly.ngrok-free.dev/api/products
```

### **Mobile app lỗi:**
```bash
cd t2k_coffee_mobile
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### **WebSocket không hoạt động:**
- Kiểm tra ngrok tunnel: `http://localhost:4040`
- Restart ngrok nếu cần

## 📱 **Mobile App Features:**
- ✅ Đăng nhập/đăng ký
- ✅ Xem menu theo danh mục
- ✅ Thêm sản phẩm vào giỏ với variants
- ✅ Thanh toán (mang đi/tại chỗ)
- ✅ Theo dõi đơn hàng realtime
- ✅ Lịch sử đơn hàng
- ✅ WebSocket notifications
- ✅ Speech notifications (staff)

## 🌐 **Web Features:**
- ✅ Admin dashboard với thống kê
- ✅ Staff dashboard với quản lý đơn hàng
- ✅ Customer interface với menu
- ✅ Real-time order updates
- ✅ File upload cho hình ảnh

## 🎉 **Hệ thống hoàn chỉnh:**
- ✅ Backend API (Spring Boot + MySQL)
- ✅ Frontend Web (HTML/CSS/JS)
- ✅ Mobile App (Flutter)
- ✅ WebSocket realtime
- ✅ Ngrok tunnel
- ✅ Authentication & Authorization
- ✅ File upload
- ✅ Speech notifications

**Chúc bạn test thành công! 🎯**
