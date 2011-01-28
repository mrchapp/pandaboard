# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gst-plugins-good

DESCRIPION="Plug-in to allow capture from video4linux2 (V4L2) devices"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32_p20110127"
DEPEND="${RDEPEND}
	virtual/os-headers"

GST_PLUGINS_BUILD="gst_v4l2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gst-0.10.27-0001-v4l2-fix-handling-of-RGB32-BGR32-formats.patch
	epatch "${FILESDIR}"/gst-0.10.27-0002-v4l2sink-Add-rotation-support.patch
	epatch "${FILESDIR}"/gst-0.10.27-0003-v4l2sink-Add-flip-property.patch
	epatch "${FILESDIR}"/gst-0.10.27-0004-v4l2sink-Add-support-for-omap24xxvout-driver.patch
	epatch "${FILESDIR}"/gst-0.10.27-0005-v4l2sink-Add-support-for-omap_vout-driver.patch
	epatch "${FILESDIR}"/gst-0.10.27-0006-v4l2-increase-v4l2sink-element-rank.patch
	epatch "${FILESDIR}"/gst-0.10.27-0007-use-GstQueryBuffers-to-get-buffer-requirements.patch
	epatch "${FILESDIR}"/gst-0.10.27-0008-add-rowstride-support.patch
	epatch "${FILESDIR}"/gst-0.10.27-0009-use-GstEventCrop-to-get-crop-info.patch
	epatch "${FILESDIR}"/gst-0.10.27-0010-v4l2-prefer-NV12.patch
	epatch "${FILESDIR}"/gst-0.10.27-0011-v4l2sink-fix-issue-seen-with-autoconvert.patch
	epatch "${FILESDIR}"/gst-0.10.27-0099-v4l2sink-Define-rotation-if-kernel-header-doesnt.patch
}
