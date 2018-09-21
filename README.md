# create-tls-certificates
Generate TLS certificates for Testing.

Secure communication is one of the most important feature of any product. So while development or testing people come across similar requirement of having tls certificates for development or test. Getting those certificate from CA might take some time so to save some time waiting for certificate one can create certificate by himself. There are multiple tools/options available for creating tls certificates. The problem of such tools are they are not really platform independent also sometime we feel that installing those tools on our workstation might create issue for system or make our workstation messy. I created following docker based procedure which can work across any platform and at the same time does not mess wity workstation. 


Prerequiste - Docker


Steps : 
1. clone the git repo (https://github.com/deepak-ghuge/create-tls-certificates.git)

2. cd create-tls-certificates

3. docker build -t createtlscert .

4. mkdir /tmp/crt

5. docker run -it --rm -v /tmp/crt:/crt createtlscert ip hostname

eg docker run -it --rm -v /tmp/crt:/crt createtlscert 192.168.122.1 ubiquity

TLS certificates will be created and copied in the /tmp/crt directory 
Certificates with same name will be overwritten if present in the /tmp/crt. 

Note - Generating TLS certificate using this method is only meant for Test purpose.  
