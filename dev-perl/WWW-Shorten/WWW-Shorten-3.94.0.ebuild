# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=CAPOEIRAB
DIST_VERSION=3.094
DIST_EXAMPLES=("examples/*")
inherit perl-module

DESCRIPTION="Interface to URL shortening sites"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	examples? (
		dev-perl/Config-Auto
		>=virtual/perl-Getopt-Long-2.400.0
		>=dev-perl/Try-Tiny-0.240.0
	)
	virtual/perl-Carp
	>=dev-perl/libwww-perl-5.835.0
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=virtual/perl-Test-Simple-0.880.0
		>=dev-perl/Try-Tiny-0.240.0
	)
"

src_prepare() {
	einfo "Downgrading 'shorten' to an example"
	mkdir -p "${S}/examples"  || die
	mv "${S}/bin/shorten" "${S}/examples/" || die
	sed -i -e '/bin\/shorten/d' "${S}/Makefile.PL" || die
	sed -i -e 's/^bin\/shorten$/examples\/shorten/' "${S}/MANIFEST" || die
	perl-module_src_prepare
}
