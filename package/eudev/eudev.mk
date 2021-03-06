################################################################################
#
# eudev
#
################################################################################

EUDEV_VERSION = v1.7
EUDEV_SITE = $(call github,gentoo,eudev,$(EUDEV_VERSION))
EUDEV_LICENSE = GPLv2+ (programs), LGPLv2.1+ (libraries)
EUDEV_LICENSE_FILES = COPYING
EUDEV_INSTALL_STAGING = YES
EUDEV_AUTORECONF = YES

# mq_getattr is in librt
EUDEV_CONF_ENV += LIBS=-lrt

EUDEV_CONF_OPT =		\
	--disable-manpages	\
	--sbindir=/sbin		\
	--with-rootlibdir=/lib	\
	--libexecdir=/lib	\
	--with-firmware-path=/lib/firmware	\
	--disable-introspection			\
	--enable-split-usr			\
	--enable-libkmod

EUDEV_DEPENDENCIES = host-gperf host-pkgconf util-linux kmod
EUDEV_PROVIDES = udev

ifeq ($(BR2_PACKAGE_EUDEV_RULES_GEN),y)
EUDEV_CONF_OPT += --enable-rule_generator
endif

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
EUDEV_CONF_OPT += --enable-gudev
EUDEV_DEPENDENCIES += libglib2
else
EUDEV_CONF_OPT += --disable-gudev
endif

define EUDEV_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 package/eudev/S10udev $(TARGET_DIR)/etc/init.d/S10udev
endef

define EUDEV_REMOVE_HWDB
	rm -rf $(TARGET_DIR)/etc/udev/hwdb.d
endef

EUDEV_POST_INSTALL_TARGET_HOOKS += EUDEV_REMOVE_HWDB

$(eval $(autotools-package))
