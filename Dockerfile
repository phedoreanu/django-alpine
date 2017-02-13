FROM alpine:latest
MAINTAINER Adrian Fedoreanu <adrian.fedoreanu@gmail.com>

RUN apk add --no-cache python3 \
    py-futures \
    py-tz \
    py-pillow \
    py-gunicorn \
    ca-certificates \
  && pip3 install -U pip

WORKDIR /app

ONBUILD COPY requirements.txt /app
ONBUILD RUN pip3 install --no-cache-dir -Ur requirements.txt \
  && rm -r /root/.cache

ONBUILD COPY . /app

ONBUILD RUN chown -R nobody:nobody /app
ONBUILD USER nobody

ENTRYPOINT ["/app/bin/supervisord"]
CMD []
