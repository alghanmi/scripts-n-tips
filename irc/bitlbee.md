#Bitlbee
[BitlBee](http://www.bitlbee.org/) is a gateway between IRC and other networks. This includes AIM, Twitter, Facebook and GTalk


###Installation
```bash
#Install required dev packages
#  Note Bitlbee is not compatable with libotr5-dev
sudo aptitude install libglib2.0-dev libotr2-dev libgnutls-dev

#Download Bitlbee Package
curl http://get.bitlbee.org/src/bitlbee-3.2.1.tar.gz -o bitlbee.tar.gz
tar zxvf bitlbee.tar.gz
cd bitlbee-*

#Configure package.
#  Must use GNU TLS to support SSL Certificate verification.
#  See http://bugs.bitlbee.org/bitlbee/ticket/886
#  Also removing support for unused protocols
./configure --prefix=/usr/local/ --etcdir=/etc/bitlbee --pidfile=/var/run/bitlbee/bitlbee.pid --otr=1 --ssl=gnutls --msn=0 --oscar=0 --yahoo=0

#Compile & Install
make
sudo make install install-etc

#Create bitlbee user
sudo adduser --system --home /var/lib/bitlbee --group --gecos 'bitlbee irc server' bitlbee
```

###Configuration
The following configuration assumes a basic configuration on a machine with ZNC installed and no need to connect to Bitlbee ovevr the network, i.e. localhost connections only.

```bash
#Backup default configuration
sudo cp /etc/bitlbee/bitlbee.conf /etc/bitlbee/bitlbee.conf.default

##Edit Configuration
# RunMode = ForkDaemon
sudo sed -i 's/^#\s*RunMode = .*/RunMode = ForkDaemon/' /etc/bitlbee/bitlbee.conf

# User = bitlbee
sudo sed -i 's/^#\s*User = .*/User = bitlbee/' /etc/bitlbee/bitlbee.conf

# DaemonInterface = 127.0.0.1 && HostName = $(hostname -f) && DaemonPort = <pick a port>
# Due to using ZNC on the same machine, no need for an internet facing port
# Also suggest switching from default port for security purposes
sudo sed -i 's/^#\s*DaemonInterface = .*/DaemonInterface = 127.0.0.1/' /etc/bitlbee/bitlbee.conf
sudo sed -i 's/^#\s*DaemonPort = .*/DaemonPort = 6667/' /etc/bitlbee/bitlbee.conf
sudo sed -i "s/^#\s*HostName = .*/HostName = $(hostname -f)/" /etc/bitlbee/bitlbee.conf

# AuthMode = Open
# This is a temporary configuration until actual registration is done
# After that, this should change to Closed
sudo sed -i 's/^#\s*AuthMode = .*/AuthMode = Open/' /etc/bitlbee/bitlbee.conf

# Set Passwords for Authentication and Operator
# These passwords are for example purposes, set your own as needed
export BITLBEE_AUTHPASS=$(echo ${RANDOM}_${HOSTNAME}_$(date +%s)_auth)
export BITLBEE_OPERPASS=$(echo ${RANDOM}_${HOSTNAME}_$(date +%s)_oper)
sudo sed -i "s/^#\s*AuthPassword = md5\\:.*/AuthPassword = md5:$(/usr/local/sbin/bitlbee -x hash $BITLBEE_AUTHPASS)/" /etc/bitlbee/bitlbee.conf
sudo sed -i "s/^#\s*OperPassword = md5\\:.*/OperPassword = md5:$(/usr/local/sbin/bitlbee -x hash $BITLBEE_OPERPASS)/" /etc/bitlbee/bitlbee.conf
unset BITLBEE_AUTHPASS
unset BITLBEE_OPERPASS

# PingInterval = 0 && PingTimeOut = 300
# Since we are using ZNC on localhost (127.0.0.1), there is no need to do a ping clients to check if they are alive
sudo sed -i 's/^#\s*PingInterval = .*/PingInterval = 0/' /etc/bitlbee/bitlbee.conf
sudo sed -i 's/^#\s*PingTimeOut = .*/PingTimeOut = 0/' /etc/bitlbee/bitlbee.conf

# Protocols = jabber twitter
# Only load needed protocols. Current configuration allows for more, but these are the used ones.
sudo sed -i 's/^#\s*Protocols = .*/Protocols = jabber twitter/' /etc/bitlbee/bitlbee.conf

# CAfile = /etc/ssl/certs/ca-certificates.crt
# Enable certificates file for SSL certificate verification
sudo sed -i 's/^#\s*CAfile = .*/CAfile = \/etc\/ssl\/certs\/ca-certificates.crt/' /etc/bitlbee/bitlbee.conf
```

####Run Bitlbee as a System Daemon 
```bash
#Download and setup init script
sudo curl --silent https://gist.githubusercontent.com/alghanmi/8998028/raw/bitlbee-init.sh -o /etc/init.d/bitlbee
sudo chmod 755 /etc/init.d/bitlbee
sudo update-rc.d bitlbee defaults
sudo service bitlbee start
```
