# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils multilib versionator

# Create a major/minor combo for our SLOT and executables suffix
PV_MAJ_MIN=$(get_version_component_range '1-2')

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
MY_P=${P%%_*}
SRC_URI="http://${PN}.freedesktop.org/src/${PN}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2"
SLOT=${PV_MAJ_MIN}
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+introspection nls test"

RDEPEND=">=dev-libs/glib-2.20:2
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	!<media-libs/gst-plugins-base-0.10.26"
	# ^^ queue2 move, mustn't have both libgstcoreleements.so and libgstqueue2.so at runtime providing the element at once
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	nls? ( sys-devel/gettext )"

src_configure() {
	# Disable static archives, dependency tracking and examples
	# to speed up build time
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--disable-valgrind \
		--disable-examples \
		--enable-check \
		$(use_enable introspection) \
		$(use_enable test tests) \
		--with-package-name="GStreamer ebuild for Gentoo" \
		--with-package-origin="http://packages.gentoo.org/package/media-libs/gstreamer"
}

src_prepare() {
	cd ${S}
	epatch "${FILESDIR}"/gst-0.10.32-0001-gst-launch-add-loop-argument.patch
	epatch "${FILESDIR}"/gst-0.10.32-0002-Changes-to-make-it-possible-to-LD_PRELOAD-libttif.patch
	epatch "${FILESDIR}"/gst-0.10.32-0003-add-GstQueryBuffers-query.patch
	epatch "${FILESDIR}"/gst-0.10.32-0004-Add-GstEventCrop-event.patch
	epatch "${FILESDIR}"/gst-0.10.32-0005-basetransform-don-t-do-unnecessary-pad_alloc.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS MAINTAINERS README RELEASE

	# Remove unversioned binaries to allow SLOT installations in future
	cd "${D}"/usr/bin
	local gst_bins
	for gst_bins in $(ls *-${PV_MAJ_MIN}); do
		rm -f ${gst_bins/-${PV_MAJ_MIN}/}
	done
}
