FROM ghcr.io/oracle/oraclelinux:7-slim
ARG ARCH
ENV ARCH=$ARCH
RUN yum-config-manager --add-repo=http://yum.oracle.com/repo/OracleLinux/OL7/SoftwareCollections/x86_64 && \
    yum install -y rh-git227 curl ca-certificates unzip tar docker-cli nc mkisofs && \
    # Set up needed to ensure git 2.27 from rh-git227 is on the path
    ln /opt/rh/rh-git227/enable /etc/profile.d/git.sh && \
    source /etc/profile.d/git.sh && \
    git version
# Set up the git 2.x environment variables so that it's on the path and the needed files on the LD_LIBRARY_PATH
RUN cat /etc/profile.d/git.sh >> /etc/profile && \
    cd /lib64 && \
    ln -s /opt/rh/httpd24/root/usr/lib64/libcurl-httpd24.so.4 && \
    ln -s /opt/rh/httpd24/root/usr/lib64/libnghttp2-httpd24.so.14
COPY bin/fleetcontroller-linux-${ARCH} /usr/bin/fleetcontroller
COPY LICENSE README.md THIRD_PARTY_LICENSES.txt SECURITY.md /licenses/
USER 1000
CMD ["fleetcontroller"]
