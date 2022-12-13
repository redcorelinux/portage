# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="Chirurgien helps to understand and manipulate file formats"
HOMEPAGE="https://github.com/leonardschardijn/Chirurgien/"
SRC_URI="https://github.com/leonardschardijn/${PN^}/archive/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}"/${P^}

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	gui-libs/gtk:4
	dev-libs/glib:2
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream-glib
	dev-util/desktop-file-utils
"

src_install() {
	meson_src_install

	mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
