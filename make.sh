#!/usr/bin/env bash

source $(dirname -- "$0")/build-fixes/config.sh

make defconfig dirclean && \
#make clean && \
./scripts/feeds clean

#make distclean && cp build-fixes/bak.config .config

#./scripts/feeds update -f nss && ./scripts/feeds install -a -p nss && \
./scripts/feeds update -a && \

# Apply curl_wolfssl_quic_tls13.patch
patch --verbose -p0 -N < ./build-fixes/curl_wolfssl_quic_tls13.patch && ./scripts/feeds update -a

./scripts/feeds install -a && summarize_conf && make defconfig && \

#cp build-fixes/target.linux.ipq806x.patches-5.15.999-998-bbr-plus-tsq.patch target/linux/ipq806x/patches-5.15/999-998-bbr-plus-tsq.patch && \
#git apply build-fixes\930-bbr-plus-tsq.patch && \
#cp build-fixes/package.network.services.dnsmasq.patches.900-strict-order-nxdomain.patch package/network/services/dnsmasq/patches/900-strict-order-nxdomain.patch && \

#make clean && \

./scripts/feeds install -a && summarize_conf && \

#cp diff_base .config && make defconfig && \
#cp build-fixes/bak.config .config && \

./scripts/getver.sh && \

#make target/linux/compile -j $(($(nproc)+1)) && \

make defconfig menuconfig && \
#make -j $(($(nproc)+1)) defconfig menuconfig download clean world
#echo 'CONFIG_TARGET_SUFFIX="muslgnueabihf"' >> .config && \
sed -i 's/CONFIG_TARGET_SUFFIX="muslgnueabi"/CONFIG_TARGET_SUFFIX="muslgnueabihf"/' .config && \
#sed -i '/--disable-multilib \\/d' ./toolchain/gcc/common.mk && \
make -j16 -l $(nproc) download clean world

#make ./scripts/config/conf >/dev/null || { make ./scripts/config/conf; exit 1; } && \
#make -j $(($(nproc)+1)) download clean world