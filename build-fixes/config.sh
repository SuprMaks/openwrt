#!/usr/bin/env bash

base_conf() {
    # Base from https://downloads.openwrt.org/releases/23.05.4/targets/ipq806x/generic/config.buildinfo
    cp config/base_build_package_diff.config .config && \
    cat config/base_build_env_diff.config >> .config && \
}

summarize_conf() {    
    # Base from https://downloads.openwrt.org/releases/23.05.4/targets/ipq806x/generic/config.buildinfo
    cp config/base_build_package_diff.config .config && \

    cat config/project_specific_diff.config >> .config && \
    cat config/my_diff.config >> .config && \
    
    cat config/my_zapret_diff.config >> .config && \
    cat config/my_test_diff.config >> .config && \

    # Base from https://downloads.openwrt.org/releases/23.05.4/targets/ipq806x/generic/config.buildinfo
    cat config/base_build_env_diff.config >> .config && \

    cat config/env_diff.config >> .config && \

    make defconfig
}