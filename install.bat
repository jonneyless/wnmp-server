@echo off

set "mariadb_folder=%~dp0\MariaDB\data"
set "mongodb_folder=%~dp0\MongoDB"

sc GetDisplayName MariaDB > nul

if %errorlevel% EQU 1060 (
    echo "正在安装 MariaDB 服务..."
    %~dp0\MariaDB\bin\mysql_install_db.exe --datadir=%mariadb_folder% --service=MariaDB --password=root > nul
    sc config MariaDB start=demand > nul
    echo "MariaDB 服务安装完成"
    echo.
)

sc GetDisplayName memcached > nul

if %errorlevel% EQU 1060 (
    echo "正在安装 Memcached 服务..."
	%~dp0\Memcached\memcached.exe -d install > nul
    sc config memcached start=demand > nul
    echo "Memcached 服务安装完成"
    echo.
)

sc GetDisplayName Redis > nul

if %errorlevel% EQU 1060 (
    echo "正在安装 Redis 服务..."
    %~dp0\Redis\redis-server.exe --service-install %~dp0\Redis\redis.windows.conf --loglevel verbose > nul
    sc config Redis start=demand > nul
    echo "Redis 服务安装完成"
    echo.
)

sc GetDisplayName MongoDB > nul

if %errorlevel% EQU 1060 (
    echo "正在安装 MongoDB 服务..."
    %~dp0\MongoDB\bin\mongod.exe --logpath %mongodb_folder%\logs\mongodb.log --logappend --dbpath %mongodb_folder%\data --directoryperdb --serviceName MongoDB --install > nul
    sc config MongoDB start=demand > nul
    echo "MongoDB 服务安装完成"
    echo.
)

pause