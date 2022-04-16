# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3 python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Sans-I/O implementation of SOCKS4, SOCKS4A, and SOCKS5"
HOMEPAGE="https://pypi.org/project/socksio/ https://github.com/sethmlarson/socksio"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 hppa ~ia64 ppc ppc64 ~riscv ~s390 sparc x86"

distutils_enable_tests pytest

src_prepare() {
	# remove coverage args for tests
	rm pytest.ini || die

	distutils-r1_src_prepare
}
