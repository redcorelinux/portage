# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="https://github.com/tessus/apachetop"
SRC_URI="https://github.com/tessus/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc sparc x86"
IUSE="fam pcre"

RDEPEND="
	sys-libs/ncurses:0=
	sys-libs/readline:0=
	fam? ( virtual/fam )
	pcre? ( dev-libs/libpcre )"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-0.19.7-c++17.patch
)

src_configure() {
	econf \
		--with-logfile="${EPREFIX}"/var/log/apache2/access_log \
		--without-adns \
		$(use_with fam) \
		$(use_with pcre)
}
