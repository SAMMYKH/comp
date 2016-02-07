################################################################################
#
# libungif
#
################################################################################
LIBUNGIF_VERSION:=5.0.6
LIBUNGIF_SOURCE:=giflib-$(LIBUNGIF_VERSION).tar.bz2
LIBUNGIF_SITE:=http://downloads.sourceforge.net/sourceforge/giflib
LIBUNGIF_INSTALL_STAGING = YES
LIBUNGIF_CONF_OPT = --without-x
LIBUNGIF_LICENSE = MIT
LIBUNGIF_LICENSE_FILES = COPYING

LIBUNGIF_BINS = gif2epsn gif2ps gif2rgb gif2x11 gifasm gifbg gifburst gifclip \
		gifclrmp gifcolor gifcomb gifcompose giffiltr giffix gifflip  \
		gifhisto gifinfo gifinter gifinto gifovly gifpos gifrotat     \
		gifrsize gifspnge giftext gifwedge icon2gif raw2gif rgb2gif   \
		text2gif

define LIBUNGIF_BINS_CLEANUP
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,$(LIBUNGIF_BINS))
endef

LIBUNGIF_POST_INSTALL_TARGET_HOOKS += LIBUNGIF_BINS_CLEANUP

$(eval $(autotools-package))
