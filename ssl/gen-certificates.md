#Create an SSL Certificate

##1. Generate Private Key
Let `HOST_FQDM` be the fully qualified domain name we want to generate the certificate for. To generate a private key, you run the following commands:

```bash
#Set domain name to be the FQDN of the current machine
#   You can of course specify your own,
export HOST_FQDM=$(hostname -f)
#Generating Private Key:
openssl genrsa -out $HOST_FQDM.key 2048
#Make key private
chmod 400 $HOST_FQDM.key
```

##2. Generate Certificate
There are two kinds of certificates, a signed certificate that you can get from a certificate authority (CA) or a self-signed certificate. Here, we will discuss how to do both.

When asked for certificate information, answer as you wish, as long as the _common name_ is set to be your FQDN. The password should be left empty, otherwise, you will need to enter it every time you restart your server.
  + **Country Name**: US
  + **State or Province Name**: California
  + **Locality Name**: Los Angeles
  + **Organization Name**: Example Industries
  + **Organizational Unit Name**: R&D
  + **Common Name**: `$HOST_FQDM`
  + **Email Address**: -blank-
  + **A challenge password**: -blank-
  + **An optional company name**: -blank-

###A. Certificate Service Request
To obtain a signed certificate from a CA, i.e. one that the browser will trust without showing a warning, you need to generate a Certificate Service Request (CSR) as follows:

```bash
#Generating Certificate Service Request (if you want to use a Certificate Authority)
openssl req -new -key $HOST_FQDM.key -out $HOST_FQDM.csr
```
If you want to enforce SHA256 signature, use the following command
```bash
#Generating Certificate Service Request (if you want to use a Certificate Authority)
openssl req -new -sha256 -key $HOST_FQDM.key -out $HOST_FQDM.csr
```
You will give the CA the CSR (and only te CSR, you keep the private key) and it will provide you with the certificate (i.e. public key)

###B. Self-Signed Certificate
You use OpenSSL to generate a certificate using the private key. Note you can pick the duration.

```bash
#Generate a self-signed SSL certificate
openssl req -new -x509 -days 365 -nodes -out $HOST_FQDM.crt -key $HOST_FQDM.key
```

##Application Setup
Some applications require that you create a unified certificate that contains your cert along with the CA certs. Here is an example of creating a unified certificate for a [StartSSL](https://www.startssl.com/) cert.

```bash
#Download Class 1 Intermediate Server CA
wget https://www.startssl.com/certs/sub.class1.server.ca.pem
#Download Root CA
wget https://www.startssl.com/certs/ca.pem

#Generate unified cert
cat $HOST_FQDM.crt sub.class1.server.ca.pem ca.pem > $HOST_FQDM-unified.crt
```

Other applications may require the private key to be part of the unified certificate. In this case, the process will look like:

```bash
#Download Class 1 Intermediate Server CA
wget https://www.startssl.com/certs/sub.class1.server.ca.pem
#Download Root CA
wget https://www.startssl.com/certs/ca.pem

#Generate unified cert
cat $HOST_FQDM.key $HOST_FQDM.crt sub.class1.server.ca.pem ca.pem > $HOST_FQDM-unified.crt
```

##Free Certificates from a Certificate Authorties
[StartSSL](https://www.startssl.com/) provides free certificates for a year.
