#############################################################
#
# socketcan-tools
#
#############################################################
SOCKETCAN_TOOLS_VERSION := 4.0.6
SOCKETCAN_TOOLS_NAME := canutils-$(SOCKETCAN_TOOLS_VERSION)
SOCKETCAN_TOOLS_SOURCE := $(SOCKETCAN_TOOLS_NAME).tar.bz2
SOCKETCAN_TOOLS_SITE := http://www.pengutronix.de/software/socket-can/download/canutils/v4.0/

$(eval $(autotools-package))
