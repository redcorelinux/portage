# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="File comparision, ignoring small numeric differences and formats"
HOMEPAGE="https://www.nongnu.org/numdiff/"
SRC_URI="https://savannah.nongnu.org/download/numdiff/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+nls +gmp"

RDEPEND="
	gmp? ( dev-libs/gmp:0= )
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-5.9.0-fix-build-system.patch
	"${FILESDIR}"/${PN}-5.9.0-fix-autoconf-2.71.patch
)

src_prepare() {
	default
	# yes, it really only needs eautoconf, due to the
	# config.h being hand-written, which would be bulldozered
	# when running eautoreconf (due to it invoking autoheader)
	eautoconf
}

src_configure() {
	econf \
	    --enable-optimization \
		$(use_enable gmp) \
		$(use_enable nls)
}
