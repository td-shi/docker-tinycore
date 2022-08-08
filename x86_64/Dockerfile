FROM alpine:latest AS build-tinycore-fs

LABEL uuid="5d5648eb-37c5-487d-8ff6-25c543f5c4a2"

ARG CORE_MAJOR_VER=13.x
ARG CORE_ARC_TYPE=x86_64
ENV URL_TCZ=http://tinycorelinux.net/${CORE_MAJOR_VER}/${CORE_ARC_TYPE}/tcz
ENV URL_ROOTFS=http://www.tinycorelinux.net/${CORE_MAJOR_VER}/${CORE_ARC_TYPE}/release/distribution_files/rootfs64.gz

COPY tce-load.patch /tmp/
COPY download_squashfs_tools.sh /tmp/

RUN apk add --no-cache curl patch squashfs-tools > /dev/null
RUN cd /tmp \
    && mkdir squashfs-tools \
    && mkdir rootfs64 \
    && chmod +x /tmp/download_squashfs_tools.sh \
    && /tmp/download_squashfs_tools.sh ${URL_TCZ} \
    && for t in $(find -name '*.tcz'); do unsquashfs -f -d /tmp/squashfs-tools $t >/dev/null; done \
    && curl -SLO ${URL_ROOTFS} \
    && cd rootfs64 \
    && gzip -dc ../rootfs64.gz | cpio -id \
    && cd usr/bin \
    && patch < /tmp/tce-load.patch

CMD ["/bin/true"]

FROM scratch

LABEL uuid="72863671-3c02-4705-9cd1-194c4a86499e"

COPY --from=build-tinycore-fs /tmp/rootfs64/ /
COPY --from=build-tinycore-fs /tmp/squashfs-tools/ /

RUN mkdir -p /tmp/tce/optional \
    && chown -R root:staff /tmp/tce /usr/local/tce.installed \
    && chmod -R g+w /tmp/tce \
    && chown root:root /usr/bin/sudo \
    && chmod 4111 /usr/bin/sudo \
    && $(cd etc/sysconfig; ln -s ../../tmp/tce tcedir) \
    && echo -n tc > etc/sysconfig/tcuser \
    && . /etc/init.d/tc-functions \
    && ldconfig \
    && setupHome

USER tc:staff
WORKDIR /home/tc
CMD ["/bin/sh"]

