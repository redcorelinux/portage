# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=KENTNL
DIST_VERSION=v0.5.3
inherit perl-module

DESCRIPTION="Find a development path somewhere in an upper hierarchy"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"

RDEPEND="
	virtual/perl-Carp
	>=dev-perl/Class-Tiny-0.10.0
	>=dev-perl/Path-IsDev-0.2.2
	>=dev-perl/Path-Tiny-0.54.0
	virtual/perl-Scalar-List-Utils
	dev-perl/Sub-Exporter
"

BDEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	!minimal? ( >=virtual/perl-ExtUtils-MakeMaker-7.0.0 )
	test? (
		!minimal? (
			>=virtual/perl-CPAN-Meta-2.120.900
			>=virtual/perl-Test-Simple-0.990.0
		)
		virtual/perl-File-Spec
		virtual/perl-Test-Simple
	)
"
