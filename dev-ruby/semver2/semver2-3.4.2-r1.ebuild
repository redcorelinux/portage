# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_GEMSPEC="semver2.gemspec"

inherit ruby-fakegem

DESCRIPTION="maintain versions as per http://semver.org"
HOMEPAGE="https://github.com/haf/semver"
SRC_URI="https://github.com/haf/semver/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RUBY_S="semver-${PV}"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
