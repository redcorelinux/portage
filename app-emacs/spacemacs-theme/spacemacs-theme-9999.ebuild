# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit elisp

DESCRIPTION="Emacs color theme that started as a theme for Spacemacs"
HOMEPAGE="https://github.com/nashamri/spacemacs-theme/"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/nashamri/${PN}.git"
else
	SRC_URI="https://github.com/nashamri/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"

ELISP_REMOVE="
	spacemacs-theme-pkg.el
"

SITEFILE="50${PN}-gentoo.el"
