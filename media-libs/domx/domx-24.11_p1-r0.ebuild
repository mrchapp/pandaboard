# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit git autotools eutils

DESCRIPTION="Distributed OpenMAX for OMAP4 processors"
HOMEPAGE="http://github.com/mrchapp/domx"
DEPEND=">=media-libs/syslink-24.11 >=media-libs/syslink-d2c-24.11"
LICENSE="BSD"
KEYWORDS="~arm"
SLOT="0"
IUSE=""

SRC_URI=""
NPV=${PV/_/-}; NPV=${NPV^^}
EGIT_REPO_URI="git://github.com/mrchapp/domx.git"
EGIT_BRANCH="master"
# FIXME: Can't use tags?
#EGIT_COMMIT="L${NPV}"
EGIT_COMMIT="858802175f65b99ff64329800400642d9b44aabf"

src_prepare() {
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}"
}
