#ZNC IRC Bouncer

##Setup Instructions

###Installing ZNC Application
```bash
#Install dependencies
sudo aptitude build-dep znc

#Download the latest source code:
wget http://znc.in/releases/znc-latest.tar.gz
#Unpack file
tar zxvf znc-latest.tar.gz
cd znc-*

#Install ZNC
./configure
make
sudo make install
```

###User Management
```bash
sudo adduser --system --home /var/lib/znc --group --gecos 'znc irc bounser' znc
sudo su - znc -s /bin/bash -c '/usr/local/bin/znc --datadir=/var/lib/znc --makeconf'
```

###Run ZNC as a System Daemon
```bash
#Download and setup init script
sudo curl --silent https://gist.githubusercontent.com/alghanmi/8998028/raw/znc-init.sh -o /etc/init.d/znc
sudo chmod 755 /etc/init.d/znc
sudo update-rc.d znc defaults

#Add Pid file to configuration
sudo sed -i '/<\/Listener>/a\
\nPidFile = /var/run/znc/znc.pid' /var/lib/znc/configs/znc.conf
```

###SSL Certificate
If you opted to use a CA signed cert as opposed to ZNC's own certificate, here is an example of using a [StartSSL](http://www.startssl.com/) free certificate.

```bash
#Download Intermediate Server & Root CA
curl --silent --remote-name https://www.startssl.com/certs/sub.class1.server.ca.pem
curl --silent --remote-name https://www.startssl.com/certs/ca.pem
#Generate unified cert
cat $HOST_FQDM.key $HOST_FQDM.crt sub.class1.server.ca.pem ca.pem > znc.pem

#Move PEM to znc
sudo chmod 600 znc.pem
sudo chown znc:znc znc.pem
sudo mv znc.pem /var/lib/znc/

#Test Cert
openssl s_client -showcerts -connect $HOST_FQDM:$PORT
```

###Run ZNC in debug mode
```bash
sudo su - znc -s /bin/bash -c '/usr/local/bin/znc --datadir=/var/lib/znc --debug'
```

##ZNC Commands

```
#Status
/znc
#Help
/znc help

#Do configuration
/znc LoadMod controlpanel
/znc *controlpanel help

#Save configuration
/znc rehash
```

####Module Commands
```irc
/znc ListMods
/znc ListAvailMods
```

##Manual Configuration to `znc.conf`
  + `MaxBufferSize`  set to `500`. Override this in user configuration
  + `User.MaxNetworks` set to `5`.

##Hints
  + When using ports, `7000` signals a normal ports while `+7000` means an SSL port
  + When you want to connect to multiple networks through znc, you need to connect to your client once per network using:
    - username: znc_username/networkname
    - password: znc_password

##Resources
  + http://wiki.znc.in/ZNC
  + https://github.com/znc/znc
  + https://www.digitalocean.com/community/articles/how-to-install-znc-an-irc-bouncer-on-an-ubuntu-vps  
