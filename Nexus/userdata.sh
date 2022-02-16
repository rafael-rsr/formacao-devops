#!/bin/bash

# Update System
apt-get update                                                                   # Update repository list
apt-get upgrade -y                                                               # Upgrade packages of the system for security reasons

# Install Dependencies
apt install -y openjdk-8-jre-headless                                            # Install Java 8 JRE

# Install Nexus
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz                    # Download latest version of Nexus
tar vzxf latest-unix.tar.gz                                                      # Extract Nexus files
VERSION="$(ls | grep nexus- | cut -d '-' -f 2,3)"                                # Define Nexus version
mv nexus-$VERSION /opt/                                                          # Move Nexus folder 1 to /opt
mv sonatype-work /opt/                                                           # Move Nexus folder 2 to /opt
rm -rf latest-unix.tar.gz                                                        # Remove compacted file

# Configure Nexus
adduser --no-create-home --disabled-password --disabled-login --gecos "" nexus   # Create a user to run Nexus
chown -R nexus. /opt/nexus-$VERSION                                              # Set permission to user nexus on software folder 1
chown -R nexus. /opt/sonatype-work                                               # Set permission to user nexus on software folder 2
sed -i "s/run_as_user=''/run_as_user='nexus'/g" /opt/nexus-$VERSION/bin/nexus    # Set on nexus binary the user to running that
# Create Nexus service
cat > /etc/systemd/system/nexus.service <<-EOF
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus-$VERSION/bin/nexus start
ExecStop=/opt/nexus-$VERSION/bin/nexus stop
User=nexus
Restart=on-abort
TimeoutSec=600

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload                                                         # Run daemon-reload to recognize the new service
systemctl start nexus                                                           # Start Nexus
systemctl enable nexus

# Now we check every 10 seconds if the service has sucessfully up
ONLINE=1
while [ $ONLINE != 200 ]; do
    sleep 10
    ONLINE=$(curl --write-out '%{http_code}' --silent --output /dev/null localhost:8081)
done

echo
echo "##################################################"
echo
echo "Your Nexus admin password is:"
cat /opt/sonatype-work/nexus*/admin.password && echo 
echo
echo "##################################################"
echo
