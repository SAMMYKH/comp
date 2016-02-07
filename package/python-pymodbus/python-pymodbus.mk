################################################################################
#
# python-pymodbus
#
################################################################################

PYTHON_PYMODBUS_VERSION = 1.2.0
PYTHON_PYMODBUS_SOURCE  = v$(PYTHON_PYMODBUS_VERSION).tar.gz
PYTHON_PYMODBUS_SITE    = https://github.com/bashwork/pymodbus/archive/
PYTHON_PYMODBUS_LICENSE = MIT
PYTHON_PYMODBUS_LICENSE_FILES = LICENSE
PYTHON_PYMODBUS_SETUP_TYPE = setuptools

$(eval $(python-package))
