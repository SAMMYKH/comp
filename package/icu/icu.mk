################################################################################
#
# icu
#
################################################################################

ICU_VERSION = 51.2
ICU_SOURCE = icu4c-$(subst .,_,$(ICU_VERSION))-src.tgz
ICU_SITE = http://download.icu-project.org/files/icu4c/$(ICU_VERSION)
ICU_LICENSE = ICU License
ICU_LICENSE_FILES = license.html

ICU_DEPENDENCIES = host-icu
ICU_INSTALL_STAGING = YES
ICU_CONFIG_SCRIPTS = icu-config
ICU_CONF_OPT = --with-cross-build=$(HOST_ICU_DIR)/source --disable-samples \
		--disable-tests
HOST_ICU_CONF_OPT = \
	--disable-samples \
	--disable-tests \
	--disable-extras \
	--disable-icuio \
	--disable-layout \
	--disable-renaming
ICU_MAKE = $(MAKE1)
ICU_SUBDIR = source
HOST_ICU_SUBDIR = source

define ICU_PREFIX_FIXUP
	$(SED) "s,^default_prefix=.*,default_prefix=\'$(STAGING_DIR)/usr\',g" \
		-e "s,^exec_prefix=.*,exec_prefix=\'$(STAGING_DIR)/usr\',g" \
		$(STAGING_DIR)/usr/bin/icu-config
endef

ICU_POST_INSTALL_TARGET_HOOKS += ICU_PREFIX_FIXUP

define ICU_UPDATE_BIN
    cp package/icu/icudt44l.dat $(@D)/source/data/in
endef

ICU_PRE_CONFIGURE_HOOKS += ICU_UPDATE_BIN

$(eval $(autotools-package))
$(eval $(host-autotools-package))