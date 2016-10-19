FROM devopsftw/baseimage:dev

# YEKT locale
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD app/app.py /etc/service/app/run

ENV CONSUL_HOST consul

EXPOSE 8080