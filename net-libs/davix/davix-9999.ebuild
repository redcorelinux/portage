# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} python3_13t )

inherit cmake python-any-r1

DESCRIPTION="High-performance file management over WebDAV/HTTP"
HOMEPAGE="https://github.com/cern-fts/davix"
LICENSE="LGPL-2.1"

SLOT="0"
IUSE="doc test tools"

if [[ ${PV} =~ "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cern-fts/davix.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/cern-fts/${PN}/releases/download/R_${PV//./_}/${P}.tar.gz"
fi

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( tools )"

CDEPEND="
		dev-libs/libxml2:2=
		dev-libs/openssl:0=
		dev-libs/rapidjson:0=
		net-libs/gsoap[ssl,-gnutls]
		net-misc/curl:0=
		kernel_linux? ( sys-apps/util-linux )
"

DEPEND="${CDEPEND}"
BDEPEND="
		doc? (
			app-text/doxygen[dot]
			dev-python/sphinx
		)
		virtual/pkgconfig
		${PYTHON_DEPS}
"

RDEPEND="${CDEPEND}"

src_prepare() {
	cmake_src_prepare

	for x in doc test; do
		if ! use $x; then
			sed -i -e "/add_subdirectory ($x)/d" CMakeLists.txt
		fi
	done
}

src_configure() {
	local mycmakeargs=(
		-DPython_EXECUTABLE="${PYTHON}"
		-DDOC_INSTALL_DIR="${EPREFIX}/usr/share/doc/${P}"
		-DEMBEDDED_LIBCURL=OFF
		-DLIBCURL_BACKEND_BY_DEFAULT=OFF
		-DENABLE_HTML_DOCS=$(usex doc)
		-DENABLE_IPV6=TRUE
		-DENABLE_TCP_NODELAY=TRUE
		-DENABLE_THIRD_PARTY_COPY=TRUE
		-DENABLE_TOOLS=$(usex tools)
		-DHTML_INSTALL_DIR="${EPREFIX}/usr/share/doc/${P}/html"
		-DSOUND_INSTALL_DIR="${EPREFIX}/usr/share/${PN}/sounds"
		-DSTATIC_LIBRARY=OFF
		-DSYSCONF_INSTALL_DIR="${EPREFIX}/etc"
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	if use doc; then
		cmake_src_compile doc
	fi
}

src_install() {
	cmake_src_install
	if use test; then
		rm "${ED}/usr/bin/davix-unit-tests" || die
		rm "${ED}/usr/bin/davix-tester" || die
	fi
}
