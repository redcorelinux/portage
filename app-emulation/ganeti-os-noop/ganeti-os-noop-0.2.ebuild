# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dummy OS provider for Ganeti"
HOMEPAGE="https://github.com/grnet/ganeti-os-noop"
SRC_URI="https://github.com/grnet/ganeti-os-noop/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	dodoc CONTRIBUTORS
	cd ganeti/os/noop || die
	insinto /usr/share/ganeti/os/noop/
	doins ganeti_api_version
	exeinto /usr/share/ganeti/os/noop/
	doexe create export import rename
}
