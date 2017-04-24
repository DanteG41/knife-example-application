FROM abakpress/knife-base

# YEKT locale
RUN rm /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime

RUN add-apt-repository ppa:nginx/development && \
  apt-get update && apt-get install -y nginx nginx-extras netcat && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define mountable directories
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

ADD nginx/services/nginx.sh /etc/service/nginx/run
ADD nginx/config/* /etc/consul/conf.d/

ADD nginx/services/tcp.sh /etc/service/tcp/run
ADD nginx/services/udp.sh /etc/service/udp/run

ENV CONSUL_HOST consul

# nginx
EXPOSE 80
EXPOSE 443
# netcat udp
EXPOSE 3500
# netcat tcp
EXPOSE 3600
