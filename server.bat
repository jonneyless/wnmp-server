@echo off
title ���������������

:act_main
cls
echo ----------------------------
echo.
echo 1������ȫ������
echo 2��ֹͣȫ������
echo.
echo 3��������������
echo 4��ֹͣ��������
echo.
echo 5��PHP 5.4 �汾
echo 6��PHP 7.0 �汾
echo 7������
echo.
echo �� Q ���˳�
echo.
echo ----------------------------
echo.

choice /c:1234567q /n /m "���������"

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
echo 1������ Nginx
echo 2������ PHP 5.6
echo 3������ MySQL
echo 4������ PHP 5.4
echo 5������ PHP 7.0
echo 6������
echo.
echo �� Q ���˳�
echo.
echo ----------------------------

choice /c:123456q /n /m "���������"

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
echo 1��ֹͣ Nginx
echo 2��ֹͣ PHP
echo 3��ֹͣ MySQL
echo 4������
echo.
echo �� Q ���˳�
echo.
echo ----------------------------

choice /c:1234q /n /m "���������"

if %errorlevel% EQU 1 goto stop_nginx
if %errorlevel% EQU 2 goto stop_php
if %errorlevel% EQU 3 goto stop_mysql
if %errorlevel% EQU 4 goto act_main
if %errorlevel% EQU 5 goto act_exit

:other
echo ----------------------------
echo.
echo 1������ Memcache
echo 2������ Redis
echo 3������ MongoDB
echo 4��ֹͣ Memcache
echo 5��ֹͣ Redis
echo 6��ֹͣ MongoDB
echo 7������
echo.
echo �� Q ���˳�
echo.
echo ----------------------------

choice /c:1234567q /n /m "���������"

if %errorlevel% EQU 1 goto restart_memcache
if %errorlevel% EQU 2 goto restart_redis
if %errorlevel% EQU 3 goto restart_mongodb
if %errorlevel% EQU 4 goto stop_memcache
if %errorlevel% EQU 5 goto stop_redis
if %errorlevel% EQU 6 goto stop_mongodb
if %errorlevel% EQU 7 goto act_main
if %errorlevel% EQU 8 goto act_exit

ram ---------- ȫ������ PHP 5.6 -------------

:start_all_php56
cls
set "act_type=1"
set "php_version=56"
goto start_nginx

ram ---------- ȫ������ PHP 5.4 -------------

:start_all_php54
cls
set "act_type=1"
set "php_version=54"
goto start_nginx

ram ---------- ȫ������ PHP 7.0 -------------

:start_all_php70
cls
set "act_type=1"
set "php_version=70"
goto start_nginx

ram ---------- ȫ��ֹͣ -------------

:stop_all
cls
set "act_type=1"
goto stop_nginx

ram ---------- ���� Nginx -------------

:restart_nginx
tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

echo Nginx ������������ .

if "%nginx_status%" == "1" (
    taskkill /F /IM nginx.exe > nul
)

tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

if "%nginx_status%" == "1" (
    echo Nginx ��������ʧ�ܡ�
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\Nginx\nginx.exe -p %~dp0\Nginx
)

tasklist | find /i "nginx.exe" > Nul && echo Nginx �����Ѿ������ɹ��� || echo Nginx ��������ʧ�ܡ�

goto restart_one

ram ---------- ���� PHP 5.6 -------------

:restart_php56
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

echo PHP FastCGI ������������ .

if "%php_status%" == "1" (
    taskkill /F /IM xxfpm.exe > nul
)

tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI ��������ʧ�ܡ�
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.6\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI �����Ѿ������ɹ��� || echo PHP FastCGI ��������ʧ�ܡ�
)

goto restart_one

ram ---------- ���� MaraiDB -------------

:restart_mysql
net start | find /i "MariaDB" > Nul && set "mariadb_status=1" || set "mariadb_status=0"

if "%mariadb_status%" == "1" (
    net stop MariaDB
)

net start MariaDB

goto restart_one

ram ---------- ���� PHP 5.4 -------------

:restart_php54
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

echo PHP FastCGI ������������ .

if "%php_status%" == "1" (
    taskkill /F /IM xxfpm.exe > nul
)

tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI ��������ʧ�ܡ�
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.4\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI �����Ѿ������ɹ��� || echo PHP FastCGI ��������ʧ�ܡ�
)

goto restart_one

ram ---------- ���� PHP 7.0 -------------

:restart_php70
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

echo PHP FastCGI ������������ .

if "%php_status%" == "1" (
    taskkill /F /IM xxfpm.exe > nul
)

tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI ��������ʧ�ܡ�
) else (
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 7.0\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI �����Ѿ������ɹ��� || echo PHP FastCGI ��������ʧ�ܡ�
)

goto restart_one

ram ---------- ���� Nginx -------------

:start_nginx
tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

if "%nginx_status%" == "1" (
    echo Nginx ����������
) else (
    echo Nginx ������������ .
    %~dp0\RunHiddenConsole.exe %~dp0\Nginx\nginx.exe -p %~dp0\Nginx
    tasklist | find /i "nginx.exe" > Nul && echo Nginx �����Ѿ������ɹ��� || echo Nginx ��������ʧ�ܡ�
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

ram ---------- ���� PHP 5.4 FastCGI -------------

:start_php54
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI ����������
) else (
    echo PHP FastCGI ������������ .
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.4\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI �����Ѿ������ɹ��� || echo PHP FastCGI ��������ʧ�ܡ�
)

echo.

if "%act_type%" == "1" (
    goto start_mysql
)

goto start_one

ram ---------- ���� PHP 5.6 FastCGI -------------

:start_php56
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI ����������
) else (
    echo PHP FastCGI ������������ .
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 5.6\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI �����Ѿ������ɹ��� || echo PHP FastCGI ��������ʧ�ܡ�
)

echo.

if "%act_type%" == "1" (
    goto start_mysql
)

goto start_one

ram ---------- ���� PHP 7.0 FastCGI -------------

:start_php70
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"

if "%php_status%" == "1" (
    echo PHP FastCGI ����������
) else (
    echo PHP FastCGI ������������ .
    %~dp0\RunHiddenConsole.exe %~dp0\xxFpm\xxfpm.exe "%~dp0\PHP 7.0\php-cgi.exe" -n 3 -i 127.0.0.1 -p 9000
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI �����Ѿ������ɹ��� || echo PHP FastCGI ��������ʧ�ܡ�
)

echo.

if "%act_type%" == "1" (
    goto start_mysql
)

goto start_one

ram ---------- ���� MariaDB -------------

:start_mysql
net start | find /i "MariaDB" > Nul && set "mariadb_status=1" || set "mariadb_status=0"

if "%mariadb_status%" == "1" (
    echo MariaDB ������������
    echo.
) else (
    net start MariaDB
)

if "%act_type%" == "1" (
    exit
)

goto start_one

ram ---------- ֹͣ Nginx -------------

:stop_nginx
tasklist | find /i "nginx.exe" > Nul && set "nginx_status=1" || set "nginx_status=0"

if "%nginx_status%" == "1" (
    echo Nginx ��������ֹͣ .
    taskkill /F /IM nginx.exe > nul
    tasklist | find /i "nginx.exe" > Nul && echo Nginx ����ֹͣʧ�ܡ� || echo Nginx �����ѳɹ�ֹͣ��
) else (
    echo û������ Ngnix ����
)

echo.

if "%act_type%" == "1" (
    goto stop_php
)

goto stop_one

ram ---------- ֹͣ PHP FastCGI -------------

:stop_php
tasklist | find /i "xxfpm.exe" > Nul && set "php_status=1" || set "php_status=0"
if "%php_status%" == "1" (
    echo PHP FastCGI ��������ֹͣ .
    taskkill /F /IM xxfpm.exe > nul
    tasklist | find /i "xxfpm.exe" > Nul && echo PHP FastCGI ����ֹͣʧ�ܡ� || echo PHP FastCGI �����ѳɹ�ֹͣ��
) else (
    echo û������ PHP FastCGI ����
)

echo.

if "%act_type%" == "1" (
    goto stop_mysql
)

goto stop_one

ram ---------- ֹͣ MariaDB -------------

:stop_mysql
net start | find /i "MariaDB" > Nul && set "mariadb_status=1" || set "mariadb_status=0"

if "%mariadb_status%" == "1" (
    net stop MariaDB
) else (
    echo û������ MariaDB ����
    echo.
)

if "%act_type%" == "1" (
    exit
)

goto stop_one

ram ---------- ���� Memcache -------------

:restart_memcache
net start | find /i "memcached" > Nul && set "memcache_status=1" || set "memcache_status=0"

if "%memcache_status%" == "1" (
    net stop memcached
)

net start memcached

goto other

ram ---------- ���� Redis -------------

:restart_redis
net start | find /i "Redis" > Nul && set "redis_status=1" || set "redis_status=0"

if "%redis_status%" == "1" (
    net stop Redis
)

net start Redis

goto other

ram ---------- ���� MongoDB -------------

:restart_mongodb
net start | find /i "MongoDB" > Nul && set "mongodb_status=1" || set "mongodb_status=0"

if "%mongodb_status%" == "1" (
    net stop MongoDB
)

net start MongoDB

goto other

ram ---------- ֹͣ Memcache -------------

:stop_memcache
net start | find /i "memcached" > Nul && set "memcache_status=1" || set "memcache_status=0"

if "%memcache_status%" == "1" (
    net stop memcached
) else (
    echo û������ Memcache ����
    echo.
)

goto other

ram ---------- ֹͣ Redis -------------

:stop_redis
net start | find /i "Redis" > Nul && set "redis_status=1" || set "redis_status=0"

if "%redis_status%" == "1" (
    net stop Redis
) else (
    echo û������ Redis ����
    echo.
)

goto other

ram ---------- ֹͣ MongoDB -------------

:stop_mongodb
net start | find /i "MongoDB" > Nul && set "mongodb_status=1" || set "mongodb_status=0"

if "%mongodb_status%" == "1" (
    net stop MongoDB
) else (
    echo û������ MongoDB ����
    echo.
)

goto other