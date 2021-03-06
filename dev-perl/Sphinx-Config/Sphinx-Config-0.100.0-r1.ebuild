# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=JJSCHUTZ
DIST_VERSION=0.10
inherit perl-module

DESCRIPTION="Sphinx search engine configuration file read/modify/write"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="
	virtual/perl-Carp
	dev-perl/List-MoreUtils
	virtual/perl-Storable
"
BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple )
"

src_test() {
	perl_rm_files "t/pod-coverage.t" "t/boilerplate.t" "t/pod.t"
	perl-module_src_test
}
