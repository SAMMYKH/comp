################################################################################
#
# libxbee
#
################################################################################

LIBXBEE_VERSION = 3.0.11
LIBXBEE_SITE = https://github.com/attie/libxbee3/archive/
LIBXBEE_SOURCE = v$(LIBXBEE_VERSION).tar.gz
LIBXBEE_LICENSE = LGPLv3
LIBXBEE_LICENSE_FILES = COPYING

LIBXBEE_INSTALL_STAGING = YES

define LIBXBEE_CONFIGURE_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		-C $(@D) configure
endef

define LIBXBEE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		-C $(@D)
endef

define LIBXBEE_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		INSTALL=$(INSTALL) \
		-C $(@D) SYS_ROOT=$(STAGING_DIR) install
endef

define LIBXBEE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/include
	$(TARGET_MAKE_ENV) $(MAKE) \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		INSTALL=$(INSTALL) \
		-C $(@D) SYS_ROOT=$(TARGET_DIR) install
endef

$(eval $(generic-package))
