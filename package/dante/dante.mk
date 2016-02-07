################################################################################
#
# dante
#
################################################################################

DANTE_VERSION = es2
DANTE_SITE = https://github.com/AreaScout/dante-doom3-odroid.git
DANTE_SITE_METHOD = git
DANTE_DEPENDENCIES = host-scons libegl curl libopenal xlib_libX11 jpeg libvorbis

DANTE_SCONS_ENV = $(TARGET_CONFIGURE_OPTS)
DANTE_SCONS_OPTS = \
	ARCH=$(ARCH) \
	CC=$(TARGET_CC) \
	CXX=$(TARGET_CXX) \
	prefix=/usr \
	sysroot=$(STAGING_DIR) \
	TARGET_ANDROID=0 \
	TARGET_D3XP=1 \
	TARGET_DEMO=0 \
	BASEFLAGS='$(TARGET_CPPFLAGS)' \
	BUILD=release \

define DANTE_BUILD_CMDS
	(cd $(@D)/neo; \
		$(DANTE_SCONS_ENV) \
		$(SCONS) \
		$(DANTE_SCONS_OPTS))
endef

define DANTE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(STRIP) -m 755 $(@D)/neo/doom.arm $(TARGET_DIR)/usr/games/dante/doom3
	$(INSTALL) -D $(STRIP) -m 755 $(@D)/neo/gamearm-base.so $(TARGET_DIR)/usr/games/dante/base/gamearm.so
	$(INSTALL) -D $(STRIP) -m 755 $(@D)/neo/gamearm-d3xp.so $(TARGET_DIR)/usr/games/dante/d3xp/gamearm.so
	(cd $(TARGET_DIR)/usr/games/dante/base; \
		$(WGET) https://github.com/AreaScout/dante-doom3-odroid/raw/gh-pages/config/DoomConfig.cfg; \
		cp DoomConfig.cfg ../d3xp; \
		$(GIT) clone --quiet --depth 1 https://github.com/AreaScout/gl2progs.git)
endef

$(eval $(generic-package))
