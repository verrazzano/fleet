FROM ghcr.io/oracle/oraclelinux:7-slim
ARG ARCH
ENV ARCH=$ARCH
RUN yum -y update && \
    yum -y clean all
COPY bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000
CMD ["fleetcontroller"]
