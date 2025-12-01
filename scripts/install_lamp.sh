# Documento realizado por Agustín Rubí Hernández

#!/bin/bash

# -x = Muestra los comandos ejecutados y su salida 
# -e = Detiene la ejecución tras un error
set -ex

#Actualizar los repositorios
apt update 

# Actualizamos los paquetes
apt upgrade -y

# Instalamos el servidor web Apache
apt install apache2 -y

# Instalamos PHP
apt install php libapache2-mod-php php-mysql -y

# Instalamos módulos PHP adicionales recomendados para WordPress
apt install php-curl php-zip php-xml php-gd php-mbstring php-soap php-intl php-bcmath -y

# Reiniciamos el servicio de Apache
systemctl restart apache2

#Copiamos el archivo de configuración de Apache

cp ../conf/000-default.conf /etc/apache2/sites-available

# Habilitamos el moódulo rewrite
a2enmod rewrite

# Reiniciamos el servicio de Apache
systemctl restart apache2

# Copias el archivo de prueba PHP a /var/www/html
cp ../php/index.php /var/www/html

# Instalamos MySQL
apt install mysql-server -y