#!/usr/bin/env bash
#make target/compile package/{qca-nss-gmac,qca-nss-drv,qca-nss-clients,qca-nss-ecm}/{clean,compile} V=s -j10
#cp build-fixes/feeds.nss.qca-nss-clients.Makefile feeds/nss/qca-nss-clients/Makefile
#cp build-fixes/feeds.nss.qca-nss-ecm.Makefile feeds/nss/qca-nss-ecm/Makefile
make clean
#make distclean
#./scripts/feeds update -f nss && ./scripts/feeds install -a -p nss && \
./scripts/feeds update -a && \
cp build-fixes/feeds.nss.qca-nss-clients.Makefile feeds/nss/qca-nss-clients/Makefile && \
cp build-fixes/feeds.nss.qca-nss-ecm.Makefile feeds/nss/qca-nss-ecm/Makefile && \
cp build-fixes/package_feeds_luci_luci-mod-status_patches_990-add-nss-load-to-status.patch package/feeds/luci/luci-mod-status/patches/990-add-nss-load-to-status.patch && \

#cp build-fixes/target.linux.ipq806x.patches-5.15.999-998-bbr-plus-tsq.patch target/linux/ipq806x/patches-5.15/999-998-bbr-plus-tsq.patch && \
#git apply build-fixes\930-bbr-plus-tsq.patch && \
#cp build-fixes/package.network.services.dnsmasq.patches.900-strict-order-nxdomain.patch package/network/services/dnsmasq/patches/900-strict-order-nxdomain.patch && \
./scripts/feeds install -a && \
patch --verbose -p0 < ./build-fixes/curl_wolfssl_quic_tls13.patch && \
#cp diff_base .config && make defconfig && \
./scripts/getver.sh && \
make -j $(nproc) download world