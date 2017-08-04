FROM abakpress/knife-base

# YEKT locale
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
  apt-get install -yq --no-install-recommends nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

ADD nginx/services/nginx.sh /etc/service/nginx/run
ADD nginx/config/nginx.json /etc/consul/conf.d/
ADD nginx/config/nginx.conf /etc/nginx/nginx.conf
ADD nginx/config/app.nginx.conf /etc/nginx/sites-enabled/app.conf

ENV CONSUL_HOST consul

# nginx
EXPOSE 80
