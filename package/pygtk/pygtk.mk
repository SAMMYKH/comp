#############################################################
#
# pygtk
#
#############################################################
PYGTK_VERSION_MAJOR = 2.24
PYGTK_VERSION_MINOR = 0
PYGTK_VERSION = $(PYGTK_VERSION_MAJOR).$(PYGTK_VERSION_MINOR)
PYGTK_SOURCE = pygtk-$(PYGTK_VERSION).tar.gz
PYGTK_SITE = http://ftp.acc.umu.se/pub/GNOME/sources/pygtk/$(PYGTK_VERSION_MAJOR)
PYGTK_INSTALL_STAGING = YES
PYGTK_DEPENDENCIES = python libglib2 libgtk2 pygobject
PYGTK_AUTORECONF = YES

SED_STRING = 's:datarootdir=:&${STAGING_DIR}:'

# Fix codegendir variable in pkgconfig file
define PYGTK_FIX_STAGING
	sed -i $(SED_STRING) $(STAGING_DIR)/usr/lib/pkgconfig/pygtk-2.0.pc
endef

PYGTK_POST_INSTALL_STAGING_HOOKS += PYGTK_FIX_STAGING

define PYGTK_FIX_TARGET_PCFILE
	sed -i $(SED_STRING) $(TARGET_DIR)/usr/lib/pkgconfig/pygtk-2.0.pc
endef

PYGTK_POST_INSTALL_TARGET_HOOKS += PYGTK_FIX_TARGET_PCFILE

PYGTK_CONF_ENV = \
	PYTHON_INCLUDES="-I${STAGING_DIR}/usr/include/python$(PYTHON_VERSION_MAJOR)"

$(eval $(autotools-package))
