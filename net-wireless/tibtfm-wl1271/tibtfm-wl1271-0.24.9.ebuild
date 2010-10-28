# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211-firmware/zd1211-firmware-1.4.ebuild,v 1.2 2007/11/03 12:03:19 dsd Exp $

EAPI="2"

inherit eutils

MY_P="${PN}_${PV}"

DESCRIPTION="Texas Instruments WiLinkTM solution (WL1271) applications"
HOMEPAGE="https://gforge.ti.com/gf/project/wilink_drivers/"
BASE_URI="https://launchpad.net/~tiomap-dev/+archive/release/+files"
SRC_URI="${BASE_URI}/${MY_P}.orig.tar.gz"
SRC_URI="${SRC_URI} ${BASE_URI}/${MY_P}-0ubuntu6.diff.gz"



LICENSE="TI-TSPA-v1"
SLOT="0"
KEYWORDS="arm"

IUSE=""
RDEPEND="net-wireless/tibtfm-wl1271-firmware"
DEPEND="${RDEPEND}"

src_prepare() {
	cd ${WORKDIR}

	epatch ${MY_P}*.diff
	cd "${S}"
	epatch "${S}"/debian/patches/*.patch
}

src_compile() {
	cd "${S}"/uim
	make -j1
}

src_install() {
	cd "${S}"
	dobin uim/uim

	newinitd "${FILESDIR}"/${PN}.init ${PN}
}
