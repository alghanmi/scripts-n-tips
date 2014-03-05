#Useful Commands to Check Certs

Using the following variables
  + `$SERVER`: server hosting the SSL cert
  + `$PORT`: port
  
Check the validity dates of an SSL certificate
```bash 
echo | openssl s_client -showcerts -connect $SERVER:$PORT 2>/dev/null | openssl x509 -noout -dates
```

Check the issuer
```bash
echo | openssl s_client -connect $SERVER:$PORT 2>/dev/null | openssl x509 -noout -issuer
```

Check who the cert was issues to
```bash
echo | openssl s_client -connect $SERVER:$PORT 2>/dev/null | openssl x509 -noout -subject
```

Get the fingureprint of the certificate
```bash
echo | openssl s_client -connect $SERVER:$PORT 2>/dev/null | openssl x509 -noout -fingerprint
```

#Services to Check Certificates
  + DigiCert: http://www.digicert.com/help/?host=
  + SSL Labs: https://www.ssllabs.com/ssltest/
