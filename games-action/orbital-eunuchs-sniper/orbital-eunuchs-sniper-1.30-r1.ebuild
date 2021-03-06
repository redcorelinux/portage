# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop

MY_P="${PN//-/_}-${PV}"
DESCRIPTION="Snipe terrorists from your orbital base"
HOMEPAGE="https://icculus.org/oes/"
SRC_URI="https://icculus.org/oes/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libsdl[joystick,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog readme.txt README TODO )

PATCHES=(
	"${FILESDIR}"/${P}-datadir.patch
	"${FILESDIR}"/${P}-gcc43.patch
)

src_prepare() {
	default

	sed -i \
		-e '/^sleep /d' \
		configure.ac || die
	eautoreconf
}

src_install() {
	default
	make_desktop_entry snipe2d "Orbital Eunuchs Sniper" applications-games
}
