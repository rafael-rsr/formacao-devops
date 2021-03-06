FROM ubuntu

# LABEL inserir metadatas
LABEL MAINTAINER="Rafael Rodrigues"
LABEL APP_VERSION="1.0.0"

# ENV enviar variaveis de ambiente"
ENV NPM_VERSION=8 ENVIRONTMENT=PROD

# RUN comando de execução de comandos
RUN apt-get update && apt-get install -y git nano npm

# WORKDIR comando para informar em qual diretorio trabalhar
WORKDIR /usr/share/myapp

RUN npm build

# COPY origem destino
COPY ./file.txt file.txt

# ADD origem destino (pode ser usado para descompactar aqruivos)
ADD ./file.tar.gz ./ 

RUN useradd rafael

# USER para definir o usuario padrão do container
USER rafael

# EXPOSE para expor portas do nosso container
EXPOSE 8080

# ENTRYPOINT executa comando padrão dentro da imagem sem a opção de alterar (--entrypoint para alterar o comando)
ENTRYPOINT [ "ping" ]

# CMD executa comando ou parametro padrão com a opção de alteração
CMD [ "localhost" ]