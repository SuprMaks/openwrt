ARCH:=aarch64
BOARDNAME:=Tegra with Cortex-A57
CPU_TYPE:=cortex-a57
CPU_SUBTYPE:=neon-vfpv4
KERNELNAME:=Image dtbs

FEATURES+=arm64_erratum_1319367 arm64_erratum_832075

define Target/Description
        Build firmware images for nVIDIA Tegra (Cortex-A57) based boards.
endef
