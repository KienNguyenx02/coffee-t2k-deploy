# T2K Coffee Mobile App

Ứng dụng mobile cho hệ thống quản lý quán cà phê T2K Coffee, hỗ trợ khách hàng đặt món và nhân viên pha chế quản lý đơn hàng realtime.

## 🚀 Tính năng chính

### 👥 Khách hàng
- **Menu tương tác**: Xem danh sách sản phẩm theo danh mục
- **Giỏ hàng thông minh**: Thêm món với tùy chọn size, đá, đường, topping
- **Đặt hàng linh hoạt**: Chọn mang đi hoặc tại chỗ với bàn cụ thể
- **Thanh toán đa dạng**: Tiền mặt hoặc chuyển khoản
- **Theo dõi đơn hàng**: Xem trạng thái đơn hàng realtime
- **Hồ sơ cá nhân**: Quản lý thông tin và điểm thưởng

### ☕ Nhân viên pha chế
- **Dashboard realtime**: Xem tổng quan đơn hàng theo trạng thái
- **Quản lý đơn hàng**: Cập nhật trạng thái từ "Mới" → "Chế biến" → "Sẵn sàng" → "Hoàn thành"
- **Thông báo âm thanh**: Phát âm thanh khi có đơn hàng mới
- **WebSocket realtime**: Nhận thông báo đơn hàng mới ngay lập tức
- **Quản lý bàn**: Xem trạng thái bàn và đơn hàng tại chỗ

## 🛠 Công nghệ sử dụng

- **Frontend**: Flutter 3.16+ (Dart)
- **State Management**: Provider
- **Navigation**: GoRouter
- **HTTP Client**: http package
- **WebSocket**: web_socket_channel
- **Speech**: flutter_tts, speech_to_text
- **Local Storage**: shared_preferences
- **Image Loading**: cached_network_image
- **JSON Serialization**: json_annotation, build_runner

## 📱 Cài đặt và chạy

### Yêu cầu hệ thống
- Flutter SDK 3.16+
- Dart SDK 3.2+
- Android Studio / VS Code
- Android SDK (API 21+) hoặc iOS SDK (iOS 11+)

### Cài đặt dependencies
```bash
cd t2k_coffee_mobile
flutter pub get
```

### Generate code
```bash
flutter packages pub run build_runner build
```

### Chạy app
```bash
# Android
flutter run

# iOS
flutter run -d ios

# Web (for testing)
flutter run -d chrome
```

## 🔧 Cấu hình

### 1. Cấu hình API
Cập nhật URL trong `lib/utils/api_config.dart`:

```dart
// Local development
static const String localBaseUrl = 'http://localhost:8081';
static const String localWsUrl = 'ws://localhost:8081/ws';

// Ngrok (for mobile testing)
static const String ngrokBaseUrl = 'https://your-ngrok-url.ngrok.io';
static const String ngrokWsUrl = 'wss://your-ngrok-url.ngrok.io/ws';
```

### 2. Khởi động backend
```bash
cd ../backend
mvn spring-boot:run
```

### 3. Khởi động ngrok (cho mobile testing)
```bash
# Windows
.\start-ngrok.ps1

# Linux/Mac
./start-ngrok.sh
```

## 🧪 Test

### Tài khoản demo
- **Admin**: `admin` / `admin123`
- **Staff**: `staff` / `staff123`  
- **Customer**: `customer` / `customer123`

### Test flow khách hàng
1. Đăng nhập với tài khoản customer
2. Xem menu và thêm món vào giỏ hàng
3. Chọn tùy chọn (size, đá, đường, topping)
4. Đặt hàng (mang đi hoặc tại chỗ)
5. Chọn phương thức thanh toán
6. Xem đơn hàng thành công
7. Theo dõi trạng thái đơn hàng

### Test flow nhân viên
1. Đăng nhập với tài khoản staff
2. Xem dashboard với thống kê đơn hàng
3. Nhận thông báo đơn hàng mới (có âm thanh)
4. Cập nhật trạng thái đơn hàng
5. Quản lý đơn hàng theo tab

## 📱 Build APK

### Debug APK
```bash
flutter build apk --debug
```

### Release APK
```bash
flutter build apk --release
```

### App Bundle (Google Play)
```bash
flutter build appbundle --release
```

## 🔍 Troubleshooting

### Lỗi WebSocket connection
- Kiểm tra backend đã chạy trên port 8081
- Kiểm tra ngrok URL đã được cập nhật
- Kiểm tra firewall/antivirus

### Lỗi API connection
- Kiểm tra backend đang chạy
- Kiểm tra CORS configuration
- Kiểm tra network connectivity

### Lỗi speech/audio
- Kiểm tra quyền microphone
- Kiểm tra volume device
- Test trên device thật (không work trên emulator)

### Lỗi build
```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 📂 Cấu trúc project

```
lib/
├── main.dart                 # Entry point
├── models/                   # Data models
│   ├── user.dart
│   ├── product.dart
│   ├── order.dart
│   └── ...
├── services/                 # API & WebSocket services
│   ├── api_service.dart
│   ├── websocket_service.dart
│   └── speech_service.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── cart_provider.dart
│   └── staff_provider.dart
├── screens/                  # UI screens
│   ├── customer/
│   ├── staff/
│   └── auth/
├── widgets/                  # Reusable widgets
├── utils/                    # Utilities
└── assets/                   # Images, fonts
```

## 🚀 Deployment

### Android
1. Build release APK
2. Sign APK với keystore
3. Upload lên Google Play Console

### iOS
1. Build iOS app
2. Archive trong Xcode
3. Upload lên App Store Connect

## 📞 Support

Nếu gặp vấn đề, vui lòng:
1. Kiểm tra logs trong console
2. Kiểm tra network connectivity
3. Restart app và backend
4. Kiểm tra cấu hình ngrok

## 🔄 Updates

- **v1.0.0**: Initial release với basic features
- **v1.1.0**: Thêm WebSocket realtime
- **v1.2.0**: Thêm speech notifications
- **v1.3.0**: Cải thiện UI/UX