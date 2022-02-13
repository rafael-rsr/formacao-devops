# Execute os comandos abaixo em sequencia para instalação do agent
wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb
sudo dpkg -i zabbix-release_5.0-1+focal_all.deb
sudo apt update
sudo apt install -y zabbix-agent

# Vamos editar as configurações do agente
sudo nano /etc/zabbix/zabbix_agentd.conf

# Procure pelos parametros abaixo e os substitua pelo valor correspondente
Server=127.0.0.1       # Substitua 127.0.0.1 pelo IP do seu Zabbix Server
ServerActive=127.0.0.1 # Substitua 127.0.0.1 pelo IP do seu Zabbix Server
Hostname=              # Define um nome para seu servidor a ser monitorado

sudo systemctl restart zabbix-agent
sudo systemctl enable zabbix-agent
sudo systemctl status zabbix-agent

# Agora faça o cadastro no Front do Zabbix

# Template a ser utilizado ao cadastrar na interface web.
Template: Template OS Linux by Zabbix agent