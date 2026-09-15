FROM --platform=$BUILDPLATFORM ubuntu:24.04 AS downloader

ARG TARGETARCH

RUN apt-get update \
    && apt-get install --no-install-recommends -y ca-certificates curl \
    && case "${TARGETARCH}" in \
        amd64) workerd_arch="linux-64" ;; \
        arm64) workerd_arch="linux-arm64" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
    esac \
    && curl -fsSL \
        "https://github.com/cloudflare/workerd/releases/latest/download/workerd-${workerd_arch}.gz" \
        -o /tmp/workerd.gz \
    && gzip -dc /tmp/workerd.gz > /workerd \
    && chmod 0755 /workerd

FROM ubuntu:24.04

COPY --from=downloader /workerd /usr/local/bin/workerd

ENTRYPOINT ["/usr/local/bin/workerd"]
CMD ["serve", "/app/config.capnp"]
