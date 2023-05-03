FROM ghcr.io/oracle/oraclelinux:7-slim
ARG ARCH
ENV ARCH=$ARCH
RUN yum-config-manager --enable ol7_optional_latest && \
    yum-config-manager --enable ol7_addons && \
    yum update -y && \
    # software collections repo needed for git 2.x on OL7
    yum-config-manager --add-repo=http://yum.oracle.com/repo/OracleLinux/OL7/SoftwareCollections/x86_64 && \
    yum install -y rh-git227 curl ca-certificates unzip tar docker-cli nc mkisofs && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    # Set up needed to ensure git 2.27 from rh-git227 is on the path
    ln /opt/rh/rh-git227/enable /etc/profile.d/git.sh && \
    source /etc/profile.d/git.sh && \
    cat /etc/profile.d/git.sh >> /etc/profile && \
    git version
COPY bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000

# Update PATH to make sure git 2.27 is on the path
ENV PATH="/opt/rh/rh-git227/root/usr/bin:${PATH}"

CMD ["fleetcontroller"]
