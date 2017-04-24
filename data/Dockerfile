FROM busybox

# YEKT locale
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN mkdir /data/nginx && echo "Hello world" > /data/nginx/index.html
VOLUME /data
CMD ["echo", "data volume"]
