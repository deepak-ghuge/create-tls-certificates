#!/bin/bash
if [[ $1 == "localhost" || -z $1 ]]
then
	echo "Oouuchh! IP address not specified, using 127.0.0.1"
	ip="127.0.0.1"
else
	ip=$1
fi

dnsname="${2:-localhost}"

if [[ ! -d /crt ]]
then
	echo "ERRRrrr...you missed volume"
	echo "Example - docker run -v /hostcrt:/crt createtlscert <ip>"
elif [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ && "$dnsname" = "${dnsname%[[:space:]]*}" ]]
then
	cd /easy-rsa/easyrsa3/
	./easyrsa init-pki
	echo -en "\n" | ./easyrsa build-ca nopass
	echo "************** Creating Certificate for $ip and $dnsname **************"
	./easyrsa --subject-alt-name="IP:${ip},DNS:${dnsname}" build-server-full ${dnsname} nopass

	rm -f /crt/${dnsname}-trusted-ca.crt /crt/${dnsname}.crt /crt/${dnsname}.key
	cp pki/ca.crt /crt/${dnsname}-trusted-ca.crt
	cp pki/issued/${dnsname}.crt /crt/${dnsname}.crt
	cp pki/private/${dnsname}.key /crt/${dnsname}.key

	echo "Checking the details of generated certificates"
	openssl x509 -in /crt/${dnsname}.crt -text -noout

	echo "Yeepeee - Copied Certificates into source volume directory**************"
	echo "Certificate List : ${dnsname}-trusted-ca.crt, ${dnsname}.crt, ${dnsname}.key"
else
	echo "ERRRrrr... - IP address { $ip } and/or DNS Name { $dnsname } not valid"
fi
