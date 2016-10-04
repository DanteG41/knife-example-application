FROM devopsftw/baseimage:dev

# YEKT locale
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
  apt-get install -yq --no-install-recommends nginx netcat && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

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
