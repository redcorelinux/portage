# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.6.2
inherit ecm frameworks.kde.org

DESCRIPTION="Qt wrapper for Bluez 5 DBus API"

LICENSE="LGPL-2"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[dbus,network]
	>=dev-qt/qtdeclarative-${QTMIN}:6
"
RDEPEND="${DEPEND}"

src_test() {
	local CMAKE_SKIP_TESTS=(
		# bug 668196, hangs
		managertest
	)
	# parallel tests fail, bug 609248
	ecm_src_test -j1
}
