#############################################################
#
# pygobject
#
#############################################################
PYGOBJECT_VERSION_MAJOR = 2.28
PYGOBJECT_VERSION_MINOR = 6
PYGOBJECT_VERSION = $(PYGOBJECT_VERSION_MAJOR).$(PYGOBJECT_VERSION_MINOR)
PYGOBJECT_SOURCE = pygobject-$(PYGOBJECT_VERSION).tar.bz2
PYGOBJECT_SITE = http://ftp.gnome.org/pub/GNOME/sources/pygobject/$(PYGOBJECT_VERSION_MAJOR)
PYGOBJECT_INSTALL_STAGING = YES
PYGOBJECT_INSTALL_TARGET = YES
PYGOBJECT_DEPENDENCIES = python host-python libglib2
PYGOBJECT_AUTORECONF = YES

PYGOBJECT_CONF_ENV = \
	PYTHON_INCLUDES="-I${STAGING_DIR}/usr/include/python$(PYTHON_VERSION_MAJOR)"
PYGOBJECT_CONF_OPT = \
    --enable-thread \
    --disable-introspection

SED_STRING = 's:datarootdir=:&${STAGING_DIR}:'

# Fix codegendir variable in pkgconfig file and prefix in pygobject-codegen-2.0
define PYGOBJECT_FIX_STAGING
	sed -i $(SED_STRING) $(STAGING_DIR)/usr/lib/pkgconfig/pygobject-2.0.pc
	sed -i 's:prefix=:&${STAGING_DIR}:' $(STAGING_DIR)/usr/bin/pygobject-codegen-2.0
endef

PYGOBJECT_POST_INSTALL_STAGING_HOOKS += PYGOBJECT_FIX_STAGING

define PYGOBJECT_FIX_TARGET_PCFILE
	sed -i $(SED_STRING) $(TARGET_DIR)/usr/lib/pkgconfig/pygobject-2.0.pc
endef

PYGOBJECT_POST_INSTALL_TARGET_HOOKS += PYGOBJECT_FIX_TARGET_PCFILE

$(eval $(autotools-package))
