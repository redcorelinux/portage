# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} )

inherit cmake edo lua-single xdg

MY_PN="CorsixTH"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Open source clone of Theme Hospital"
HOMEPAGE="https://corsixth.com"
if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="https://github.com/${MY_PN}/${MY_PN}"
	inherit git-r3
else
	SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"

	if [[ ${PV} != *_beta* && ${PV} != *_rc* ]] ; then
		KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
	fi
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc +midi +sound test tools +truetype +videos"
RESTRICT="!test? ( test )"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}
	$(lua_gen_cond_dep '
		>=dev-lua/luafilesystem-1.5[${LUA_USEDEP}]
		>=dev-lua/lpeg-0.9[${LUA_USEDEP}]
		>=dev-lua/luasocket-3.0_rc1-r4[${LUA_USEDEP}]
	')
	media-libs/libsdl2[opengl,video]
	sound? ( media-libs/sdl2-mixer[midi?] )
	truetype? ( >=media-libs/freetype-2.5.3:2 )
	videos? ( >=media-video/ffmpeg-2.2.3:0= )
"

DEPEND="${RDEPEND}"

# Although the docs could potentially be built with nearly any Lua version,
# we need to ensure the necessary Lua modules are installed, so pin to the
# same single version as runtime.
BDEPEND="
	virtual/pkgconfig
	doc? (
		app-text/doxygen[dot]
		${LUA_DEPS}
		$(lua_gen_cond_dep '
			>=dev-lua/luafilesystem-1.5[${LUA_USEDEP}]
			>=dev-lua/lpeg-0.9[${LUA_USEDEP}]
		')
	)
	test? (
		>=dev-cpp/catch-3:0
	)
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.67-cmake_lua_detection.patch
)

lua_enable_tests busted

src_configure() {
	local mycmakeargs=(
		-DLUA_VERSION=$(lua_get_version)
		-DBUILD_TOOLS=$(usex tools)
		-DENABLE_UNIT_TESTS=$(usex test)
		-DWITH_AUDIO=$(usex sound)
		-DWITH_FREETYPE2=$(usex truetype)
		-DWITH_MOVIES=$(usex videos)
		-DWITH_UPDATE_CHECK=OFF
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile doc
}

src_test() {
	# https://github.com/CorsixTH/CorsixTH/blob/master/.github/workflows/Linux.yml#L88
	# C++ tests
	BUILD_DIR="${BUILD_DIR}"/CorsixTH cmake_src_test

	# Lua tests
	edo busted --lua="${ELUA}" --output="TAP" --verbose --directory=CorsixTH/Luatest
}

src_install() {
	cmake_src_install
	dodoc changelog.txt CONTRIBUTING.md

	docinto html
	use doc && dodoc -r "${BUILD_DIR}"/doc/*
}
