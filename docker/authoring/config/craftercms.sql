use mysql;
CREATE DATABASE IF NOT EXISTS crafter DEFAULT CHARACTER SET utf8;
CREATE USER IF NOT EXISTS 'crafter'@'localhost' IDENTIFIED BY 'crafter';
GRANT ALL ON crafter.* TO 'crafter'@'localhost';
FLUSH PRIVILEGES;
