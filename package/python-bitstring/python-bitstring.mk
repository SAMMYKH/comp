#############################################################
#
# python-bitstring
#
#############################################################

PYTHON_BITSTRING_VERSION = 3.0.2
PYTHON_BITSTRING_SOURCE  = bitstring-$(PYTHON_BITSTRING_VERSION).zip
PYTHON_BITSTRING_SITE    = https://python-bitstring.googlecode.com/files/

PYTHON_BITSTRING_DEPENDENCIES = python

define PYTHON_BITSTRING_EXTRACT_CMDS
	(unzip -o $(DL_DIR)/$(PYTHON_BITSTRING_SOURCE) -d $(PYTHON_BITSTRING_DIR); \
	 mv $(PYTHON_BITSTRING_DIR)/bitstring-3.0.2/* $(PYTHON_BITSTRING_DIR); \
	 rm -rf $(PYTHON_BITSTRING_DIR)/bitstring-3.0.2)
endef

define PYTHON_BITSTRING_BUILD_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py build)
endef

define PYTHON_BITSTRING_INSTALL_TARGET_CMDS
	(cd $(@D); $(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr)
endef

$(eval $(call generic-package))
