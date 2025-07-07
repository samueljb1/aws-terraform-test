# Reto Técnico DevOps - Terraform, Docker y AWS

## Descripción General

Este proyecto corresponde al desarrollo de un reto técnico orientado a la automatización de infraestructura y despliegue de aplicaciones utilizando herramientas DevOps. La solución fue implementada completamente en una cuenta gratuita de AWS y desplegada con Terraform desde cero, cumpliendo todos los requisitos solicitados.

El objetivo principal fue crear una infraestructura funcional y segura que incluya:

- Una instancia EC2 corriendo Ubuntu 22.04 configurada con Docker.
- Una base de datos PostgreSQL desplegada con Amazon RDS.
- Una imagen Docker personalizada, publicada en Docker Hub, con herramientas de desarrollo instaladas.
- Un contenedor ejecutando un servidor Apache que muestra una página “Hola Mundo”.
- Accesos restringidos mediante grupos de seguridad (Security Groups).
- Código de infraestructura escrito íntegramente con Terraform.

## Servicios Utilizados en AWS

| Servicio        | Descripción                                                                 |
|-----------------|------------------------------------------------------------------------------|
| EC2             | Instancia virtual basada en Ubuntu para ejecutar el contenedor Docker.      |
| RDS PostgreSQL  | Base de datos gestionada en AWS para la aplicación.                         |
| Security Groups | Reglas para limitar el acceso por IP y puertos (SSH y PostgreSQL).          |
| DockerHub       | Almacenamiento y distribución de la imagen Docker personalizada.            |
| Terraform       | Provisión automatizada de la infraestructura como código (IaC).             |

## Justificación de Elecciones

- **EC2**: Permite control total sobre el entorno y configuración del sistema operativo. Ideal para despliegues personalizados y pruebas.
- **RDS PostgreSQL**: Servicio gestionado que simplifica la administración de la base de datos, garantiza alta disponibilidad y respaldo.
- **Docker**: Facilita el empaquetado, despliegue y portabilidad de aplicaciones en múltiples entornos.
- **Terraform**: Herramienta declarativa confiable para mantener infraestructura reproducible y versionada.

## Seguridad y Acceso

- El acceso SSH está restringido a una IP pública específica mediante un Security Group.
- La base de datos en RDS solo es accesible desde la instancia EC2 a través de otro Security Group.
- La clave SSH (`aws_key.pem`) se generó localmente y se utilizó para el acceso seguro a la instancia EC2.

## Acceso por SSH a EC2

Para conectarse a la instancia EC2:

```bash
ssh -i aws_key.pem ubuntu@<IP_PUBLICA_EC2>
```

Asegúrate de tener el archivo `aws_key.pem` en tu máquina local y con los permisos adecuados:

```bash
chmod 400 aws_key.pem
```

## Acceso a PostgreSQL

Desde la instancia EC2 (una vez conectado por SSH), se puede conectar a la base de datos con el siguiente comando:

```bash
psql -h <endpoint_rds> -U postgreuser -d prueba-tecnica
```

En caso de que la base de datos aún no exista, conéctate a la base `postgres` y créala manualmente:

```bash
psql -h <endpoint_rds> -U postgreuser -d postgres
CREATE DATABASE "prueba-tecnica";
```

> El endpoint de RDS se encuentra en la consola de AWS, dentro de la sección "Conectividad" de la instancia creada.

## Imagen Docker y Contenedor

La imagen personalizada contiene múltiples herramientas preinstaladas:

- Git
- Java JRE 17
- Maven
- Cliente de PostgreSQL
- Apache HTTP Server
- Soporte para compilar proyectos Java y .NET Core

**Repositorio DockerHub**: `samueljb1/dev-image`

### Construcción y publicación:

```bash
docker build -t samueljb1/dev-image .
docker push samueljb1/dev-image
```

### Ejecución en EC2:

```bash
docker run -d -p 80:80 --name dev-container samueljb1/dev-image
```

Puedes verificar la aplicación accediendo desde el navegador a:

```
http://<IP_PUBLICA_EC2>
```

## Archivos Principales en Terraform

- `main.tf`: definición de todos los recursos de AWS (EC2, RDS, Security Groups, clave SSH).
- `terraform.tfstate`: archivo que almacena el estado actual de la infraestructura (almacenado localmente).
- `terraform.lock.hcl`: asegura que se utilicen versiones consistentes del proveedor `aws`.

### Instrucciones de ejecución

```bash
terraform init
terraform apply
```

Para eliminar toda la infraestructura creada:

```bash
terraform destroy
```

> El proyecto fue ejecutado manualmente desde una máquina local. No se utilizó un pipeline automatizado debido a limitaciones técnicas de acceso y compatibilidad de GitHub Actions con las credenciales de AWS. No obstante, se cuenta con una estructura preparada para integrar CI/CD como valor agregado si fuera requerido.

## Funcionalidades Adicionales

Además de los requisitos mínimos, el proyecto incluye:

- Imagen Docker multipropósito preparada para compilar proyectos Java y .NET.
- Documentación clara, con pasos detallados y ejemplos de uso.
- Configuración de red segura, limitando accesos a IPs específicas.
- Pruebas exitosas de conectividad entre EC2 y RDS.

## Requisitos Cumplidos

- [x] Infraestructura creada con Terraform.
- [x] EC2 corriendo contenedor Apache que muestra “Hola Mundo”.
- [x] Imagen Docker publicada en DockerHub.
- [x] Base de datos PostgreSQL creada en RDS.
- [x] Conectividad verificada entre EC2 y RDS.
- [x] Accesos configurados de forma segura (SSH y DB).
- [x] Documentación completa.

---

**Autor**: Samuel Blanco  
**Fecha de entrega**: Julio 2025  
**Cuenta de AWS usada**: Cuenta personal con plan gratuito (`free tier`)  
**Contacto**: samuel_jb1@hotmail.com
