# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


ETYPE="sources"

inherit kernel-2 versionator
detect_version

MY_PV="$(get_version_component_range 1-3)-$(get_version_component_range 4-5)"


DESCRIPTION="OMAP4 sources"
HOMEPAGE=""
SRC_URI="http://ports.ubuntu.com/ubuntu-ports/pool/main/l/linux-ti-omap4/linux-ti-omap4_${MY_PV}.tar.gz"

KEYWORDS="arm"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	mv ubuntu-maverick linux-${PV}-omap4

}

src_install() {
	insinto /usr/src/
	doins -r linux-${PV}-omap4
}
