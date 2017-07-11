# wnmp-server
Windows 下集成环境脚本，支持 Nginx, MariaDB, PHP, MongoDB, Redis, Memcached。支持 PHP 多版本切换。

# 安装和卸载
主目录默认为 D:/Server，MariaDB 和 MongoDB 需要自己去官网下载压缩包形式解压到对应目录下

MariaDB: https://mariadb.com/downloads/mariadb-tx
MongoDB: https://www.mongodb.com/download-center

如果需要更改主目录，需要相应修改 Nginx/conf/nginx.conf 里的路径。

管理员权限下执行 install.bat 进行服务安装，执行 uninstall.bat 进行服务卸载

# 使用
管理员权限下执行 server.bat
启动 Nginx 和 PHP 后，可以通过 http://info.lvh.me 查看 PHPINFO。  *.lvh.me 二级目录对应 Htdocs 下子目录。
http://lvh.me:8899 可以访问 phpMyAdmin