# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=MOTEMEN
DIST_VERSION=0.03
inherit perl-module

DESCRIPTION="Compare JSON with Test::Deep"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Exporter-Lite
	dev-perl/JSON
	dev-perl/Test-Deep
"
DEPEND="${RDEPEND}
	>=dev-perl/Module-Build-0.380.0
	virtual/perl-CPAN-Meta
	test? (
		>=virtual/perl-ExtUtils-MakeMaker-6.590.0
		virtual/perl-Test-Simple
	)
"
