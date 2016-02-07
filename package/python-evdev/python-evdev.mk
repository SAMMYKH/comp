################################################################################
#
# python-evdev
#
################################################################################

PYTHON_EVDEV_VERSION = 0.4.7
PYTHON_EVDEV_SOURCE  = evdev-$(PYTHON_EVDEV_VERSION).tar.gz
PYTHON_EVDEV_SITE    = https://pypi.python.org/packages/source/e/evdev
PYTHON_EVDEV_LICENSE = MIT
PYTHON_EVDEV_LICENSE_FILES = README
PYTHON_EVDEV_SETUP_TYPE = setuptools

$(eval $(python-package))
