#############################################################
#
# mrwa-xbee-comms
#
#############################################################

MRWA_XBEE_COMMS_VERSION=master
MRWA_XBEE_COMMS_SITE=git@git.axent.com.au:mrwa/mrwa_xbee_comms.git
MRWA_XBEE_COMMS_SITE_METHOD=git
MRWA_XBEE_COMMS_INSTALL_TARGET=YES
MRWA_XBEE_COMMS_DEPENDENCIES=libxbee sqlite zlib openssl

$(eval $(call cmake-package))
