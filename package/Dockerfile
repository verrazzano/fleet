FROM ghcr.io/oracle/oraclelinux:8-slim as build
ARG ARCH
ENV ARCH=$ARCH

COPY . /go/src/github.com/rancher/fleet/

RUN microdnf update -y --setopt=install_weak_deps=0 --setopt=tsflags=nodocs && \
    microdnf install -y golang-1.20.10-1.module+el8.9.0+90068+08775a1f.x86_64 && \
    microdnf install -y git && \
    cd /go/src/github.com/rancher/fleet/scripts && \
    ./build && \
    ./test

FROM ghcr.io/verrazzano/ol8-static:v0.0.1-20231102152128-e7afc807
ARG ARCH

COPY --from=build /go/src/github.com/rancher/fleet/bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000

CMD ["fleetcontroller"]
