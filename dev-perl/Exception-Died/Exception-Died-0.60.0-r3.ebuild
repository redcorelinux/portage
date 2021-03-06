# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=DEXTER
DIST_VERSION=0.06
DIST_EXAMPLES=( "eg/*" )
inherit perl-module

DESCRIPTION="Convert simple die into real exception object"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-perl/constant-boolean
	>=dev-perl/Exception-Base-0.210.0"
BDEPEND="${RDEPEND}
	dev-perl/Module-Build
	test? ( virtual/perl-parent
		>=dev-perl/Test-Unit-Lite-0.110.0
		>=dev-perl/Test-Assert-0.50.0
	)
"
