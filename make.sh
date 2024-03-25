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

#cp build-fixes/target.linux.ipq806x.patches-5.15.999-998-bbr-plus-tsq.patch target/linux/ipq806x/patches-5.15/999-998-bbr-plus-tsq.patch && \
#git apply build-fixes\930-bbr-plus-tsq.patch && \
#cp build-fixes/package.network.services.dnsmasq.patches.900-strict-order-nxdomain.patch package/network/services/dnsmasq/patches/900-strict-order-nxdomain.patch && \
./scripts/feeds install -a && \
#cp diff_base .config && make defconfig && \
./scripts/getver.sh && \
make -j $(nproc) download world