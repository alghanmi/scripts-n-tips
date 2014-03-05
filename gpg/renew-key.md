#Renew GPG Key

####Step 1 &ndash; Choose They Key to Renew
```bash
gpg --list-keys 
```
From the list above, pick the key you want to renew.

####Step 2 &ndash; Edit the Key
We will use the gpg edit tool to renew/extend the key.
```bash
gpg --edit-key <key-name>
```

  1. List available keys. That includes public and sub-keys
```
gpg> list
```

  1. Extend the primary key. Extensions can be in terms of days, weeks, months or years. Also, you have an option to make the not expire at all. Here we will choose 2 years
```
gpg> expire
```

  1. Now, we need to renew all sub-keys. Subkeys are given ids starting from 1 for the first subkey. Use the `list` command to see all subkeys.
```
gpg> key 1
gpg> expire
```

  1. Once all subkeys have been renewd, we need to save and exit
```
gpg> save
```

