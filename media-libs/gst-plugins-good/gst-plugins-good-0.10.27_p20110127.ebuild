# order is important, gnome2 after gst-plugins
inherit gst-plugins-good gst-plugins10 gnome2 eutils flag-o-matic libtool

DESCRIPTION="Set of Good plug-ins for GStreamer"
HOMEPAGE="http://gstreamer.net/"
MY_P=${P%%_*}
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.32
	>=media-libs/gstreamer-0.10.32
	>=dev-libs/liboil-0.3.14
	sys-libs/zlib
	app-arch/bzip2"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	dev-util/pkgconfig
	!<media-libs/gst-plugins-bad-0.10.19"

# Always enable optional bz2 support for matroska
# Always enable optional zlib support for qtdemux, id3demux and matroska
# Many media files require these to work, as some container headers are often compressed, bug 291154
GST_PLUGINS_BUILD="bz2 zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gst-0.10.27-0001-v4l2-fix-handling-of-RGB32-BGR32-formats.patch
	epatch "${FILESDIR}"/gst-0.10.27-0002-v4l2sink-Add-rotation-support.patch
	epatch "${FILESDIR}"/gst-0.10.27-0003-v4l2sink-Add-flip-property.patch
	epatch "${FILESDIR}"/gst-0.10.27-0004-v4l2sink-Add-support-for-omap24xxvout-driver.patch
	epatch "${FILESDIR}"/gst-0.10.27-0005-v4l2sink-Add-support-for-omap_vout-driver.patch
	epatch "${FILESDIR}"/gst-0.10.27-0006-v4l2-increase-v4l2sink-element-rank.patch
	epatch "${FILESDIR}"/gst-0.10.27-0007-use-GstQueryBuffers-to-get-buffer-requirements.patch
	epatch "${FILESDIR}"/gst-0.10.27-0008-add-rowstride-support.patch
	epatch "${FILESDIR}"/gst-0.10.27-0009-use-GstEventCrop-to-get-crop-info.patch
	epatch "${FILESDIR}"/gst-0.10.27-0010-v4l2-prefer-NV12.patch
	epatch "${FILESDIR}"/gst-0.10.27-0011-v4l2sink-fix-issue-seen-with-autoconvert.patch
	epatch "${FILESDIR}"/gst-0.10.27-0099-v4l2sink-Disable-rotation-code-when-not-found.patch
}

src_compile() {
	# gst doesnt handle optimisations well
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # see bug 22249

	gst-plugins-good_src_configure \
		--with-default-audiosink=autoaudiosink \
		--with-default-visualizer=goom

	emake || die "emake failed."
}

# override eclass
src_install() {
	gnome2_src_install
}

DOCS="AUTHORS ChangeLog NEWS README RELEASE"

pkg_postinst () {
	gnome2_pkg_postinst

	echo
	elog "The GStreamer plugins setup has changed quite a bit on Gentoo,"
	elog "applications now should provide the basic plugins needed."
	echo
	elog "The new seperate plugins are all named 'gst-plugins-<plugin>'."
	elog "To get a listing of currently available plugins execute 'emerge -s gst-plugins-'."
	elog "In most cases it shouldn't be needed though to emerge extra plugins."
}

pkg_postrm() {
	gnome2_pkg_postrm
}
