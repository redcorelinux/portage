# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="An application for working with the Microchip PicKit2 PIC programmer"
HOMEPAGE="http://www.microchip.com/pickit2"
SRC_URI="http://ww1.microchip.com/downloads/en/DeviceDoc/${PN}v${PV}LinuxMacSource.tar.gz"
S="${WORKDIR}/${PN}v${PV}LinuxMacSource"

LICENSE="MicroChip-PK2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86"

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-add-share-dir-for-dev-file-${PV}.patch
)

src_prepare() {
	default

	# Fix up the Makefile
	sed \
		-e 's:#TARGET=linux:TARGET=linux:' \
		-e 's:DBG=-O2:DBG=:' \
		-e 's:^CFLAGS=:CFLAGS+=:' \
		-e 's:^LDFLAGS=:LDFLAGS+=:' \
		-e 's:^LIBUSB=/usr/local:LIBUSB=/usr:' \
		-e "s:^CC=g++::" \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCXX)"
}

src_install() {
	# Copy the device files and PicKit2 OS
	insinto /usr/share/pk2
	doins PK2DeviceFile.dat PK2V023200.hex
	# Install the program
	dobin pk2cmd
	# Install the documentation
	dodoc ReadmeForPK2CMDLinux2-6.txt usbhotplug.txt
}
