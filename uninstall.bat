@echo off

sc GetDisplayName MariaDB > nul

if %errorlevel% NEQ 1060 (
    echo "����ж�� MariaDB ����..."
    sc delete MariaDB > nul
    echo "MariaDB ����ж�����"
    echo.
)

sc GetDisplayName memcached > nul

if %errorlevel% NEQ 1060 (
    echo "����ж�� Memcached ����..."
    sc delete memcached > nul
    echo "Memcached ����ж�����"
    echo.
)

sc GetDisplayName Redis > nul

if %errorlevel% NEQ 1060 (
    echo "����ж�� Redis ����..."
    sc delete Redis > nul
    echo "Redis ����ж�����"
    echo.
)

sc GetDisplayName MongoDB > nul

if %errorlevel% NEQ 1060 (
    echo "����ж�� MongoDB ����..."
    sc delete MongoDB > nul
    echo "MongoDB ����ж�����"
    echo.
)

pause