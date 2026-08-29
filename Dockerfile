FROM ubuntu:24.04

RUN curl -sL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g workerd

ENTRYPOINT ["workerd"]
CMD ["serve", "/app/config.capnp"]
