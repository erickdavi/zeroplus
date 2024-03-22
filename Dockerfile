FROM ubuntu as builder


RUN apt update && apt install build-essential libncurses5-dev git wget -y && apt clean \
&& wget https://busybox.net/downloads/busybox-1.36.1.tar.bz2 \
&& tar jxvf busybox-1.36.1.tar.bz2 \
&& mv busybox-1.36.1 busybox 

WORKDIR /busybox

RUN make defconfig \
&& make install \
&& sed -i 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' .config \
&& echo CONFIG_FEATURE_INSTALLER_SH_NO_DEFAULT_ASLR=y >> .config \
&& make -j$(nproc)

RUN bash -c "mkdir -p /opt/{bin,sbin,etc,proc,sys,dev,tmp,var}" \
&& cp -r /busybox/_install/bin/ /opt/ \
&& cp -r /busybox/_install/sbin /opt/ \
&& cp -r /busybox/_install/usr /opt/ 

WORKDIR /opt

RUN mknod -m 666 /opt/dev/null c 1 3 \
&& mknod -m 666 /opt/dev/zero c 1 5 \
&& mknod -m 666 /opt/dev/random c 1 8 \
&& mknod -m 666 /opt/dev/urandom c 1 9 \
&& mknod -m 666 /opt/dev/tty c 5 0 \
&& mknod -m 666 /opt/dev/console c 5 1 \
&& mknod -m 666 /opt/dev/ptmx c 5 2 \
&& mknod -m 666 /opt/dev/tty0 c 4 0 \
&& mknod -m 666 /opt/dev/full c 1 7 \
&& mknod -m 600 /opt/dev/initctl p \
&& ln -sf proc/self/fd dev/fd \
&& ln -sf proc/self/fd/0 dev/stdin \
&& ln -sf proc/self/fd/1 dev/stdout \
&& ln -sf proc/self/fd/2 dev/stderr \
&& mkdir -m 755 dev/pts dev/shm \
&& cp /busybox/busybox bin

FROM scratch
COPY --from=builder /opt/ /
ENV PATH=$PATH:/bin:/sbin
CMD ["/bin/busybox", "sh"]