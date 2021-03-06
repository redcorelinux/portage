# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_EXTRADOC="History.markdown README.md"
RUBY_FAKEGEM_RECIPE_TEST="rspec3"

inherit ruby-fakegem

DESCRIPTION="Lightweight and flexible library for writing command-line apps"
HOMEPAGE="https://github.com/jekyll/mercenary"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
