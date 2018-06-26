#!/bin/bash
if [[ $1 == "localhost" ]]
then
	echo "Oouuchh! IP address not specified, using 127.0.0.1"
	ip="127.0.0.1" 
else
	ip=$1
fi
if [[ ! -d /crt ]]
then 
	echo "ERRRrrr...you missed volume"
	echo "Example - docker run -v /hostcrt:/crt createtlscert <ip>"
elif [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
	cd /easy-rsa/easyrsa3/
	./easyrsa init-pki
	echo -en "\n" | ./easyrsa build-ca nopass
	echo "************** Creating Certificate for $ip **************"
	./easyrsa --subject-alt-name="IP:${ip},DNS:ubiquity" build-server-full ubiquity nopass
	rm -f /crt/ubiquity-trusted-ca.crt /crt/ubiquity.crt /crt/ubiquity.key
	cp pki/ca.crt /crt/ubiquity-trusted-ca.crt
	cp pki/issued/ubiquity.crt /crt/ubiquity.crt
	cp pki/private/ubiquity.key /crt/ubiquity.key
	echo "Yeepeee - Copied Certificates into source volume directory**************"
else
	echo "ERRRrrr... - IP address { $ip } not valid"
fi
