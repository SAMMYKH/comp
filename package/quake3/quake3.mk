################################################################################
#
# quake3
#
################################################################################

QUAKE3_VERSION = fd7b5ee460
QUAKE3_SITE = https://github.com/raspberrypi/quake3.git
QUAKE3_SITE_METHOD = git
QUAKE3_DEPENDENCIES = libegl curl libopenal xlib_libX11 jpeg libvorbis

define QUAKE3_BUILD_CMDS
	$(MAKE) -f Makefile_ubuntu -C $(@D) $(TARGET_CONFIGURE_OPTS) ARCH=arm \
	    CFLAGS="-DVCMODS_MISC -DVCMODS_NOSDL -DVCMODS_OPENGLES \
	            -DVCMODS_DEPTH -DVCMODE_STARTKHRONOS -DVCMODS_REPLACETRIG \
	            -fPIC $(TARGET_CFLAGS)" \
	    LDFLAGS="-shared -L$(STAGING_DIR)/usr/lib $(TARGET_LDFLAGS)"
endef

define QUAKE3_INSTALL_TARGET_CMDS
    $(MAKE) -f Makefile_ubuntu -C $(@D) copyfiles \
        $(TARGET_CONFIGURE_OPTS) ARCH=arm \
	    CFLAGS="-DVCMODS_MISC -DVCMODS_NOSDL -DVCMODS_OPENGLES \
	            -DVCMODS_DEPTH -DVCMODE_STARTKHRONOS -DVCMODS_REPLACETRIG \
	            -fPIC $(TARGET_CFLAGS)" \
	    COPYDIR=$(TARGET_DIR)/usr/games/quake3 \
	    INSTALL=$(INSTALL)
endef


$(eval $(generic-package))
