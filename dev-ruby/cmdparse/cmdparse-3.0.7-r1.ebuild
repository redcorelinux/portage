# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

IUSE=""

DESCRIPTION="Advanced command line parser supporting commands"
HOMEPAGE="https://cmdparse.gettalong.org/"

KEYWORDS="~amd64 ~ppc64 ~x86"
LICENSE="MIT"
SLOT="3"
