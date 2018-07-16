
#Dockerfile for cpuminer-opt
# usage: docker build -t cpuminer-opt:latest .
# run: docker run -it --rm cpuminer-opt:latest [ARGS]
# ex: docker run -it --rm cpuminer-opt:latest -a cryptonight -o cryptonight.eu.nicehash.com:3355 -u 1MiningDW2GKzf4VQfmp4q2XoUvR6iy6PD.worker1 -p x -t 3
#

# Build
FROM ubuntu:16.04 as builder

RUN apt-get update \
  && apt-get install -y \
  git \
  build-essential \
  cmake \
  wget \
  vim \
  libuv1-dev \
  libmicrohttpd-dev \
  libssl-dev \
  libgmp-dev \
  libcurl4-gnutls-dev \
  libjansson-dev \
  automake \
  libcurl3 \
  libjansson4 \
  && rm -rf /var/lib/apt/lists/*

  RUN git clone https://github.com/JayDDee/cpuminer-opt /app && \
  cd /app/ && ./build.sh

# App
FROM ubuntu:16.04

RUN apt-get update \
  && apt-get install -y \
  git \
  build-essential \
  cmake \
  wget \
  vim \
  libuv1-dev \
  libmicrohttpd-dev \
  libssl-dev \
  libgmp-dev \
  libcurl4-gnutls-dev \
  libjansson-dev \
  automake \
  libcurl3 \
  libjansson4 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/cpuminer .
ENTRYPOINT ["./cpuminer"]
CMD ["-h"]
