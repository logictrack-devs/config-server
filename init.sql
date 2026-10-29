-- Creamos las 3 bases de datos independientes
CREATE DATABASE IF NOT EXISTS logitrack_security;
CREATE DATABASE IF NOT EXISTS logitrack_courier;
CREATE DATABASE IF NOT EXISTS logitrack_shipment;

-- Creamos los usuarios y asignamos permisos por cada base de datos
CREATE USER IF NOT EXISTS 'security_user'@'%' IDENTIFIED BY 'security_pass';
GRANT ALL PRIVILEGES ON logitrack_security.* TO 'security_user'@'%';

CREATE USER IF NOT EXISTS 'shipment_user'@'%' IDENTIFIED BY 'shipment_pass';
GRANT ALL PRIVILEGES ON logitrack_shipment.* TO 'shipment_user'@'%';

CREATE USER IF NOT EXISTS 'courier_user'@'%' IDENTIFIED BY 'courier_pass';
GRANT ALL PRIVILEGES ON logitrack_courier.* TO 'courier_user'@'%';

FLUSH PRIVILEGES;