EAPI=2

inherit git autotools eutils

DESCRIPTION="Distributed OpenMAX for OMAP4 processors"
HOMEPAGE="http://dev.omapzoom.org/?p=tisyslink/userspace-syslink.git;a=summary"
DEPEND=">=media-libs/syslink-24.11"
LICENSE="BSD"
KEYWORDS="arm"
SLOT="0"
IUSE=""

SRC_URI=""
NPV=${PV/_/-}; NPV=${NPV^^}
EGIT_REPO_URI="git://git.omapzoom.org/platform/hardware/ti/syslink.git"
EGIT_BRANCH="syslink-2.0"
# FIXME: Can't use tags?
#EGIT_COMMIT="ti-syslink-mpu-rls-${NPV}"
EGIT_COMMIT="16f0cebd8b5a430d943bc6bcfa0fe592bad425b9"
S="${WORKDIR}/${P}/syslink/d2c"

src_unpack() {
	MY_S="${WORKDIR}/${P}"
	S=${MY_S} git_src_unpack
}

src_prepare() {
	cd ${S} && ./bootstrap.sh
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}"
}
