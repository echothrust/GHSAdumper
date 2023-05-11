CREATE DATABASE test;
CREATE DATABASE GHSA;

CREATE USER 'nosql'@'%' IDENTIFIED BY 'nosql';
GRANT ALL PRIVILEGES ON *.* TO 'nosql'@'%' WITH GRANT OPTION;

CREATE USER 'maxscale'@'%' IDENTIFIED BY 'maxscale_pw';
GRANT SELECT ON mysql.user TO 'maxscale'@'%';
GRANT SELECT ON mysql.db TO 'maxscale'@'%';
GRANT SELECT ON mysql.tables_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.columns_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.procs_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.proxies_priv TO 'maxscale'@'%';
GRANT SELECT ON mysql.roles_mapping TO 'maxscale'@'%';
GRANT SHOW DATABASES ON *.* TO 'maxscale'@'%';
GRANT SELECT ON mysql.* TO 'maxscale'@'%';

CREATE USER 'monitor_user'@'%' IDENTIFIED BY 'monitor_pw';
GRANT REPLICATION CLIENT, FILE, SUPER, RELOAD, PROCESS, SHOW DATABASES, EVENT ON *.* TO 'monitor_user'@'%';

CREATE USER 'service_user'@'%' IDENTIFIED BY 'service_pw';
GRANT SELECT ON mysql.user TO 'service_user'@'%';
GRANT SELECT ON mysql.db TO 'service_user'@'%';
GRANT SELECT ON mysql.tables_priv TO 'service_user'@'%';
GRANT SELECT ON mysql.columns_priv TO 'service_user'@'%';
GRANT SELECT ON mysql.procs_priv TO 'service_user'@'%';
GRANT SELECT ON mysql.proxies_priv TO 'service_user'@'%';
GRANT SELECT ON mysql.roles_mapping TO 'service_user'@'%';
GRANT SHOW DATABASES ON *.* TO 'service_user'@'%';

/* SET GLOBAL max_connections=10000; */
/* SET GLOBAL gtid_strict_mode=ON; */
