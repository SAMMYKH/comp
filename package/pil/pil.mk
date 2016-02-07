#############################################################
#
# python imaging library
#
#############################################################
PIL_VERSION=1.1.7
PIL_SOURCE=Imaging-$(PIL_VERSION).tar.gz
PIL_SITE=http://effbot.org/downloads/
PIL_DEPENDENCIES=python
PIL_SETUP_TYPE=distutils

$(eval $(python-package))
