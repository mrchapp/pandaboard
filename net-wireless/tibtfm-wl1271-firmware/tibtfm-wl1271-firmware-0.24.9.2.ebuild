# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211-firmware/zd1211-firmware-1.4.ebuild,v 1.2 2007/11/03 12:03:19 dsd Exp $

DESCRIPTION="Firmware for Texas Instruments WiLinkTM solution (WL1271)"

HOMEPAGE="https://gforge.ti.com/gf/project/wilink_drivers/"
SRC_URI="https://launchpad.net/~tiomap-dev/+archive/release/+files/${PN}_${PV}.orig.tar.gz"


LICENSE="TI-TSPA-v1"
SLOT="0"
KEYWORDS="arm"

IUSE=""
DEPEND=""


src_install() {
	insinto /lib/firmware/
	doins init_scripts/*
}
