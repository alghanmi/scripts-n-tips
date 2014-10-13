##Bitlbee Setup
We start by connecting to the bitlbee setup on localhost using the ZNC server currently setup on the same machine.
```irc
/znc AddNetwork bitlbee
/znc *controlpanel LoadNetModule $me bitlbee log
/znc *controlpanel LoadNetModule $me bitlbee perform
/znc JumpNetwork bitlbee

/znc AddServer 127.0.0.1 58464
```

Register an account with Bitlbee. The nick is the default ZNC nick unless explicitly changed.
```irc
register $BITLBEE_USER_PASSWORD$
```

Add the password to ZNC
```irc
/znc *nickserv SET $BITLBEE_USER_PASSWORD$
``` 

###Add GMail Accounts
```
account add jabber <Google_Account_Address>
account jabber set oauth on

#Check account list number
account list
account <account_number> set server talk.google.com

#Enable account
account <account_number> on

#Fix G+ Contacts
account <account_number> set nick_format %full_name
```

Now, to have a GTalk channel (assuming account tag is gtalk)
```

```

###Add Facebook Account
```
account add jabber <facebook_username>@chat.facebook.com
account fb set oauth on
account fb on
account fb set nick_format %full_name
```

If you see a message after authentication that says: `fb - Logging in: Server claims your JID is 'SOME_NUMBER@chat.facebook.com' instead of ...`, then you need to properly set your facebook username:
```
account fb off
account fb set username SOME_NUMBER@chat.facebook.com
account fb on
```

##ZNC Setup
```
/znc SaveConfig
```
