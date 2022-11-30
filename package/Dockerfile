FROM ghcr.io/oracle/oraclelinux:7-slim
ARG ARCH
ENV ARCH=$ARCH
RUN yum-config-manager --enable ol7_optional_latest && \
    yum-config-manager --enable ol7_addons && \
    yum -y install git
COPY bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000
CMD ["fleetcontroller"]
