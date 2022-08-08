FROM alpine:latest AS build-tinycore-fs

LABEL uuid="4f233d3b-c403-4e24-8716-4f8046de90d3"

ARG CORE_MAJOR_VER=13.x
ARG CORE_ARC_TYPE=x86
ENV URL_TCZ=http://tinycorelinux.net/${CORE_MAJOR_VER}/${CORE_ARC_TYPE}/tcz
ENV URL_ROOTFS=http://www.tinycorelinux.net/${CORE_MAJOR_VER}/${CORE_ARC_TYPE}/release/distribution_files/rootfs.gz

COPY tce-load.patch /tmp/
COPY download_squashfs_tools.sh /tmp/

RUN apk add --no-cache curl patch squashfs-tools > /dev/null
RUN cd /tmp \
    && mkdir squashfs-tools \
    && mkdir rootfs \
    && chmod +x /tmp/download_squashfs_tools.sh \
    && /tmp/download_squashfs_tools.sh ${URL_TCZ} \
    && for t in $(find -name '*.tcz'); do unsquashfs -f -d /tmp/squashfs-tools $t >/dev/null; done \
    && curl -SLO ${URL_ROOTFS} \
    && cd rootfs \
    && gzip -dc ../rootfs.gz | cpio -id \
    && cd usr/bin \
    && patch < /tmp/tce-load.patch

CMD ["/bin/true"]

FROM scratch

LABEL uuid="07d59f60-6e12-42f2-a7ea-0a9a2d234ea5"

COPY --from=build-tinycore-fs /tmp/rootfs/ /
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

