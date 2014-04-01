## IRC Notes

###Initial Setup
Using an IRC client, you start by creating a nick and registering that nick - unless its taken - to be your own. Make sure to follow the [nick setup instructions](http://freenode.net/faq.shtml#nicksetup). 

  + Choose a nick name
```
/nick <nick>
```

  + Register nick (1st time)
```
/msg NickServ REGISTER <nick> <email> 
```

  + Protect nick with password
```
/msg NickServ REGISTER <password>
```

###Optional But Worthy
Here are some optional actions, however, they are worthy of being used:

  + Hide Email on IRC Server
```
/msg NickServ SET HIDEMAIL ON
```

  + Hide Private Information (automatically enables HIDEMAIL)
```
/msg NickServ SET PRIVATE ON
```

  + Create an alternative nick and group it with your primary. Note these must be done in order. It is good practice to have your alternative nick to be your original nick with an underscore, e.g. `nick_`
```
/nick <alt-nick>
/msg NickServ IDENTIFY <nick> <password>
/msg NickServ GROUP
```

  + It is also advisable to ask for a [hostname cloak](http://freenode.net/faq.shtml#cloaks) to hide the IP address/hostname you are connecting from.

Finally, Check your setup
```
/msg NickServ INFO
```

###Basics
After connecting to the server, you start by identifying yourself:
```
/msg NickServ IDENTIFY <nick> <password>
```


###Channel Management
To create a new channel, you should first [pick a proper name](http://freenode.net/policy.shtml#channelnaming) for the channel. Then check if it is available to register:
```
/msg ChanServ INFO #<channel>
```

If you find the channel to be unregistered, you simply register the channel
```
/msg ChanServ REGISTER #<channel>
```

and, don't forget to join the channel
```
/join #<channel>
```

####Channel Admin
Channels usually have _founders_ and _operators_. A founder is a de facto operator and you can add a founder by updating the [flags](http://freenode.net/using_the_network.shtml#flags) for that user within the channel:
```
/msg ChanServ FLAGS #<channel> <nick> +*F
/msg ChanServ FLAGS #<channel> <nick> -OV
```

Operator status can be granted to a user (including yourself if you were a founder):
```
/msg ChanServ OP #<channel> <nick>
```

It is advised that you don't keep operator status more than you need. You can remove operator status by
```
/msg ChanServ DEOP #<channel> <nick>
```

Finally, you can check all flags assigned to all users via
```
/msg ChanServ ACCESS #<channel> LIST
```

Channel topics can be set or prepended/appended using the following commands
```
/msg ChanServ TOPIC #<channel> <topic>
/msg ChanServ TOPICAPPEND #<channel> <more_details>
/msg ChanServ TOPICPREPEND #<channel> <more_details>
```

To Keep the topic
```
/msg ChanServ SET #<channel> KEEPTOPIC ON
```


### References
  + http://freenode.net/faq.shtml
  + http://richard.esplins.org/siwi/2011/07/08/getting-started-freenode-irc/

