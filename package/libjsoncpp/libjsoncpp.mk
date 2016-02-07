################################################################################
#
# libjsoncpp
#
################################################################################

LIBJSONCPP_VERSION = 1.6.1
LIBJSONCPP_SITE = https://github.com/open-source-parsers/jsoncpp/archive
LIBJSONCPP_SOURCE = $(LIBJSONCPP_VERSION).tar.gz
LIBJSONCPP_INSTALL_STAGING = YES
LIBJSONCPP_LICENSE = MIT
LIBJSONCPP_LICENSE_FILES = LICENSE
LIBJSONCPP_CONF_OPT +=	\
	-DJSONCPP_WITH_TESTS=OFF				\
	-DJSONCPP_WITH_POST_BUILD_UNITTEST=OFF

$(eval $(call cmake-package))
