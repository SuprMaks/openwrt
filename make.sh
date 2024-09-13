#!/usr/bin/env bash

source $(dirname -- "$0")/build-fixes/config.sh

#make target/compile package/{qca-nss-gmac,qca-nss-drv,qca-nss-clients,qca-nss-ecm}/{clean,compile} V=s -j10
#cp build-fixes/feeds.nss.qca-nss-clients.Makefile feeds/nss/qca-nss-clients/Makefile
#cp build-fixes/feeds.nss.qca-nss-ecm.Makefile feeds/nss/qca-nss-ecm/Makefile

make dirclean  && \
#make clean && \
./scripts/feeds clean

#make distclean && cp build-fixes/bak.config .config

#./scripts/feeds update -f nss && ./scripts/feeds install -a -p nss && \
./scripts/feeds update -a && \

# Apply curl_wolfssl_quic_tls13.patch
patch --verbose -p0 -N < ./build-fixes/curl_wolfssl_quic_tls13.patch && ./scripts/feeds update -a

cp build-fixes/feeds.nss.qca-nss-clients.Makefile feeds/nss/qca-nss-clients/Makefile && \
cp build-fixes/feeds.nss.qca-nss-ecm.Makefile feeds/nss/qca-nss-ecm/Makefile && \

./scripts/feeds install -a && summarize_conf && \

# Apply 990-add-nss-load-to-status.patch
make package/luci-mod-status/{clean,prepare} QUILT=1 && \
([ -d package/feeds/luci/luci-mod-status/patches ] || mkdir package/feeds/luci/luci-mod-status/patches) && \
cp build-fixes/package_feeds_luci_luci-mod-status_patches_990-add-nss-load-to-status.patch package/feeds/luci/luci-mod-status/patches/990-add-nss-load-to-status.patch && \

#cp build-fixes/target.linux.ipq806x.patches-5.15.999-998-bbr-plus-tsq.patch target/linux/ipq806x/patches-5.15/999-998-bbr-plus-tsq.patch && \
#git apply build-fixes\930-bbr-plus-tsq.patch && \
#cp build-fixes/package.network.services.dnsmasq.patches.900-strict-order-nxdomain.patch package/network/services/dnsmasq/patches/900-strict-order-nxdomain.patch && \

make clean && \

./scripts/feeds install -a && summarize_conf && \

#cp diff_base .config && make defconfig && \
#cp build-fixes/bak.config .config && \

./scripts/getver.sh && \

#make target/linux/compile -j $(($(nproc)+1)) && \
make -j $(($(nproc)+1)) download world