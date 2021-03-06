# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=CHLIGE
DIST_VERSION=0.96
inherit perl-module

DESCRIPTION="Module for DNS service discovery (Apple's Bonjour)"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="examples"

RDEPEND="
	>=dev-perl/Net-DNS-0.500.0
	>=virtual/perl-Socket-1.750.0
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (	virtual/perl-Test-Simple )
"

src_install() {
	perl-module_src_install
	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		docinto examples
		dodoc -r demo/*
	fi
}
