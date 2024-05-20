# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="script to package go dependencies"
HOMEPAGE=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~mips ~ppc64 ~riscv ~s390 ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"

S="${WORKDIR}"

src_install() {
	newbin "${FILESDIR}/go-dep-tarball-0" go-dep-tarball
}
