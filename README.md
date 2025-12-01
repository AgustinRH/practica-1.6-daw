# Práctica 1.6: Despliegue de WordPress con WP-CLI

Este repositorio contiene los scripts y archivos de configuración necesarios para automatizar el despliegue de un sitio web WordPress sobre una pila LAMP (Linux, Apache, MySQL, PHP), incluyendo la configuración de certificados SSL con Let's Encrypt.

## 📋 Requisitos Previos

Antes de comenzar, asegúrate de tener:
- Un servidor con Ubuntu (o distribución compatible).
- Acceso root o usuario con privilegios `sudo`.
- Un nombre de dominio apuntando a la IP de tu servidor.
- Los archivos de este repositorio.

## 📂 Estructura del Proyecto

```text
.
├── conf/                   # Archivos de configuración de Apache (000-default.conf)
├── htaccess/               # Archivos .htaccess para WordPress
├── images/                 # Imágenes para la documentación
├── php/                    # Scripts PHP de prueba
├── scripts/                # Scripts de automatización
│   ├── .env                # Variables de entorno
│   ├── deploy.sh           # Script principal de despliegue
│   ├── install_lamp.sh     # Instalación de la pila LAMP
│   └── setup_letsencrypt_certificate.sh # Configuración de HTTPS
└── README.md               # Documentación del proyecto
```

## 🚀 Instalación y Uso

Sigue estos pasos para desplegar tu sitio WordPress:

### 1. Preparación del Entorno

Primero, asegúrate de que los scripts tienen permisos de ejecución:

```bash
chmod +x scripts/*.sh
```

### 2. Instalación de Dependencias

Ejecuta los scripts para instalar la pila LAMP y configurar el certificado SSL:

```bash
cd scripts
sudo ./install_lamp.sh
sudo ./setup_letsencrypt_certificate.sh
```

### 3. Configuración

Edita el archivo `.env` ubicado en la carpeta `scripts` con tus propios datos. Este archivo controla la configuración de la base de datos y de WordPress.

```bash
nano .env
```

Asegúrate de definir las siguientes variables clave:
- `CERTBOT_DOMAIN`: Tu dominio (ej. `agustinrubi.servebeer.com`).
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`: Credenciales de la base de datos.
- `WORDPRESS_ADMIN_*`: Credenciales para el administrador de WordPress.

### 4. Configuración de Apache

Copia o modifica el archivo de configuración de Apache si es necesario. El archivo `conf/000-default.conf` contiene una configuración base.

```bash
# Ejemplo de configuración de VirtualHost
<VirtualHost *:80>
    ServerName TU_DOMINIO
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>
    # ... logs ...
</VirtualHost>
```

### 5. Despliegue de WordPress

Ejecuta el script de despliegue. Este script descargará WordPress, configurará la base de datos y realizará la instalación utilizando WP-CLI:

```bash
sudo ./deploy.sh
```

El script realizará las siguientes acciones automáticamente:
- Instalar WP-CLI.
- Descargar el núcleo de WordPress en español.
- Crear la base de datos y usuario MySQL.
- Instalar WordPress y configurar el usuario administrador.
- Configurar permisos y copiar el archivo `.htaccess`.

## 🌐 Acceso

Una vez finalizado el despliegue, podrás acceder a tu sitio web:

- **Sitio público**: `https://tu-dominio.com`
- **Panel de administración**: `https://tu-dominio.com/wp-admin`

![Vista previa del sitio](/images/pagina-wordpress-home.png)

## 🛠️ Detalles Técnicos

### Archivo .htaccess
El archivo `.htaccess` se copia automáticamente desde la carpeta `htaccess/` para asegurar el correcto funcionamiento de las URLs amigables (Permalinks) de WordPress.

### WP-CLI
Este proyecto hace uso extensivo de [WP-CLI](https://wp-cli.org/), la interfaz de línea de comandos para WordPress, permitiendo una instalación desatendida y rápida.

---
**Autor:** Agustín Rubí Hernández