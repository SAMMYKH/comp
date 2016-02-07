################################################################################
#
# libopenal
#
################################################################################
LIBOPENAL_VERSION=1.13
LIBOPENAL_SITE=http://kcat.strangesoft.net/openal-releases
LIBOPENAL_SOURCE=openal-soft-$(LIBOPENAL_VERSION).tar.bz2
LIBOPENAL_INSTALL_STAGING=YES

$(eval $(cmake-package))
