#IRRSI Basic Configuration

###Packages
```
#Install Packages
sudo aptitude install irssi irssi-scripts \
                      libcrypt-blowfish-perl libcrypt-dh-perl libcrypt-openssl-bignum-perl \
                      libmath-bigint-gmp-perl


#Make a place for autorun scripts
mkdir -p $HOME/.irssi
mkdir -p $HOME/.irssi/scripts/autorun
chmod 700 $HOME/.irssi
curl --silent http://freenode.net/sasl/cap_sasl.pl -o $HOME/.irssi/scripts/cap_sasl.pl
pushd .
cd $HOME/.irssi/scripts/autorun/
ln -s ../cap_sasl.pl
popd
```

##Basic Configuration
This is the basic [startup](http://irssi.org/documentation/startup) configuration:
```
/SET term_force_colors ON

/SET autocreate_own_query OFF
/SET autocreate_query_level DCCMSGS
/SET use_status_window OFF

/SET use_msgs_window ON

/SET autoclose_windows OFF
/SET reuse_unused_windows ON

/HILIGHT nick
```

###User Specific Configuration
####Setup Nicks and User Info
```
/set nick <nick>
/set alternate_nick <alt-nick>
/set user_name <nick>
/set real_name <real-name>
```

####Setup an IRC Network
Here is an example of setting-up [freenode](http://freenode.net/) with the following features:
  + Auto connecting at launch
  + Connecting via [SSL](http://freenode.net/irc_servers.shtml)
  + [Verifying Freenode](http://freenode.net/irc_servers.shtml)'s SSL Certification
  + Setup [SASL authentication](https://pthree.org/2010/01/31/freenode-ssl-and-sasl-authentication-with-irssi/) for passwords

```
/network add freenode
/server add -auto -ssl -ssl_verify -ssl_capath /etc/ssl/certs -network freenode chat.freenode.net 6697
/sasl set freenode <nick> <password> DH-BLOWFISH
/sasl save
```

####Channel Settings
  + Auto join a channel
```
/channel add -auto #<channel> <network>
```

  + Ignore certain messages in a channel
```
/ignore -channels #channel * MODES JOINS PARTS QUITS NICKS
```

###Save Setup
```
/save
/exit
```

##Resources
  + http://quadpoint.org/articles/irssi/
  
