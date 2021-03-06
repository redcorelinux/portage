# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

KODI_PLUGIN_NAME="imagedecoder.raw"
DESCRIPTION="RAW image decoder for Kodi"
HOMEPAGE="https://github.com/xbmc/imagedecoder.raw"

case ${PV} in
9999)
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/xbmc/${KODI_PLUGIN_NAME}.git"
	inherit git-r3
	DEPEND="~media-tv/kodi-9999"
	;;
*)
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	CODENAME="Matrix"
	SRC_URI="https://github.com/xbmc/${KODI_PLUGIN_NAME}/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${KODI_PLUGIN_NAME}-${PV}-${CODENAME}"
	DEPEND="=media-tv/kodi-19*"
	;;
esac

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND+="
	>=media-libs/libjpeg-turbo-2.1.1
	>=media-libs/libraw-0.20.2[jpeg,lcms]
	>=media-libs/lcms-2.12
	"

RDEPEND="
	${DEPEND}
	"

src_prepare() {
	[ -d depends ] && rm -rf depends || die
	cmake_src_prepare
}
