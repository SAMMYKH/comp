################################################################################
#
# python-wsgiref
#
################################################################################

PYTHON_WSGIREF_VERSION = 0.1.2
PYTHON_WSGIREF_SOURCE  = wsgiref-$(PYTHON_WSGIREF_VERSION).zip
PYTHON_WSGIREF_SITE    = https://pypi.python.org/packages/source/w/wsgiref/
PYTHON_WSGIREF_SETUP_TYPE = setuptools

define PYTHON_WSGIREF_EXTRACT_CMDS
	unzip -d $(@D) $(DL_DIR)/$(PYTHON_WSGIREF_SOURCE)
	mv $(@D)/wsgiref-$(PYTHON_WSGIREF_VERSION)/* $(@D)
	$(RM) -r $(@D)/wsgiref-$(PYTHON_WSGIREF_VERSION)
endef

$(eval $(python-package))
