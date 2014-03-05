#GPG Notes

##Basic Operations

###Key Management
  + Generate New key:
```bash
## Create GPG Key
# Choose (0) RSA and RSA
# Choose 4096
# Choose 2y
# Real name: YOUR_NAME
# Eamil: YOUR_EMAIL
gpg --gen-key
```
  + [Renew Expired Key](renew-key.md)

After generating a new key or renewing a key, you need to send it to a PGP server:
```bash
gpg --send-key KEY_ID
```

###Encrypt/Decrypt

####Personal Use
  + Encrypt File
```bash
gpg --encrypt --output foo.txt.gpg --recipient KEY_ID foo.txt
```

  + Decrypt File
```bash
gpg --output foo.txt --decrypt foo.txt.gpg
```

####Operations for Another Person
  1. Import Public Key
    + Import using Public Key file `gpg --import public_key.asc`
    + Import from KeyServer `gpg --search-keys 'friend@email.tld'`
  
  1. Encrypt: `gpg --encrypt --output foo.txt.gpg --recipient 'friend@email.tld' foo.txt`
  
  1. Decrypt: `gpg --output foo.txt --decrypt foo.txt.gpg`

###Signatures
Digital Signatures are used to verify that the contents of a file were made by the person claiming to be the author. There are three ways to sign a file/message:
  1. `--sign` &ndash; generates a new version of the document that is signed
  1. `--clearsign` &ndash;  the document will be wrapped in an ASCII-armored signature but otherwise unmodified.
  1. `--detach-sign` &ndash; generate a signature in a separate file

  + Verify DS: `gpg --verify important_file.tar.gz.asc important_file.tar.gz`
  + Generate a DS: `gpg --armor --output file.tar.gz.asc --detach-sign file.tar.gz`

##GPG Setup Notes
###Fix SHA1 Vulnerability
Due to a [vulnerability in SHA1](http://csrc.nist.gov/groups/ST/hash/statement.html), it is common practice to update your GPG configuration to default to SHA256.

Here is the code to do that:
```bash
#Make sure that all configuration files are created
gpg --list-keys &>/dev/null

#Append new configuration to GPG configuration
echo "" | tee -a ~/.gnupg/gpg.conf
echo "# Switch from using SHA1 to more secure hashes" | tee -a ~/.gnupg/gpg.conf
echo "personal-digest-preferences SHA256" | tee -a ~/.gnupg/gpg.conf
echo "cert-digest-algo SHA256" | tee -a ~/.gnupg/gpg.conf
echo "default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed" | tee -a ~/.gnupg/gpg.conf
```

###Switch Default Keyserver to be MIT Keyserver
```bash
#Make sure that all configuration files are created
gpg --list-keys &>/dev/null

#Backup Current Configuration
cp ~/.gnupg/gpg.conf ~/.gnupg/gpg.conf.default

#Perform the Switch
sed -i s/^keyserver\ .*/keyserver\ x-hkp:\\/\\/pgp.mit.edu/ ~/.gnupg/gpg.conf
```

##Common Commands
Note that `KEY_ID` can be replaced with the email in the key uid or the key name

  + List all [public] keys:
```bash
gpg --list-keys
```

  + List all _private_ keys:
```bash
gpg --list-secret-keys
```

  + Get Fingerprint of a specific key
```bash
gpg -K --fingerprint rami@raminoid.com | grep fingerprint
```

  + Export Key
```bash
gpg -ao me@example.com_public.key --export KEY_ID
gpg -ao me@example.com_private.key --export-secret-keys KEY_ID
```

  + Generate a Revocation Certificate
```bash
gpg --output me@example.com_revocation-cert.asc --gen-revoke KEY_ID
```

##Resources
  + http://gnupg.org/gph/en/manual/x135.html
  + http://www.madboa.com/geek/gpg-quickstart/
