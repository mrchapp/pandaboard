# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211-firmware/zd1211-firmware-1.4.ebuild,v 1.2 2007/11/03 12:03:19 dsd Exp $

EAPI="2"

inherit eutils linux-mod

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
RDEPEND="net-wireless/tiwlan-wl1271-firmware"
DEPEND="${RDEPEND}"


pkg_setup() {
    linux-mod_pkg_setup

}

src_prepare() {
	cd ${WORKDIR}

	epatch ${MY_P}*.diff
	cd "${S}"
	epatch "${S}"/debian/patches/*.patch

	cd wlan
	cp wlan/Makefile .
}

src_compile() {
	cd wlan
        # compile modules
        emake -j1 KERNEL_HEADERS=${KV_DIR} || die

        # compile utils
        cd CUDK
        emake -j1 || die
}

src_install() {
#	cd "${S}"
	insinto /etc/udev/rules.d/
	newins debian/tiwlan-wl1271-dkms.udev 40-tiwlan-wl1271.rules
	
	cd wlan/CUDK/output/
	newbin tiwlan_loader tiwlan_loader_wl1271
	newbin wlan_cu wlan_cu_wl1271
	cd ../../platforms/os/linux/
	insinto /lib/firmware/tiwlan-wl1271
	doins tiwlan.ini tiwlan_dual.ini

	cd "${S}"/wlan
        insinto /lib/modules/${KV_FULL}/kernel/drivers/net/wireless/tiwlan-wl1271
        doins sdio.ko tiwlan_drv.ko

}
