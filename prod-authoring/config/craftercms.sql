use mysql;
CREATE DATABASE crafter DEFAULT CHARACTER SET utf8;
CREATE USER 'crafter'@'localhost' IDENTIFIED BY 'crafter';
GRANT ALL ON crafter.* TO 'crafter'@'localhost';
FLUSH PRIVILEGES;
