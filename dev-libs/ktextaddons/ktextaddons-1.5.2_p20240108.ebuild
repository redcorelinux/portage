# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_QTHELP="true"
ECM_TEST="true"
KDE_ORG_COMMIT="8291d343a147fba5953240bac2054e1a462c23e9"
KFMIN=5.245.0
QTMIN=6.6.0
inherit ecm kde.org

DESCRIPTION="Various text handling addons"
HOMEPAGE="https://invent.kde.org/libraries/ktextaddons"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS="~amd64"
IUSE="speech"

RESTRICT="test"

DEPEND="
	>=dev-libs/qtkeychain-0.14.1-r1:=[qt6]
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtmultimedia-${QTMIN}:6
	>=kde-frameworks/karchive-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/sonnet-${KFMIN}:6
	>=kde-frameworks/syntax-highlighting-${KFMIN}:6
	speech? ( >=dev-qt/qtspeech-${QTMIN}:6 )
"
RDEPEND="${DEPEND}
	!${CATEGORY}/${PN}:5
"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package speech Qt6TextToSpeech)
	)
	ecm_src_configure
}
