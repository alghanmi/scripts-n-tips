#WeeChat Setup

##Install WeeChat on Debian
[WeeChat](http://www.weechat.org/) provides a set of [debian packages](http://www.weechat.org/download/debian/) through their own repositories. These repositories are offered with the following warning:
>**Warning**: these Debian packages are unofficial, not signed, and come with absolutely no guarantees.

####Setup Package Repo
```bash
echo "#WeeChat" | sudo tee /etc/apt/sources.list.d/weechat.list
echo "deb http://debian.weechat.org $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/weechat.list
```

If you are using APT pinning, like I am, you need to fix the pin priority
```bash
echo "Package: *" | sudo tee /etc/apt/preferences.d/weechat
echo "Pin: origin debian.weechat.org" | sudo tee -a /etc/apt/preferences.d/weechat
echo "Pin-Priority: 910" | sudo tee -a /etc/apt/preferences.d/weechat
sudo aptitude update
```

####Install WeeChat
```bash
sudo aptitude install weechat
```

###Configuration
Extra Scripts
```
/script install buffers.pl buffer_autoclose.py iset.pl go.py colorize_nicks.py
```

Disable merging _core_ buffer with _server_ buffers
```
/set irc.look.server_buffer independent
```

Mouse Support
```
/set weechat.look.mouse on
```

Only notify when _messages_ are posted, not for join/part
```
/set weechat.look.buffer_notify_default message
```

Hide join/part messages for all users (except active in last 5minutes)
```
/set irc.look.smart_filter on
/filter add irc_smart * irc_smart_filter *
```

####Personal Details
```
/set irc.server_default.nicks "DEFAULT_NICK,DEFAULT_NICK_,DEFAULT_NICK__"
```

####Interface Configuration
Use Unicode characters in the interface
```
/set weechat.look.prefix_suffix "│"
/set weechat.look.prefix_same_nick "⤷"
/set weechat.look.prefix_error "⚠"
/set weechat.look.prefix_network "ℹ "
/set weechat.look.prefix_join "→"
/set weechat.look.prefix_quit "←"
/set weechat.look.prefix_action "⚡"
/set weechat.look.bar_more_down "▼"
/set weechat.look.bar_more_left "◀"
/set weechat.look.bar_more_right "▶"
/set weechat.look.bar_more_up "▲"

/set weechat.look.read_marker_string "─"
/set weechat.look.item_buffer_filter "•"

/set weechat.look.buffer_time_format "${color:252}%H:${color:245}%M:${color:240}%S" 
```

Adjusting the interface to work with [Solarized](http://ethanschoonover.com/solarized) Dark theme:
```
/set weechat.bar.status.color_bg black
/set weechat.bar.title.color_bg black
/set weechat.color.chat_nick_colors 1,2,3,4,5,6
/set buffers.color.hotlist_message_fg 7
/set buffers.color.hotlist_highlight_bg default
/set buffers.color.hotlist_highlight_fg 5
/set weechat.color.chat_highlight _5
```

###Using IRC
####Connect to ZNC 
```
/server add znc_network1 znc.server.net/+7000 -username=znc_user/network1 -password=password
/set irc.server.znc_network1.ssl_verify on

/server add BNC $ZNC_SERVER/+$PORT -ssl -password=username/network:password -autoconnect
/set irc.server.BNC.ssl_verify on
```

####Connect to Servers
Freenode (SASL)
```
# SSL Connection to Server
/set irc.server.freenode.addresses "chat.freenode.net/7000"
/set irc.server.freenode.ssl on
/set irc.server.freenode.ssl_dhkey_size 1024

# SASL Configuration
/set irc.server_default.sasl_mechanism dh-blowfish
/set irc.server.freenode.sasl_username "FREENODE_NICK"
/set irc.server.freenode.sasl_password "FREENODE_PASSWORD"

# Personal Information
/set irc.server.freenode.username "FREENODE_USERNAME"
/set irc.server.freenode.realname "FREENODE_REAL_NAME"
/set irc.server.freenode.nicks "FREENODE_NICK,FREENODE_NICK_,FREENODE_NICK__"

/connect freenode

# Optional
# - Identify with Nickserv if not using SASL
#/set irc.server.freenode.command "/msg NICKSERV IDENTIFY FREENODE_PASSWORD"
# - Auto-connect on startup
#/set irc.server.freenode.autoconnect on
# - Auto-join channels
#/set irc.server.freenode.autojoin "#channel1,#channel2"
```

####Useful Commands
Close buffer
```
/close
```

Bind key to command, e.g. bind <Alt>-`y` to `/buffer close`
```


###Save Configuration
```
/save
```

###Keyboard Bindings
1. `<Ctrl>`-`X` &ndash; Switch between core buffer and server buffer

##Resources
http://weechat.org/
http://wiki.znc.in/Weechat
http://pascalpoitras.com/2013/05/25/my-weechat-configuration/
http://mewbies.com/how_to_install_and_use_irssi_and_weechat.htm#weechat
