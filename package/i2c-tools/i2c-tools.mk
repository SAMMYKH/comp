################################################################################
#
# i2c-tools
#
################################################################################

I2C_TOOLS_VERSION = 3.1.1
I2C_TOOLS_SOURCE = i2c-tools-$(I2C_TOOLS_VERSION).tar.bz2
I2C_TOOLS_SITE = http://dl.lm-sensors.org/i2c-tools/releases
I2C_TOOLS_LICENSE = GPLv2+, GPLv2 (py-smbus)
I2C_TOOLS_LICENSE_FILES = COPYING

I2C_TOOLS_DEPENDENCIES = python

define I2C_TOOLS_BUILD_PYTHON
	(cd $(@D)/py-smbus; export STAGING_DIR=$(STAGING_DIR); \
		export CC=$(TARGET_CC); \
		export LD=$(TARGET_LD); \
		export LDFLAGS=$(TARGET_LDFLAGS); \
		export LDSHARED="$(TARGET_CC) -shared"; \
		CPPFLAGS="$(CPPFLAGS) -I../include" \
		$(HOST_DIR)/usr/bin/python setup.py build)
endef

I2C_TOOLS_POST_BUILD_HOOKS += I2C_TOOLS_BUILD_PYTHON

define I2C_TOOLS_BUILD_CMDS
 $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define I2C_TOOLS_INSTALL_TARGET_CMDS
	for i in i2cdump i2cget i2cset i2cdetect; \
	do \
		$(INSTALL) -m 755 -D $(@D)/tools/$$i $(TARGET_DIR)/usr/bin/$$i; \
	done
	(cd $(@D)/py-smbus; export STAGING_DIR=$(STAGING_DIR); \
	    $(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr)
endef

$(eval $(generic-package))
