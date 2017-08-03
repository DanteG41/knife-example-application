FROM busybox

# YEKT locale
ENV TZ=Asia/Yekaterinburg
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /data
VOLUME /data

ENTRYPOINT /bin/sh -c "while true; do sleep 100; done"
