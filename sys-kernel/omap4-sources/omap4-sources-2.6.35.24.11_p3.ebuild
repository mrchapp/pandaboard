# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ETYPE="sources"

inherit kernel-2 git versionator
detect_version

MY_PV="ti-$(get_version_component_range 1-3)-omap4-L$(get_version_component_range 4-5)-$(get_version_component_range 6)"

EGIT_REPO_URI="git://dev.omapzoom.org/pub/scm/integration/kernel-omap4.git"

EGIT_COMMIT="${MY_PV}"


DESCRIPTION="OMAP4 sources"
HOMEPAGE="http://dev.omapzoom.org/?p=integration/kernel-omap4.git;a=summary"

KEYWORDS="arm"
