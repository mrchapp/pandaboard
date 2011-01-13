EAPI=2

inherit git autotools eutils

DESCRIPTION="Distributed OpenMAX for OMAP4 processors"
HOMEPAGE="http://github.com/mrchapp/domx"
DEPEND=">=media-libs/syslink-24.11 >=media-libs/syslink-d2c-24.11"
LICENSE="BSD"
KEYWORDS="arm"
SLOT="0"
IUSE=""

SRC_URI=""
NPV=${PV/_/-}; NPV=${NPV^^}
EGIT_REPO_URI="git://github.com/mrchapp/domx.git"
EGIT_BRANCH="master"
# FIXME: Can't use tags?
#EGIT_COMMIT="L${NPV}"
EGIT_COMMIT="1378fb8e1b8304f401dfb1d6787ae13294d518ef"

src_prepare() {
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}"
}
