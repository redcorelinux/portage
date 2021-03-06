# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Text-based, multi-protocol instant messenger"
HOMEPAGE="https://github.com/ekg2/ekg2/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ekg2/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gadu gpm gpg gtk minimal ncurses nls nntp openssl
	perl readline rss spell sqlite ssl xmpp unicode zlib"

RDEPEND="dev-libs/glib:2
	gadu? ( <net-libs/libgadu-1.12:0= )
	gpg? ( app-crypt/gpgme:= )
	gtk? ( x11-libs/gtk+:2 )
	nls? ( virtual/libintl:0= )
	openssl? ( dev-libs/openssl:0= )
	perl? ( dev-lang/perl:0= )
	readline? ( sys-libs/readline:0= )
	rss? ( dev-libs/expat:0= )
	ssl? ( net-libs/gnutls:0= )
	xmpp? ( dev-libs/expat:0= )
	zlib? ( sys-libs/zlib:0= )

	ncurses? ( sys-libs/ncurses:=[unicode(+)=]
		gpm? ( sys-libs/gpm:0= )
		spell? ( app-text/aspell:0= ) )
	sqlite? ( dev-db/sqlite:3= )"

DEPEND="${RDEPEND}
	sys-devel/gettext"

DOCS=(
	AUTHORS README.md docs/README docs/TODO
	docs/events.txt docs/mouse.txt docs/sim.txt docs/voip.txt
	docs/themes.txt docs/themes-en.txt
	docs/ui-ncurses.txt docs/ui-ncurses-en.txt
)

pkg_pretend() {
	if ! use gtk && ! use ncurses && ! use readline; then
		ewarn 'ekg2 is being compiled without any frontend. You should consider'
		ewarn 'enabling at least one of following USEflags:'
		ewarn '  gtk, ncurses, readline.'
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		# direct plugin references
		$(use_enable gadu gg)
		$(use_enable gpg)
		$(use_enable gtk)
		$(use_enable ncurses)
		$(use_enable nntp)
		$(use_enable openssl sim)
		$(use_enable perl)
		--disable-python
		$(use_enable readline)
		$(use_enable rss)
		$(use_enable sqlite logsqlite)
		$(use_enable xmpp jabber)

		$(use_enable !minimal autoresponder)
		$(use_enable !minimal jogger)
		$(use_enable !minimal mail)
		$(use_enable !minimal polchat)
		$(use_enable !minimal rivchat)
		$(use_enable !minimal sms)

		# sqlite switch
		--with-sqlite3

		# optional deps
		$(use_with gpm)
		# do not pass --with-inotify as it will fail if check fails
		$(use_with spell aspell)
		$(use_with ssl gnutls)
		$(use_with zlib)

		# other magic
		$(use_enable nls)
		--with-perl-module-build-flags='INSTALLDIRS=vendor'
		--enable-fast-configure
	)
	econf "${myconf[@]}"
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
