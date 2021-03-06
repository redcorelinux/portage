# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SLOT="0"
DESCRIPTION="FSF Emacs compatibility files"
XEMACS_PKG_CAT="standard"

KEYWORDS="~alpha amd64 arm64 ~hppa ppc ppc64 ~riscv sparc x86"

inherit xemacs-packages

RDEPEND="app-xemacs/xemacs-base
"
