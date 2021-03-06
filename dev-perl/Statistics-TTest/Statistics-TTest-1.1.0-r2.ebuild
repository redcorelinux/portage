# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=YUNFANG
DIST_VERSION=1.1.0

inherit perl-module

DESCRIPTION="module to compute the confidence interval"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-perl/Statistics-Distributions-1.20.0
	>=dev-perl/Statistics-Descriptive-3.60.300
"
BDEPEND="${RDEPEND}
"
