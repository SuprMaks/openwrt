obj-$(CONFIG_NV_TEGRA_MC) += mc/

ifeq ($(CONFIG_CPU_FREQ),y)
obj-$(CONFIG_ARCH_TEGRA_21x_SOC) += cpu_emc.o
endif

obj-y					+= tegra_prod.o
obj-y                   += tegra-safety-build.o