# ===============================================================
# DEPLOY SCRIPT - EV CHARGING STATION SYSTEM
# ===============================================================
# PowerShell script để deploy hệ thống với Docker Compose
# ===============================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "EV CHARGING STATION - DOCKER DEPLOY" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Kiểm tra Docker
Write-Host "[1/5] Kiểm tra Docker..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version
    Write-Host "✅ Docker đã cài đặt: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker chưa được cài đặt!" -ForegroundColor Red
    Write-Host "Vui lòng cài đặt Docker Desktop từ: https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
    exit 1
}

# Kiểm tra Docker Compose
Write-Host "[2/5] Kiểm tra Docker Compose..." -ForegroundColor Yellow
try {
    $composeVersion = docker-compose --version
    Write-Host "✅ Docker Compose đã cài đặt: $composeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker Compose chưa được cài đặt!" -ForegroundColor Red
    exit 1
}

# Kiểm tra thư mục mysql-data
Write-Host "[3/5] Kiểm tra thư mục database..." -ForegroundColor Yellow
if (-Not (Test-Path "mysql-data")) {
    Write-Host "⚠️  Thư mục mysql-data chưa tồn tại, đang tạo..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path "mysql-data" | Out-Null
    Write-Host "✅ Đã tạo thư mục mysql-data" -ForegroundColor Green
    Write-Host "💡 Nếu bạn có database hiện có, hãy copy dữ liệu vào thư mục này" -ForegroundColor Cyan
} else {
    Write-Host "✅ Thư mục mysql-data đã tồn tại" -ForegroundColor Green
}

# Build images
Write-Host "[4/5] Build Docker images..." -ForegroundColor Yellow
Write-Host "⏳ Đang build (có thể mất vài phút lần đầu)..." -ForegroundColor Cyan
docker-compose build --no-cache
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build thất bại!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Build thành công!" -ForegroundColor Green

# Start services
Write-Host "[5/5] Khởi động services..." -ForegroundColor Yellow
docker-compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Khởi động thất bại!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✅ DEPLOY THÀNH CÔNG!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Services đang chạy:" -ForegroundColor Cyan
docker-compose ps
Write-Host ""
Write-Host "🌐 URLs:" -ForegroundColor Cyan
Write-Host "  - Frontend:        http://localhost" -ForegroundColor White
Write-Host "  - API Gateway:     http://localhost:8080" -ForegroundColor White
Write-Host "  - Eureka:          http://localhost:8761" -ForegroundColor White
Write-Host "  - RabbitMQ UI:     http://localhost:15672 (guest/guest)" -ForegroundColor White
Write-Host ""
Write-Host "📝 Lệnh hữu ích:" -ForegroundColor Cyan
Write-Host "  - Xem logs:        docker-compose logs -f" -ForegroundColor White
Write-Host "  - Stop:            docker-compose down" -ForegroundColor White
Write-Host "  - Restart:         docker-compose restart" -ForegroundColor White
Write-Host ""
Write-Host "⏳ Đợi 30-60 giây để tất cả services khởi động hoàn tất..." -ForegroundColor Yellow

