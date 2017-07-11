@echo off

sc GetDisplayName MariaDB > nul

if %errorlevel% NEQ 1060 (
    echo "正在卸载 MariaDB 服务..."
    sc delete MariaDB > nul
    echo "MariaDB 服务卸载完成"
    echo.
)

sc GetDisplayName memcached > nul

if %errorlevel% NEQ 1060 (
    echo "正在卸载 Memcached 服务..."
    sc delete memcached > nul
    echo "Memcached 服务卸载完成"
    echo.
)

sc GetDisplayName Redis > nul

if %errorlevel% NEQ 1060 (
    echo "正在卸载 Redis 服务..."
    sc delete Redis > nul
    echo "Redis 服务卸载完成"
    echo.
)

sc GetDisplayName MongoDB > nul

if %errorlevel% NEQ 1060 (
    echo "正在卸载 MongoDB 服务..."
    sc delete MongoDB > nul
    echo "MongoDB 服务卸载完成"
    echo.
)

pause