\# Reto Técnico DevOps - AWS, Terraform, Docker, PostgreSQL



\## 🔍 Descripción General

Este reto técnico despliega una infraestructura en AWS utilizando Terraform. La solución incluye:



\- Una instancia EC2 con Ubuntu 22.04, configurada para ejecutar contenedores Docker

\- Una instancia RDS de PostgreSQL

\- Una imagen Docker personalizada publicada en DockerHub con Git, Java, Maven, cliente de PostgreSQL, Apache, etc.

\- Un contenedor Docker que muestra un "Hola Mundo" a través de Apache

\- Acceso SSH con reglas de seguridad restringidas



---



\## 🚀 Servicios Utilizados



| Servicio AWS      | Propósito                                      |

|-------------------|------------------------------------------------|

| EC2               | Servidor Ubuntu ejecutando Docker              |

| RDS PostgreSQL    | Base de datos PostgreSQL gestionada por AWS   |

| Security Groups   | Control de acceso para SSH y PostgreSQL       |

| DockerHub         | Almacenamiento de la imagen Docker personalizada |

| Terraform         | Infraestructura como código                    |



---



\## 🛠️ Justificación de Elecciones



\- \*\*EC2\*\*: se eligió por su flexibilidad, control total y soporte nativo para Docker  

\- \*\*RDS PostgreSQL\*\*: base de datos robusta, escalable y totalmente gestionada por AWS  

\- \*\*Docker\*\*: permite reproducibilidad y portabilidad en entornos DevOps  

\- \*\*Terraform\*\*: herramienta declarativa para infraestructura versionada y consistente  



---



\## 🚫 Acceso Seguro



\- SSH habilitado solo desde una IP pública específica  

\- PostgreSQL accesible únicamente desde el Security Group de la EC2  



---



\## 🧭 Acceso por SSH



Ejecuta este comando desde tu terminal, reemplazando la IP por la dirección pública de tu instancia:



```bash

ssh -i aws\_key.pem ubuntu@<IP\_PUBLICA\_EC2>



Asegúrate de que el archivo aws\_key.pem exista en tu ruta local y tenga permisos restringidos:



```bash

chmod 400 aws\_key.pem



\##🏛️ Acceso a PostgreSQL

Desde la instancia EC2 (una vez conectado vía SSH), puedes probar la conexión:



```bash

psql -h <endpoint\_rds> -U postgreuser -d prueba-tecnica



Si la base de datos aún no existe, conéctate a postgres y créala manualmente:



```bash

psql -h <endpoint\_rds> -U postgreuser -d postgres

CREATE DATABASE "prueba-tecnica";



Reemplaza <endpoint\_rds> por el valor que aparece en AWS RDS → Instancia → Conectividad



\##🚀 Imagen Docker y Contenedor

Imagen: samueljb1/dev-image



Construcción y publicación:



```bash

docker build -t samueljb1/dev-image .

docker push samueljb1/dev-image



Ejecución en EC2:



```bash

docker run -d -p 80:80 --name dev-container samueljb1/dev-image



Accede desde el navegador:http://3.93.173.53/



⚖️ Terraform - Archivos Principales

main.tf: Define EC2, RDS, Security Groups, Key Pair



terraform.tfstate: Almacena el estado actual de la infraestructura



terraform.lock.hcl: Bloquea versiones exactas de proveedores para consistencia



Ejecución:



```bash

terraform init

terraform apply

Para destruir la infraestructura:



```bash

terraform destroy



El archivo terraform.tfstate puede almacenarse localmente o en remoto (S3). En este caso, se usa de forma local.



✨ Funcionalidades Extra (Plus)

Imagen Docker personalizada con:



Git



Maven



Java JRE 17



Cliente de PostgreSQL



Apache con mensaje Hola Mundo



Preparada para compilar aplicaciones .NET y Java



Conectividad verificada entre EC2 ↔ RDS



Documentación clara y profesional para facilitar la evaluación



📚 Requisitos Cumplidos

&nbsp;Infraestructura como código con Terraform



&nbsp;EC2 ejecutando contenedor con Apache y Hola Mundo



&nbsp;Imagen Docker publicada y funcional



&nbsp;RDS PostgreSQL con acceso privado desde EC2



&nbsp;Conexión EC2 → RDS verificada



&nbsp;Acceso seguro y documentado



&nbsp;Explicación del uso del state file y terraform.lock.hcl

