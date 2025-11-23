#!/bin/bash

# ===============================================================
# DEPLOY SCRIPT - EV CHARGING STATION SYSTEM
# ===============================================================
# Bash script để deploy hệ thống với Docker Compose
# ===============================================================

echo "========================================"
echo "EV CHARGING STATION - DOCKER DEPLOY"
echo "========================================"
echo ""

# Kiểm tra Docker
echo "[1/5] Kiểm tra Docker..."
if ! command -v docker &> /dev/null; then
    echo "❌ Docker chưa được cài đặt!"
    echo "Vui lòng cài đặt Docker từ: https://docs.docker.com/get-docker/"
    exit 1
fi
echo "✅ Docker đã cài đặt: $(docker --version)"

# Kiểm tra Docker Compose
echo "[2/5] Kiểm tra Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose chưa được cài đặt!"
    exit 1
fi
echo "✅ Docker Compose đã cài đặt: $(docker-compose --version)"

# Kiểm tra thư mục mysql-data
echo "[3/5] Kiểm tra thư mục database..."
if [ ! -d "mysql-data" ]; then
    echo "⚠️  Thư mục mysql-data chưa tồn tại, đang tạo..."
    mkdir -p mysql-data
    echo "✅ Đã tạo thư mục mysql-data"
    echo "💡 Nếu bạn có database hiện có, hãy copy dữ liệu vào thư mục này"
else
    echo "✅ Thư mục mysql-data đã tồn tại"
fi

# Build images
echo "[4/5] Build Docker images..."
echo "⏳ Đang build (có thể mất vài phút lần đầu)..."
docker-compose build --no-cache
if [ $? -ne 0 ]; then
    echo "❌ Build thất bại!"
    exit 1
fi
echo "✅ Build thành công!"

# Start services
echo "[5/5] Khởi động services..."
docker-compose up -d
if [ $? -ne 0 ]; then
    echo "❌ Khởi động thất bại!"
    exit 1
fi

echo ""
echo "========================================"
echo "✅ DEPLOY THÀNH CÔNG!"
echo "========================================"
echo ""
echo "📊 Services đang chạy:"
docker-compose ps
echo ""
echo "🌐 URLs:"
echo "  - Frontend:        http://localhost"
echo "  - API Gateway:     http://localhost:8080"
echo "  - Eureka:          http://localhost:8761"
echo "  - RabbitMQ UI:     http://localhost:15672 (guest/guest)"
echo ""
echo "📝 Lệnh hữu ích:"
echo "  - Xem logs:        docker-compose logs -f"
echo "  - Stop:            docker-compose down"
echo "  - Restart:         docker-compose restart"
echo ""
echo "⏳ Đợi 30-60 giây để tất cả services khởi động hoàn tất..."

