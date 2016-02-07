################################################################################
#
# xdriver_xf86-video-imx-viv
#
################################################################################

XDRIVER_XF86_VIDEO_IMX_VIV_VERSION = 3.10.53-1.1.0
XDRIVER_XF86_VIDEO_IMX_VIV_SOURCE = xserver-xorg-video-imx-viv-$(XDRIVER_XF86_VIDEO_IMX_VIV_VERSION).tar.gz
XDRIVER_XF86_VIDEO_IMX_VIV_SITE = http://www.freescale.com/lgfiles/NMG/MAD/YOCTO/
XDRIVER_XF86_VIDEO_IMX_VIV_LICENSE = MIT
XDRIVER_XF86_VIDEO_IMX_VIV_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_IMX_VIV_DEPENDENCIES = xserver_xorg-server xproto_fontsproto xproto_randrproto xproto_renderproto xproto_videoproto xproto_xproto

XDRIVER_XF86_VIDEO_IMX_VIV_CFLAGS = \
    -I../../DRI_1.10.4/src \
    $(TARGET_CFLAGS)

define XDRIVER_XF86_VIDEO_IMX_VIV_BUILD_CMDS
	(cd $(@D); \
	 $(TARGET_CONFIGURE_OPTS) \
	 CROSS_COMPILE=$(TARGET_CROSS) \
	 CC=$(CC) \
	 CFLAGS="$(XDRIVER_XF86_VIDEO_IMX_VIV_CFLAGS)" \
	 XSERVER_GREATER_THAN_13=1 \
	 BUSID_HAS_NUMBER=1 \
	 ./fastbuild.sh sysroot=$(STAGING_DIR) BUILD_HARD_VFP=1 )
endef

define XDRIVER_XF86_VIDEO_IMX_VIV_INSTALL_TARGET_CMDS
	(cd $(@D); \
	 $(TARGET_CONFIGURE_OPTS) \
     CROSS_COMPILE=$(TARGET_CROSS) \
	 CC=$(CC) \
 	 CFLAGS="$(XDRIVER_XF86_VIDEO_IMX_VIV_CFLAGS)" \
	 XSERVER_GREATER_THAN_13=1 \
	 BUSID_HAS_NUMBER=1 \
	 ./fastbuild.sh prefix=$(TARGET_DIR)/usr install )
endef

$(eval $(generic-package))
