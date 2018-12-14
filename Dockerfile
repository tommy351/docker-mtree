FROM debian:stretch AS builder
RUN apt-get update -y
RUN apt-get install -y curl gcc autoconf automake make libssl-dev
ENV MTREE_VERSION 1.0.4
RUN curl -L https://github.com/archiecobbs/mtree-port/archive/${MTREE_VERSION}.tar.gz | tar -xz
RUN cd mtree-port-${MTREE_VERSION} && \
  ./autogen.sh && \
  ./configure LDFLAGS="-static" && \
  make && \
  make install

FROM scratch
COPY --from=builder /usr/bin/mtree /usr/bin/mtree
