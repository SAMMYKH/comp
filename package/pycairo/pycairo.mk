#############################################################
#
# pycairo
#
#############################################################
PYCAIRO_VERSION = 1.10.0
PYCAIRO_SOURCE = py2cairo-$(PYCAIRO_VERSION).tar.bz2
PYCAIRO_SITE = http://cairographics.org/releases/
PYCAIRO_DEPENDENCIES = python cairo
PYCAIRO_AUTORECONF = YES
PYCAIRO_INSTALL_STAGING = YES
PYCAIRO_CONF_ENV = PYTHON_INCLUDES="-I${STAGING_DIR}/usr/include/python$(PYTHON_VERSION_MAJOR)"

$(eval $(autotools-package))
