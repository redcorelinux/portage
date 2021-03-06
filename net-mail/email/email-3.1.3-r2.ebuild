# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Advanced CLI tool for sending email"
HOMEPAGE="https://github.com/deanproxy/eMail"
SRC_URI="http://www.cleancode.org/downloads/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 x86"

PATCHES=(
	"${FILESDIR}"/${PN}-3.1.3-fno-common.patch
	"${FILESDIR}"/${PN}-3.1.3-fix-clang16-configure.patch
)

src_install() {
	default
	doman email.1
	dodoc README TODO
}
