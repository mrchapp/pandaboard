EAPI=1

# order is important, gnome2 after gst-plugins
inherit gst-plugins-base gst-plugins10 gnome2 flag-o-matic autotools eutils
# libtool

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.sourceforge.net"
MY_P=${P%%_*}
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+introspection +orc"

RDEPEND=">=dev-libs/glib-2.20
	=media-libs/gstreamer-0.10.32_p20110127
	dev-libs/libxml2
	app-text/iso-codes
	orc? ( >=dev-lang/orc-0.4.5 )
	!<media-libs/gst-plugins-bad-0.10.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gtk-doc-am"

GST_PLUGINS_BUILD=""

DOCS="AUTHORS NEWS README RELEASE"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gst-0.10.32-0001-add-rowstride-support-to-video-utility-functions.patch
	epatch "${FILESDIR}"/gst-0.10.32-0002-stridetransform-skeletal-implementation-of-stridetra.patch
	epatch "${FILESDIR}"/gst-0.10.32-0003-stridetransform-implement-caps-negotiation-and-relat.patch
	epatch "${FILESDIR}"/gst-0.10.32-0004-stridetransform-implement-transform-function.patch
	epatch "${FILESDIR}"/gst-0.10.32-0005-add-gst_stride_transform_transform_size.patch
	epatch "${FILESDIR}"/gst-0.10.32-0006-fix-a-small-typo.-need-to-use-the-smaller-of-new_wid.patch
	epatch "${FILESDIR}"/gst-0.10.32-0007-Add-NV12-support-in-stridetransform.patch
	epatch "${FILESDIR}"/gst-0.10.32-0008-add-basic-support-for-I420-NV12-colorspace-conversio.patch
	epatch "${FILESDIR}"/gst-0.10.32-0009-fix-to-avoid-parsing-caps-on-every-frame.patch
	epatch "${FILESDIR}"/gst-0.10.32-0010-refactor-stridetransform-to-make-it-easier-to-add-ne.patch
	epatch "${FILESDIR}"/gst-0.10.32-0011-add-some-neon.patch
	epatch "${FILESDIR}"/gst-0.10.32-0012-add-support-to-convert-to-YUY2-YUYV-color-format.patch
	epatch "${FILESDIR}"/gst-0.10.32-0013-Add-support-for-RGB565-to-stridetransform.patch
	epatch "${FILESDIR}"/gst-0.10.32-0014-stridetransform-updates-for-new-extra-anal-compiler-.patch
	epatch "${FILESDIR}"/gst-0.10.32-0015-stridetransform-fix-problem-transforming-caps-with-l.patch
	epatch "${FILESDIR}"/gst-0.10.32-0016-modify-playbin-to-use-stridetransform.patch
	epatch "${FILESDIR}"/gst-0.10.32-0017-playbin-disable-interlaced-support.patch
	epatch "${FILESDIR}"/gst-0.10.32-0018-textoverlay-add-stride-support.patch
	epatch "${FILESDIR}"/gst-0.10.32-0019-video-more-flexible-video-caps-utility.patch
	epatch "${FILESDIR}"/gst-0.10.32-0020-video-fix-endianess-issue-for-16bit-RGB-formats.patch
	epatch "${FILESDIR}"/gst-0.10.32-0021-stride-more-flexible-stride-color-conversion.patch
	epatch "${FILESDIR}"/gst-0.10.32-0022-stride-support-for-32bit-RGB-formats.patch
	epatch "${FILESDIR}"/gst-0.10.32-0023-ffmpegcolorspace-support-for-rowstride.patch
	eautoreconf
}

src_compile() {
	# gst doesnt handle opts well, last tested with 0.10.15
	strip-flags
	replace-flags "-O3" "-O2"

	gst-plugins-base_src_configure \
		--disable-nls \
		$(use_enable introspection) \
		$(use_enable orc)
	emake || die "emake failed."
}

src_install() {
	gnome2_src_install
}
