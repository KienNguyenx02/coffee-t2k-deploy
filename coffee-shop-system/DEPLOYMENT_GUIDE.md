# T2K Coffee System - Deployment Guide

Hướng dẫn deploy hệ thống T2K Coffee bao gồm Backend Spring Boot, Frontend Web và Mobile App.

## 🏗 Kiến trúc hệ thống

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Mobile App    │    │   Web Frontend  │    │  Spring Boot    │
│   (Flutter)     │    │   (HTML/JS)     │    │    Backend      │
│                 │    │                 │    │                 │
│ Port: N/A       │    │ Port: 8080      │    │ Port: 8081      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   MySQL Database│
                    │   Port: 3306    │
                    └─────────────────┘
```

## 🚀 Deployment Steps

### 1. Backend Deployment (Spring Boot)

#### Prerequisites
- Java 17+
- Maven 3.6+
- MySQL 8.0+

#### Database Setup
```sql
-- Create database
CREATE DATABASE coffee_t2k CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create user (optional)
CREATE USER 'coffee_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON coffee_t2k.* TO 'coffee_user'@'localhost';
FLUSH PRIVILEGES;
```

#### Application Configuration
Update `application.properties`:
```properties
# Database
spring.datasource.url=jdbc:mysql://localhost:3306/coffee_t2k
spring.datasource.username=coffee_user
spring.datasource.password=your_password

# Server
server.port=8081

# CORS (update with your domain)
spring.mvc.cors.allowed-origins=http://localhost:8080,https://yourdomain.com

# File upload
app.upload.dir=/var/uploads/images
```

#### Build and Run
```bash
cd backend
mvn clean package
java -jar target/coffee-t2k-0.0.1-SNAPSHOT.jar
```

#### Production Deployment
```bash
# Create systemd service
sudo nano /etc/systemd/system/t2k-coffee.service
```

Service file content:
```ini
[Unit]
Description=T2K Coffee Backend
After=network.target

[Service]
Type=simple
User=coffee
WorkingDirectory=/opt/t2k-coffee
ExecStart=/usr/bin/java -jar coffee-t2k-0.0.1-SNAPSHOT.jar
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
# Enable and start service
sudo systemctl enable t2k-coffee
sudo systemctl start t2k-coffee
sudo systemctl status t2k-coffee
```

### 2. Frontend Web Deployment

#### Prerequisites
- Web server (Apache/Nginx)
- Node.js (for build tools)

#### Build and Deploy
```bash
cd frontend
# Copy files to web server directory
sudo cp -r * /var/www/html/
```

#### Nginx Configuration
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        proxy_pass http://localhost:8081;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /uploads {
        proxy_pass http://localhost:8081;
    }
}
```

### 3. Mobile App Deployment

#### Android APK
```bash
cd t2k_coffee_mobile
flutter build apk --release
```

#### Android App Bundle (Google Play)
```bash
flutter build appbundle --release
```

#### iOS App (App Store)
```bash
flutter build ios --release
# Then archive in Xcode
```

## 🔧 Configuration

### Environment Variables
Create `.env` file for production:
```env
# Database
DB_HOST=localhost
DB_PORT=3306
DB_NAME=coffee_t2k
DB_USER=coffee_user
DB_PASSWORD=your_secure_password

# JWT
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRATION=86400000

# File Upload
UPLOAD_DIR=/var/uploads/images
MAX_FILE_SIZE=10485760

# CORS
ALLOWED_ORIGINS=http://localhost:8080,https://yourdomain.com
```

### SSL/HTTPS Setup
```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d yourdomain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

## 📱 Mobile App Configuration

### Update API URLs
In `lib/utils/api_config.dart`:
```dart
class ApiConfig {
  // Production URLs
  static const String productionBaseUrl = 'https://yourdomain.com/api';
  static const String productionWsUrl = 'wss://yourdomain.com/ws';
  
  // Use production for release builds
  static const bool useProduction = true;
  
  static String get baseUrl => useProduction ? productionBaseUrl : localBaseUrl;
  static String get wsUrl => useProduction ? productionWsUrl : localWsUrl;
}
```

### Build Configuration
Update `android/app/build.gradle`:
```gradle
android {
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.t2kcoffee.mobile"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode 1
        versionName "1.0.0"
    }
    
    signingConfigs {
        release {
            keyAlias 'your_key_alias'
            keyPassword 'your_key_password'
            storeFile file('your_keystore.jks')
            storePassword 'your_store_password'
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

## 🔍 Monitoring and Logs

### Backend Logs
```bash
# View logs
sudo journalctl -u t2k-coffee -f

# Log files
tail -f /opt/t2k-coffee/logs/application.log
```

### Database Monitoring
```sql
-- Check connections
SHOW PROCESSLIST;

-- Check database size
SELECT 
    table_schema AS 'Database',
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS 'Size (MB)'
FROM information_schema.tables 
WHERE table_schema = 'coffee_t2k'
GROUP BY table_schema;
```

### Mobile App Analytics
- Firebase Analytics
- Crashlytics
- Performance Monitoring

## 🚨 Troubleshooting

### Common Issues

#### Backend won't start
```bash
# Check Java version
java -version

# Check port availability
netstat -tulpn | grep 8081

# Check logs
sudo journalctl -u t2k-coffee --no-pager
```

#### Database connection issues
```bash
# Test MySQL connection
mysql -u coffee_user -p coffee_t2k

# Check MySQL status
sudo systemctl status mysql
```

#### Mobile app API errors
- Check API URLs in config
- Verify CORS settings
- Test API endpoints manually
- Check network connectivity

#### WebSocket connection issues
- Verify WebSocket endpoint
- Check firewall settings
- Test with WebSocket client tools

## 📊 Performance Optimization

### Backend
- Enable connection pooling
- Add caching (Redis)
- Optimize database queries
- Use CDN for static files

### Frontend
- Minify CSS/JS
- Enable gzip compression
- Optimize images
- Use lazy loading

### Mobile
- Optimize images
- Use efficient data structures
- Implement offline caching
- Minimize API calls

## 🔒 Security Checklist

- [ ] Use HTTPS everywhere
- [ ] Secure database credentials
- [ ] Enable CORS properly
- [ ] Validate all inputs
- [ ] Use JWT with expiration
- [ ] Implement rate limiting
- [ ] Regular security updates
- [ ] Backup database regularly

## 📈 Scaling

### Horizontal Scaling
- Load balancer (Nginx/HAProxy)
- Multiple backend instances
- Database replication
- CDN for static assets

### Vertical Scaling
- Increase server resources
- Optimize database performance
- Use connection pooling
- Implement caching

## 🔄 Backup Strategy

### Database Backup
```bash
# Daily backup script
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u coffee_user -p coffee_t2k > /backup/coffee_t2k_$DATE.sql
```

### File Backup
```bash
# Backup uploads
rsync -av /var/uploads/ /backup/uploads/
```

## 📞 Support

For deployment issues:
1. Check logs first
2. Verify configuration
3. Test connectivity
4. Check system resources
5. Review security settings
