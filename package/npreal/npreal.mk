#############################################################
#
# npreal
#
#############################################################

NPREAL_VERSION=cc323ac61fc38d65dc08cfa2f74c4d9edcb54f6c
NPREAL_SITE=git@git.axent.com.au:ag13008/npreal.git
NPREAL_SITE_METHOD=git
NPREAL_INSTALL_TARGET=YES
NPREAL_DEPENDENCIES=linux

obj-m += npreal2.o

define NPREAL_KMOD_BUILD_CMDS
    $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define NPREAL_KMOD_INSTALL_TARGET_COMMANDS
    $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

NPREAL_POST_BUILD_HOOKS += NPREAL_KMOD_BUILD_CMDS
NPREAL_POST_INSTALL_TARGET_HOOKS += NPREAL_KMOD_INSTALL_TARGET_COMMANDS

$(eval $(call cmake-package))
