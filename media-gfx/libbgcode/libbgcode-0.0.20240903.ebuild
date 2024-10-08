# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

LIBBGCODE_COMMIT=3db61e45713932b4a9cdd469aa567d65e0095d00

DESCRIPTION="Prusa Block & Binary G-code reader / writer / converter"
HOMEPAGE="https://github.com/prusa3d/libbgcode"
SRC_URI="https://github.com/prusa3d/libbgcode/archive/${LIBBGCODE_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${LIBBGCODE_COMMIT}"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/heatshrink-0.4.1
	>=sys-libs/zlib-1.0
"
DEPEND="${RDEPEND}
	dev-libs/boost
	test? ( =dev-cpp/catch-2*:0 )
"

src_configure() {
	local mycmakeargs=(
		-DLibBGCode_BUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}
