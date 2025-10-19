#!/bin/bash

set -e

if [ ! -e /etc/.firstrun ]; then
    cat << EOF >> /etc/my.cnf.d/mariadb-server.cnf
[mysqld]
skip-networking=0
EOF
    touch /etc/.firstrun
fi

if [ ! -e /var/lib/mysql/.firstmount ]; then

    mysql_install_db --datadir=/var/lib/mysql --skip-test-db --user=mysql --group=mysql \
        --auth-root-authentication-method=socket >/dev/null 2>/dev/null
    mysqld_safe &

    mysqladmin ping -u root --silent --wait >/dev/null 2>/dev/null

cat << EOF | mysql --protocol=socket -u root -p=
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_pass)';
FLUSH PRIVILEGES;

CREATE DATABASE $wordpress;
CREATE USER '$wp_user'@'%' IDENTIFIED BY '$(cat /run/secrets/db_user_pass)';
GRANT ALL PRIVILEGES ON $wordpress.* TO '$wp_user'@'%';
FLUSH PRIVILEGES;
EOF

    mysqladmin -p$(cat /run/secrets/db_root_pass) shutdown

    touch /var/lib/mysql/.firstmount

fi

exec mysqld_safe
