@echo off
title 开发环境控制面板

:act_main
cls
echo ----------------------------
echo.
echo 1、启动全部服务
echo 2、停止全部服务
echo.
echo 3、重启单个服务
echo 4、停止单个服务
echo.
echo 5、PHP 5.4 版本
echo 6、PHP 7.0 版本
echo 7、其他
echo.
echo 按 Q 键退出
echo.
echo ----------------------------
echo.

choice /c:1234567q /n /m "请输入命令："

if %errorlevel% EQU 1 goto start_all_php56
if %errorlevel% EQU 2 goto stop_all
if %errorlevel% EQU 3 goto restart_one
if %errorlevel% EQU 4 goto stop_one
if %errorlevel% EQU 5 goto start_all_php54
if %errorlevel% EQU 6 goto start_all_php70
if %errorlevel% EQU 7 goto other
if %errorlevel% EQU 8 goto act_exit

:act_exit
exit
goto :eof

:restart_one
echo ----------------------------
echo.
echo 1、重启 Nginx
echo 2、重启 PHP 5.6
echo 3、重启 MySQL
echo 4、重启 PHP 5.4
echo 5、重启 PHP 7.0
echo 6、返回
echo.
echo 按 Q 键退出
echo.
echo ----------------------------

choice /c:123456q /n /m "请输入命令："

if %errorlevel% EQU 1 goto restart_nginx
if %errorlevel% EQU 2 goto restart_php56
if %errorlevel% EQU 3 goto restart_mysql
if %errorlevel% EQU 4 goto restart_php54
if %errorlevel% EQU 5 goto restart_php70
if %errorlevel% EQU 6 goto act_main
if %errorlevel% EQU 7 goto act_exit

:stop_one
echo ----------------------------
echo.
echo 1、停止 Nginx
echo 2、停止 PHP
echo 3、停止 MySQL
echo 4、返回
echo.
echo 按 Q 键退出
echo.
echo ----------------------------

choice /c:1234q /n /m "请输入命令："

if %errorlevel% EQU 1 goto stop_nginx
if %errorlevel% EQU 2 goto stop_php
if %errorlevel% EQU 3 goto stop_mysql
if %errorlevel% EQU 4 goto act_main
if %errorlevel% EQU 5 goto act_exit

:other
echo ----------------------------
echo.
echo 1、重启 Memcache
echo 2、重启 Redis
echo 3、重启 MongoDB
echo 4、停止 Memcache
echo 5、停止 Redis
echo 6、停止 MongoDB
echo 7、返回
echo.
echo 按 Q 键退出
echo.
echo ----------------------------

choice /c:1234567q /n /m "请输入命令："

if %errorlevel% EQU 1 goto restart_memcache
if %errorlevel% EQU 2 goto restart_redis
if %errorlevel% EQU 3 goto restart_mongodb
if %errorlevel% EQU 4 goto stop_memcache
if %errorlevel% EQU 5 goto stop_redis
if %errorlevel% EQU 6 goto stop_mongodb
if %errorlevel% EQU 7 goto act_main
if %errorlevel% EQU 8 goto act_exit

ram ---------- 全部启动 PHP 5.6 -------------

:start_all_php56
cls
set "act_type=1"
set "php_version=56"
goto start_nginx

ram ---------- 全部启动 PHP 5.4 -------------

:start_all_php54
cls
set "act_type=1"
set "php_version=54"
goto start_nginx

ram ---------- 全部启动 PHP 7.0 -------------

:start_all_php70
cls
set "act_type=1"
set "php_version=70"
goto start_nginx

ram ---------- 全部停止 -------------

:stop_all
cls
set "act_type=1"
goto stop_nginx

ram ---------- 重启 Nginx -------------

:restart_nginx
tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

echo Nginx 服务正在重启 .

if "%nginx_status%" == "1" (
    taskkill /F /IM nginx.exe > nul
)

tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

if "%nginx_status%" == "1" (
    echo Nginx 服务重启失败。
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\Nginx\nginx.exe -p %~dp0\Nginx
)

tasklist | find /i "nginx.exe" > Nul && echo Nginx 服务已经重启成功。 || echo Nginx 服务重启失败。

goto restart_one

ram ---------- 重启 PHP 5.6 -------------

:restart_php56
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

echo PHP FastCGI 服务正在重启 .

if "%php_status%" == "1" (
    taskkill /F /IM xxfpm.exe > nul
)

tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI 服务重启失败。
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.6\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务已经重启成功。 || echo PHP FastCGI 服务重启失败。
)

goto restart_one

ram ---------- 重启 MaraiDB -------------

:restart_mysql
net start | find /i "MariaDB" > Nul && set "mariadb_status=1" || set "mariadb_status=0"

if "%mariadb_status%" == "1" (
    net stop MariaDB
)

net start MariaDB

goto restart_one

ram ---------- 重启 PHP 5.4 -------------

:restart_php54
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

echo PHP FastCGI 服务正在重启 .

if "%php_status%" == "1" (
    taskkill /F /IM xxfpm.exe > nul
)

tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI 服务重启失败。
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.4\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务已经重启成功。 || echo PHP FastCGI 服务重启失败。
)

goto restart_one

ram ---------- 重启 PHP 7.0 -------------

:restart_php70
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

echo PHP FastCGI 服务正在重启 .

if "%php_status%" == "1" (
    taskkill /F /IM xxfpm.exe > nul
)

tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI 服务重启失败。
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 7.0\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务已经重启成功。 || echo PHP FastCGI 服务重启失败。
)

goto restart_one

ram ---------- 启动 Nginx -------------

:start_nginx
tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

if "%nginx_status%" == "1" (
    echo Nginx 服务已启动
) else (
    echo Nginx 服务正在启动 .
    %~dp0\RunHiddenConsole.exe %~dp0\Nginx\nginx.exe -p %~dp0\Nginx
    tasklist | find /i "nginx.exe" > Nul && echo Nginx 服务已经启动成功。 || echo Nginx 服务启动失败。
)

echo.

if "%act_type%" == "1" (
    if "%php_version%" == "54" (
        goto start_php54
    )

    if "%php_version%" == "56" (
        goto start_php56
    )

    if "%php_version%" == "70" (
        goto start_php70
    )
)

goto start_one

ram ---------- 启动 PHP 5.4 FastCGI -------------

:start_php54
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI 服务已启动
) else (
    echo PHP FastCGI 服务正在启动 .
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.4\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务已经启动成功。 || echo PHP FastCGI 服务启动失败。
)

echo.

if "%act_type%" == "1" (
    goto start_mysql
)

goto start_one

ram ---------- 启动 PHP 5.6 FastCGI -------------

:start_php56
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI 服务已启动
) else (
    echo PHP FastCGI 服务正在启动 .
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.6\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务已经启动成功。 || echo PHP FastCGI 服务启动失败。
)

echo.

if "%act_type%" == "1" (
    goto start_mysql
)

goto start_one

ram ---------- 启动 PHP 7.0 FastCGI -------------

:start_php70
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI 服务已启动
) else (
    echo PHP FastCGI 服务正在启动 .
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 7.0\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务已经启动成功。 || echo PHP FastCGI 服务启动失败。
)

echo.

if "%act_type%" == "1" (
    goto start_mysql
)

goto start_one

ram ---------- 启动 MariaDB -------------

:start_mysql
net start | find /i "MariaDB" > Nul && set "mariadb_status=1" || set "mariadb_status=0"

if "%mariadb_status%" == "1" (
    echo MariaDB 服务已启动。
    echo.
) else (
    net start MariaDB
)

if "%act_type%" == "1" (
    exit
)

goto start_one

ram ---------- 停止 Nginx -------------

:stop_nginx
tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

if "%nginx_status%" == "1" (
    echo Nginx 服务正在停止 .
    taskkill /F /IM nginx.exe > nul
    tasklist | find /i "nginx.exe" > Nul && echo Nginx 服务停止失败。 || echo Nginx 服务已成功停止。
) else (
    echo 没有启动 Ngnix 服务。
)

echo.

if "%act_type%" == "1" (
    goto stop_php
)

goto stop_one

ram ---------- 停止 PHP FastCGI -------------

:stop_php
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"
if "%php_status%" == "1" (
    echo PHP FastCGI 服务正在停止 .
    taskkill /F /IM xxfpm.exe > nul
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI 服务停止失败。 || echo PHP FastCGI 服务已成功停止。
) else (
    echo 没有启动 PHP FastCGI 服务。
)

echo.

if "%act_type%" == "1" (
    goto stop_mysql
)

goto stop_one

ram ---------- 停止 MariaDB -------------

:stop_mysql
net start | find /i "MariaDB" > Nul && set "mariadb_status=1" || set "mariadb_status=0"

if "%mariadb_status%" == "1" (
    net stop MariaDB
) else (
    echo 没有启动 MariaDB 服务。
    echo.
)

if "%act_type%" == "1" (
    exit
)

goto stop_one

ram ---------- 重启 Memcache -------------

:restart_memcache
net start | find /i "memcached" > Nul && set "memcache_status=1" || set "memcache_status=0"

if "%memcache_status%" == "1" (
    net stop memcached
)

net start memcached

goto other

ram ---------- 重启 Redis -------------

:restart_redis
net start | find /i "Redis" > Nul && set "redis_status=1" || set "redis_status=0"

if "%redis_status%" == "1" (
    net stop Redis
)

net start Redis

goto other

ram ---------- 重启 MongoDB -------------

:restart_mongodb
net start | find /i "MongoDB" > Nul && set "mongodb_status=1" || set "mongodb_status=0"

if "%mongodb_status%" == "1" (
    net stop MongoDB
)

net start MongoDB

goto other

ram ---------- 停止 Memcache -------------

:stop_memcache
net start | find /i "memcached" > Nul && set "memcache_status=1" || set "memcache_status=0"

if "%memcache_status%" == "1" (
    net stop memcached
) else (
    echo 没有启动 Memcache 服务。
    echo.
)

goto other

ram ---------- 停止 Redis -------------

:stop_redis
net start | find /i "Redis" > Nul && set "redis_status=1" || set "redis_status=0"

if "%redis_status%" == "1" (
    net stop Redis
) else (
    echo 没有启动 Redis 服务。
    echo.
)

goto other

ram ---------- 停止 MongoDB -------------

:stop_mongodb
net start | find /i "MongoDB" > Nul && set "mongodb_status=1" || set "mongodb_status=0"

if "%mongodb_status%" == "1" (
    net stop MongoDB
) else (
    echo 没有启动 MongoDB 服务。
    echo.
)

goto other