#############################################################
#
# imageserver
#
#############################################################

IMAGESERVER_VERSION=d127146f2bf72a3beb349e60f011eae06e7b6913
IMAGESERVER_SITE=git@git.axent.com.au:ag14003/imageserver.git
IMAGESERVER_SITE_METHOD=git
IMAGESERVER_DEPENDENCIES=cairo libmicrohttpd

define IMAGESERVER_STARTUP_SCRIPT
    $(INSTALL) -m 0755 package/imageserver/S99imageserver $(TARGET_DIR)/etc/init.d
endef

IMAGESERVER_POST_INSTALL_TARGET_HOOKS += IMAGESERVER_STARTUP_SCRIPT

$(eval $(call cmake-package))
