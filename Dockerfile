FROM alpine:latest
RUN   adduser -S -D -H -h /almaminer freecoin
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        automake \
        cmake \
        autoconf \
        openssl-dev \
        curl-dev \
        git \
        build-base && \
        cd ~almaminer && \
        git clone https://github.com/fireice-uk/xmr-stak.git && \
        mkdir xmr-stak/build && \
        cd xmr-stak/build && \
        cmake .. \
              -DHWLOC_ENABLE=OFF \
              -DCUDA_ENABLE=OFF  \
              -DMICROHTTPD_ENABLE=OFF \
              -DOpenCL_ENABLE=OFF && \
        make install
USER  freecoin
WORKDIR    /almaminer
ENTRYPOINT  ["/almaminer/xmr-stak/build/bin/xmr-stak"]
