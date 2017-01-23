FROM alpine:latest
MAINTAINER Adrian Fedoreanu <adrian.fedoreanu@gmail.com>

RUN apk add --no-cache python \
    py2-pip \
    py2-futures \
    py-mysqldb \
    py-tz \
    py-pillow \
    py-gunicorn \
    py-django-treebeard \
    py-django-compressor \
    ca-certificates \
    supervisor \
  && pip install -U pip

WORKDIR /app

ONBUILD COPY extra_packages.txt /app
ONBUILD COPY requirements.txt /app
ONBUILD RUN apk add --no-cache `cat /app/extra_packages.txt` \
  && pip install --no-cache-dir -Ur requirements.txt \
  && apk del py2-pip

ONBUILD COPY . /app

ONBUILD RUN chown -R nobody:nobody /app
ONBUILD USER nobody

ENTRYPOINT ["/app/bin/supervisord"]
CMD []
