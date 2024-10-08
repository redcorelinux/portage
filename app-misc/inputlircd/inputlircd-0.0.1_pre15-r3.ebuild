# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Inputlirc daemon to utilize /dev/input/event*"
HOMEPAGE="https://github.com/gsliepen/inputlirc"
SRC_URI="http://gentooexperimental.org/~genstef/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~loong ppc ppc64 ~riscv x86"

src_prepare() {
	local ver="$(best_version sys-kernel/linux-headers)"
	ver=${ver#sys-kernel/linux-headers-}
	if ver_test ${ver} -ge 4.4; then
		eapply "${FILESDIR}/inputlircd-linux-4.4-fix.patch"
	fi

	sed -e 's|$(CFLAGS)|$(CFLAGS) $(LDFLAGS)|' -i Makefile || die

	default
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install

	newinitd "${FILESDIR}"/inputlircd.init.2 inputlircd
	newconfd "${FILESDIR}"/inputlircd.conf inputlircd
}
