################################################################################
#
# netsnmp
#
################################################################################

NETSNMP_VERSION = 5.7.2.1
NETSNMP_SITE = http://downloads.sourceforge.net/project/net-snmp/net-snmp/$(NETSNMP_VERSION)
NETSNMP_SOURCE = net-snmp-$(NETSNMP_VERSION).tar.gz
NETSNMP_LICENSE = Various BSD-like
NETSNMP_LICENSE_FILES = COPYING
NETSNMP_INSTALL_STAGING = YES
NETSNMP_CONF_ENV = ac_cv_NETSNMP_CAN_USE_SYSCTL=yes
NETSNMP_CONF_OPT = --with-persistent-directory=/var/lib/snmp \
		--with-defaults --enable-mini-agent --without-rpm \
		--with-logfile=none --without-kmem-usage $(DISABLE_IPV6) \
		--enable-as-needed --without-perl-modules \
		--disable-embedded-perl --disable-perl-cc-checks \
		--disable-scripts --with-default-snmp-version="1" \
		--enable-silent-libtool --enable-mfd-rewrites \
		--with-sys-contact="root@localhost" \
		--with-sys-location="Unknown" \
		--with-mib-modules="$(call qstrip,$(BR2_PACKAGE_NETSNMP_WITH_MIB_MODULES))" \
		--with-out-mib-modules="$(call qstrip,$(BR2_PACKAGE_NETSNMP_WITHOUT_MIB_MODULES))" \
		--with-out-transports="Unix" \
		--disable-manuals
NETSNMP_INSTALL_STAGING_OPT = DESTDIR=$(STAGING_DIR) LIB_LDCONFIG_CMD=true install
NETSNMP_INSTALL_TARGET_OPT = DESTDIR=$(TARGET_DIR) LIB_LDCONFIG_CMD=true install
NETSNMP_MAKE = $(MAKE1)
NETSNMP_CONFIG_SCRIPTS = net-snmp-config

NETSNMP_BLOAT_MIBS = BRIDGE DISMAN-EVENT DISMAN-SCHEDULE DISMAN-SCRIPT EtherLike RFC-1215 RFC1155-SMI RFC1213 SCTP SMUX

ifeq ($(BR2_ENDIAN),"BIG")
	NETSNMP_CONF_OPT += --with-endianness=big
else
	NETSNMP_CONF_OPT += --with-endianness=little
endif

# OpenSSL
ifeq ($(BR2_PACKAGE_OPENSSL),y)
	NETSNMP_DEPENDENCIES += openssl
	NETSNMP_CONF_OPT += \
		--with-openssl=$(STAGING_DIR)/usr/include/openssl
ifeq ($(BR2_PREFER_STATIC_LIB),y)
	# openssl uses zlib, so we need to explicitly link with it when static
	NETSNMP_CONF_ENV += LIBS=-lz
endif
else
	NETSNMP_CONF_OPT += --without-openssl
endif

ifneq ($(BR2_PACKAGE_NETSNMP_ENABLE_MIBS),y)
	NETSNMP_CONF_OPT += --disable-mib-loading
	NETSNMP_CONF_OPT += --disable-mibs
endif

ifneq ($(BR2_PACKAGE_NETSNMP_ENABLE_DEBUGGING),y)
	NETSNMP_CONF_OPT += --disable-debugging
endif

# Remove IPv6 MIBs if there's no IPv6
ifneq ($(BR2_INET_IPV6),y)
define NETSNMP_REMOVE_MIBS_IPV6
	rm -f $(TARGET_DIR)/usr/share/snmp/mibs/IPV6*
endef

NETSNMP_POST_INSTALL_TARGET_HOOKS += NETSNMP_REMOVE_MIBS_IPV6
endif

define NETSNMP_REMOVE_BLOAT_MIBS
	for mib in $(NETSNMP_BLOAT_MIBS); do \
		rm -f $(TARGET_DIR)/usr/share/snmp/mibs/$$mib-MIB.txt; \
	done
endef

NETSNMP_POST_INSTALL_TARGET_HOOKS += NETSNMP_REMOVE_BLOAT_MIBS

define NETSNMP_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/netsnmp/S59snmpd \
		$(TARGET_DIR)/etc/init.d/S59snmpd
endef

define NETSNMP_STAGING_NETSNMP_CONFIG_FIXUP
	$(SED) 	"s,^includedir=.*,includedir=\'$(STAGING_DIR)/usr/include\',g" \
		-e "s,^libdir=.*,libdir=\'$(STAGING_DIR)/usr/lib\',g" \
		$(STAGING_DIR)/usr/bin/net-snmp-config
endef

NETSNMP_POST_INSTALL_STAGING_HOOKS += NETSNMP_STAGING_NETSNMP_CONFIG_FIXUP

NETSNMP_DEPENDENCIES += host-python python host-python-setuptools

define NETSNMP_BUILD_PYTHON
	(cd $(@D)/python; \
	    PATH=$(BR_PATH) \
	    STAGING_DIR=$(STAGING_DIR) \
		CC=$(TARGET_CC) \
		CFLAGS="$(TARGET_CFLAGS)" \
		LD=$(TARGET_LD) \
		LDFLAGS=$(TARGET_LDFLAGS) \
		LDSHARED="$(TARGET_CROSS)gcc -shared" \
		PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages \
		$(HOST_DIR)/usr/bin/python setup.py build \
		    --basedir=$(@D))
endef

NETSNMP_POST_BUILD_HOOKS += NETSNMP_BUILD_PYTHON

define NETSNMP_INSTALL_PYTHON
	(cd $(@D)/python; \
	    STAGING_DIR=$(STAGING_DIR) \
	    PYTHONPATH=$(TARGET_DIR)/usr/lib/python$(PYTHON_VERSION_MAJOR)/site-packages \
		$(HOST_DIR)/usr/bin/python setup.py install \
	        --prefix=$(TARGET_DIR)/usr \
	        --old-and-unmanageable)
endef

NETSNMP_POST_INSTALL_TARGET_HOOKS += NETSNMP_INSTALL_PYTHON

$(eval $(autotools-package))
