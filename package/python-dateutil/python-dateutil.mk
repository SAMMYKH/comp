#############################################################
#
# python-dateutil
#
#############################################################

PYTHON_DATEUTIL_VERSION = 1.5
PYTHON_DATEUTIL_SOURCE  = python-dateutil-$(PYTHON_DATEUTIL_VERSION).tar.gz
PYTHON_DATEUTIL_SITE    = http://labix.org/download/python-dateutil/

PYTHON_DATEUTIL_DEPENDENCIES = python host-python-setuptools

define PYTHON_DATEUTIL_BUILD_CMDS
    (cd $(@D); export STAGING_DIR=$(STAGING_DIR); \
     $(HOST_DIR)/usr/bin/python setup.py build --executable=/usr/bin/python)
endef

define PYTHON_DATEUTIL_INSTALL_TARGET_CMDS
    (cd $(@D); export STAGING_DIR=$(STAGING_DIR); \
     $(HOST_DIR)/usr/bin/python setup.py install --prefix=$(TARGET_DIR)/usr)
endef

$(eval $(call generic-package))
