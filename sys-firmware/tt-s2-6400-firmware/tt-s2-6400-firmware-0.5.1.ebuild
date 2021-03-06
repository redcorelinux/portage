# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmware for the Technotrend S2-6400 DVB Card"
HOMEPAGE="http://www.aregel.de/"
SRC_URI="http://www.aregel.de/file_download/28/dvb-ttpremium-st7109-01_v0_5_1.zip
	http://www.aregel.de/file_download/26/dvb-ttpremium-fpga-01_v1_10.zip
	http://www.aregel.de/file_download/7/dvb-ttpremium-loader-01_v1_03.zip"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror bindist"

BDEPEND="app-arch/unzip"

src_install() {
	insinto /lib/firmware
	doins dvb-ttpremium-fpga-01.fw dvb-ttpremium-loader-01.fw dvb-ttpremium-st7109-01.fw
}
