# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit git autotools eutils libtool

DESCRIPTION="TI TILER Memory Manager"
HOMEPAGE="http://dev.omapzoom.org/?p=tiler/tiler-userspace.git;a=summary"
#DEPEND=""
LICENSE="BSD"
KEYWORDS="arm"
SLOT="0"
IUSE=""

SRC_URI=""
NPV=${PV/_/-}; NPV=${NPV^^}
EGIT_REPO_URI="git://git.omapzoom.org/platform/hardware/ti/tiler.git"
EGIT_BRANCH="memmgr_1.0"
# FIXME: Can't use tags?
#EGIT_COMMIT="${NPV}"
EGIT_COMMIT="d74be6020e970228f6bd25112fde12ecb4322f65"
S="${WORKDIR}/${P}/memmgr"

src_unpack() {
	MY_S="${WORKDIR}/${P}"
	S=${MY_S} git_src_unpack
}

src_prepare() {
	cd ${S} && ./bootstrap.sh
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}
