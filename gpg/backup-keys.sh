#!/bin/bash

##
## Backup all Public/Private Keypairs
##

LOCAL_KEYS=$(gpg --list-secret-keys | grep ^sec | sed -e 's/.*\/\(.*\)/\1/' -e 's/\(\S*\).*/\1/')
#LOCAL_KEYS="9D64AB3D 4BC647FB CB3747A3"
mkdir key_backup/
cd key_backup/

for uid in $LOCAL_KEYS
do
	key_data=$(gpg --list-secret-key $uid | grep ^sec)
	key_id=$uid
	key_exp=$(echo $key_data | sed 's/.*\[.*: \(.*\)\]/\1/')
	key_email=$(gpg --list-key $key_id | grep ^uid | sed 's/.*<\(.*\)>.*/\1/')
	
	echo "**** Exporting Public/Private Key $key_id for $key_email expiring on $key_exp ****"
	gpg -ao ${key_email}_${key_exp}_private.key --export-secret-keys $key_id
	gpg -ao ${key_email}_${key_exp}_public.key --export $key_id
	gpg --output ${key_email}_${key_exp}_revocation-cert.asc --gen-revoke $key_id
done

chmod 400 *_private.key
chmod 440 *_revocation-cert.asc
chmod 644 *_public.key

cd ..
