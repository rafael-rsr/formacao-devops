# DESAFIO JENKINS

    Esse projeto é para realização do primeiro desafio Jenkins da formação DevOps.

# DESAFIO


  - Criar dockerfile em um repositorio no gitlab
  - criar um job no jenkins onde:
     - Tera que ter uma pipeline que toda vez que tiver commit, ira acionar o jenkins automaticamente, realizar o build, enviar para o dockerhub e apagar a imagem do docker na instancia Jenkins.



# EXECUÇÃO PROJETO

Foi necessário adicionar uma instancia com a o Jenkins e com o Docker. Criei tudo na mesma por conta do free tier da AWS.
(https://gitlab.com/rafaelrsr/desafiojenkins/-/blob/main/AWS_userdata)


Criei um job pipeline no Jenkins onde o mesmo clona o repositorio do GitLab, faz o build da imagem docker seguindo instruções do docker file , envia para o docker hub e limpa a imagem da instancia. 
(https://gitlab.com/rafaelrsr/desafiojenkins/-/blob/main/script)

Usei a configuração de webhook para automatizar toda vez que tem um merge na branch main ele informar o Jenkins que teve alteração e assim iniciar a pipeline.