FROM abakpress/knife-base

# YEKT locale

RUN rm /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime

RUN add-apt-repository ppa:nginx/development && \
    apt-get update && apt-get install -y nginx nginx-extras && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD nginx/services/nginx.sh /etc/service/nginx/run
ADD nginx/config/nginx.json /etc/consul/conf.d/
ADD nginx/config/nginx.conf /etc/nginx/nginx.conf
ADD nginx/config/app.nginx.conf /etc/nginx/sites-enabled/app.conf

ENV CONSUL_HOST consul

COPY nginx/init.d/* /etc/my_init.d/

EXPOSE 80 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp
