# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://git.kernel.org/pub/scm/utils/dtc/dtc.git"
	inherit git-r3
else
	SRC_URI="https://www.kernel.org/pub/software/utils/${PN}/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
fi

DESCRIPTION="Open Firmware device tree compiler"
HOMEPAGE="https://devicetree.org/ https://git.kernel.org/cgit/utils/dtc/dtc.git/"

LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs test yaml"
RESTRICT="!test? ( test )"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"
RDEPEND="yaml? ( >=dev-libs/libyaml-0.2.3 )"
DEPEND="${RDEPEND}"

DOCS=(
	Documentation/dt-object-internal.txt
	Documentation/dts-format.txt
	Documentation/manual.txt
)

src_prepare() {
	default

	if ! use test ; then
		sed -i -e "/subdir('tests')/d" meson.build || die
	fi
}

src_configure() {
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
		-Dpython=disabled
		-Dtools=true
		-Dvalgrind=disabled # only used for some tests
		$(meson_feature yaml)
	)

	meson_src_configure
}
