################################################################################
#
# python-zope-interface
#
################################################################################

PYTHON_ZOPE_INTERFACE_VERSION = 4.1.0
PYTHON_ZOPE_INTERFACE_SOURCE  = zope.interface-$(PYTHON_ZOPE_INTERFACE_VERSION).tar.gz
PYTHON_ZOPE_INTERFACE_SITE    = https://pypi.python.org/packages/source/z/zope.interface/
PYTHON_ZOPE_INTERFACE_SETUP_TYPE = distutils

$(eval $(python-package))
