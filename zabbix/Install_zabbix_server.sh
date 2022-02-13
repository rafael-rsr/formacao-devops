# Suba uma instancia no RDS para ser o banco de dados e enquanto a instancia é inicializada faça as etapas seguintes

# Suba a instância no EC2 com t2.micro e 10gb armazenamento

# Faça o download do arquivo que irá instalar o repositório no ambiente
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb

# Vamos realizar a instalação do .deb para que assim tenhamos o repositório
sudo dpkg -i zabbix-release_5.0-1+focal_all.deb

# Vamos atualizar nossos repositórios
sudo apt update

# Vamos efetivamente instalar o Zabbix
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

# Dentro da instancia execute o comando abaixo adequanda-o ao seu ambiente
mysql -h <DB_ENDPOINT> -u<DB_USER> -p<DB_PASSWORD>

# Crie o banco de dados
create database zabbix character set utf8 collate utf8_bin;

# Saia do cli do MySQL
quit;

# No servidor do Zabbix, importe o esquema inicial e os dados.
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -h <DB_ENDPOINT> -u<DB_USER> -p<DB_PASSWORD> zabbix

# Editar arquivo /etc/zabbix/zabbix_server.conf
sudo nano /etc/zabbix/zabbix_server.conf

# Editar as informações abaixo conforme seu ambiente:
# ANTES | DEPOIS
DBUser=zabbix          | DBUser=<DB_USER>
# DBPassword=          | DBPassword=<DB_PASS>
# DBHost=localhost     | DBHost=<DB_HOST>

# Configure o PHP para o frontend Zabbix
sudo nano /etc/zabbix/apache.conf

# Editar as informações abaixo conforme seu ambiente:
# ANTES | DEPOIS
# php_value date.timezone Europe/Riga | php_value date.timezone America/Sao_Paulo

# Inicie o servidor Zabbix e os processos do agente
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl enable zabbix-server zabbix-agent apache2

# Agora acesse a interface web e faça a configuração do Frontend
http://SERVER_IP/zabbix

# Após tudo configurado acesse com o usuário "Admin" e a senha "zabbix"

# Altere a senha padrão por questões de segurança