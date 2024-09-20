#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

base_conf() {
    # Base from https://downloads.openwrt.org/releases/23.05.4/targets/ipq806x/generic/config.buildinfo
    cp -fr $SCRIPT_DIR/"config/base_build_package_diff.config" .config && \
    cat $SCRIPT_DIR/"config/base_build_env_diff.config" >> .config && \
    make defconfig
}

summarize_conf() {
    rm -f .config && \

    # Disable basic modular packages
    cp -fr $SCRIPT_DIR/"config/base_build_package_diff.config" .config && \
    cat $SCRIPT_DIR/"config/base_build_env_diff.config" >> .config && \
    head -n 9 $SCRIPT_DIR/"config/my_diff.config" | tee -a .config && \
    make defconfig && cat .config | grep --perl-regexp '.+(?==m)' --only-matching | sed -r 's/.+/# & is not set/' | tee .config && \

    # Base from https://downloads.openwrt.org/releases/23.05.4/targets/ipq806x/generic/config.buildinfo
    # cp -fr $SCRIPT_DIR/"config/base_build_package_diff.config" .config && \
    cat $SCRIPT_DIR/"config/base_build_package_diff.config" >> .config && \

    cat $SCRIPT_DIR/"config/project_specific_diff.config" >> .config && \
    cat $SCRIPT_DIR/"config/my_diff.config" >> .config && \
    
    cat $SCRIPT_DIR/"config/my_zapret_diff.config" >> .config && \
    cat $SCRIPT_DIR/"config/my_test_diff.config" >> .config && \

    # Base from https://downloads.openwrt.org/releases/23.05.4/targets/ipq806x/generic/config.buildinfo
    cat $SCRIPT_DIR/"config/base_build_env_diff.config" >> .config && \

    cat $SCRIPT_DIR/"config/env_diff.config" >> .config
 }