# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=GTERMARS
DIST_VERSION=0.13
inherit perl-module

DESCRIPTION="XS based CSS minifier"

SLOT="0"
KEYWORDS="amd64 ~riscv ~x86"

BDEPEND="
	virtual/perl-ExtUtils-MakeMaker
"
