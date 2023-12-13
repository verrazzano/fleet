FROM ghcr.io/verrazzano/golang:v1.20.12 as build
ARG ARCH
ENV ARCH=$ARCH

COPY . /go/src/github.com/rancher/fleet/

RUN dnf config-manager --enable ol8_appstream && \
    dnf install -y git && \
    cd /go/src/github.com/rancher/fleet/scripts && \
    ./build && \
    ./test

FROM ghcr.io/oracle/oraclelinux:8-slim
ARG ARCH
ENV ARCH=$ARCH

RUN microdnf update -y --setopt=install_weak_deps=0 --setopt=tsflags=nodocs && \
    microdnf install -y unzip nc mkisofs && \
    microdnf clean all && \
    rm -rf /var/cache/yum /var/lib/rpm/*

COPY --from=build /go/src/github.com/rancher/fleet/bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000

# Update PATH to make sure git 2.27 is on the path
ENV PATH="/opt/rh/rh-git227/root/usr/bin:${PATH}"

CMD ["fleetcontroller"]
