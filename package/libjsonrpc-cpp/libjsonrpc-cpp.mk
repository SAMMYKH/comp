################################################################################
#
# libjsonrpc-cpp
#
################################################################################

LIBJSONRPC_CPP_VERSION = v0.4.2
LIBJSONRPC_CPP_SITE = https://github.com/cinemast/libjson-rpc-cpp/archive
LIBJSONRPC_CPP_SOURCE = $(LIBJSONRPC_CPP_VERSION).tar.gz
LIBJSONRPC_CPP_INSTALL_STAGING = YES
LIBJSONRPC_CPP_LICENSE = BSD-2c
LIBJSONRPC_CPP_LICENSE_FILES = license.txt
LIBJSONRPC_CPP_DEPENDENCIES = libcurl libpthread-stubs libjsoncpp libmicrohttpd
LIBJSONRPC_CPP_CONF_OPT =	\
	-DCOMPILE_TESTS=NO		\
	-DCOMPILE_STUBGEN=NO	\
	-DCOMPILE_EXAMPLES=NO

$(eval $(call cmake-package))
