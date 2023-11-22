FROM ghcr.io/oracle/oraclelinux:8-slim as BUILD
RUN microdnf update -y --setopt=install_weak_deps=0 --setopt=tsflags=nodocs && \
    microdnf install -y golang-1.20.10-1.module+el8.9.0+90068+08775a1f.x86_64

COPY /go/src/github.com/rancher/fleet/ /go/src/github.com/rancher/fleet/
RUN source scripts/build

FROM ghcr.io/oracle/oraclelinux:8-slim
ARG ARCH
ENV ARCH=$ARCH
RUN microdnf update -y --setopt=install_weak_deps=0 --setopt=tsflags=nodocs && \
    microdnf install -y unzip nc mkisofs && \
    microdnf clean all && \
    rm -rf /var/cache/yum /var/lib/rpm/*

COPY bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000

# Update PATH to make sure git 2.27 is on the path
ENV PATH="/opt/rh/rh-git227/root/usr/bin:${PATH}"

CMD ["fleetcontroller"]
