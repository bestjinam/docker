#!/bin/bash
set -e

# Set privileges
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
chmod 777 /var/run/mysqld

# Start MariaDB server
mysqld --user=root &

max_attempts=60  # 최대 시도 횟수 설정
attempt=1
wait_time=1

# Wait for MariaDB to start (limited to max_attempts)
until mysqladmin ping -hlocalhost -uroot > /dev/null 2>&1 || [ $attempt -ge $max_attempts ]; do
    echo "Waiting for MariaDB to start (Attempt $attempt)..."
    sleep $wait_time
    attempt=$((attempt + 1))
done

if [ $attempt -ge $max_attempts ]; then
    echo "MariaDB did not start within the specified time. Exiting."
    exit 1
fi

# Execute initialization commands
mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
EOF

# Start the actual MariaDB instance
exec mysqld --user=mysql

