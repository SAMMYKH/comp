#############################################################
#
# gst-python
#
#############################################################
GST_PYTHON_VERSION = 0.10.22
GST_PYTHON_SOURCE = gst-python-$(GST_PYTHON_VERSION).tar.gz
GST_PYTHON_SITE = http://gstreamer.freedesktop.org/src/gst-python
GST_PYTHON_INSTALL_TARGET = YES
GST_PYTHON_DEPENDENCIES = python gstreamer pygtk
GST_PYTHON_AUTORECONF = YES

GST_PYTHON_CONF_ENV = \
	PYTHON_INCLUDES="-I${STAGING_DIR}/usr/include/python$(PYTHON_VERSION_MAJOR)"

$(eval $(autotools-package))
