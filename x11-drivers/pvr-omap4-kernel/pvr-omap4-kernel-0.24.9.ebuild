# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211-firmware/zd1211-firmware-1.4.ebuild,v 1.2 2007/11/03 12:03:19 dsd Exp $

EAPI="3"

inherit eutils linux-mod

DESCRIPTION="PowerVR SGX540 kernel driver for OMAP4"

HOMEPAGE=""
SRC_URI="https://launchpad.net/~tiomap-dev/+archive/release/+files/${PN}_${PV}.orig.tar.gz
https://launchpad.net/~tiomap-dev/+archive/release/+files/${PN}_${PV}-2.diff.gz"


LICENSE="TI"
SLOT="0"
KEYWORDS="arm"

IUSE=""
DEPEND=""

S="${WORKDIR}/${P}/sgx"
RESTRICT="strip"

src_prepare() {
	cd "${WORKDIR}"
	epatch *.diff
	
	cd "${S}/.."
	epatch debian/patches/*.patch
}

src_compile() {
#	cd eurasiacon/build/linux/omap4430_linux/kbuild/
	
	export SUPPORT_XORG=1
	emake -j1 KERNELDIR="${KV_DIR}" LDFLAGS="" || die
}

src_install() {
	insinto /lib/modules/${KV_FULL}/kernel/extra
#	doins eurasiacon/binary_omap4430_linux_release/pvrsrvkm.ko
	doins pvrsrvkm.ko
}
