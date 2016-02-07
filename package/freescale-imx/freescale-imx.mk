################################################################################
#
# freescale-imx
#
################################################################################

FREESCALE_IMX_VERSION = 3.10.53-1.1.0
FREESCALE_IMX_SITE    = http://www.freescale.com/lgfiles/NMG/MAD/YOCTO/

include $(sort $(wildcard package/freescale-imx/*/*.mk))
