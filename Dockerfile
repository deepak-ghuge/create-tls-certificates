FROM ubuntu:16.04
MAINTAINER Deepak Ghuge
RUN apt-get update
RUN apt-get install git -y
RUN git clone https://github.com/OpenVPN/easy-rsa
COPY docker-entrypoint.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/docker-entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["localhost"]
