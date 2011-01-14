# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git autotools

DESCRIPTION="GStreamer plug-in that allows communication with OpenMAX IL components"
HOMEPAGE="http://freedesktop.org/wiki/GstOpenMAX"
EGIT_REPO_URI="git://github.com/mrchapp/gst-openmax.git"
EGIT_BRANCH="gst-24.11-rc"
EGIT_COMMIT="3214d731aefae7d2b5f0b69f126dc993a972cfd4"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=">=media-libs/gst-plugins-base-0.10.31 >=media-libs/gstreamer-0.10.31 >=media-libs/domx-24.11"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
	cd ${S}
	epatch "${FILESDIR}"/0001-videoenc-use-shared-buffers-on-output-port.patch
	epatch "${FILESDIR}"/0002-Replace-deprecated-vstab-event-with-crop-event.patch
	epatch "${FILESDIR}"/0099-temp-32k-header-nov10.patch
}

src_prepare() {
	git describe --tags --always > .version
	eautoreconf
}

src_install() {
	emake DESTDIR=${D} install || die 'emake install failed.'
}
