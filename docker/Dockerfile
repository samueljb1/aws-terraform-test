FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    gnupg2 \
    software-properties-common \
    openjdk-17-jre \
    maven \
    postgresql \
    apache2 \
    unzip

# Instalación de .NET SDK 7.0 para compilar proyectos NetCore
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-7.0

# Copiar página web "Hola Mundo"
COPY index.html /var/www/html/index.html

# Puerto que exponemos para Apache
EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
