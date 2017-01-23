# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils font git-r3

EGIT_REPO_URI="https://github.com/google/fonts.git"

DESCRIPTION="Collection of Google's Web Fonts"
HOMEPAGE="https://github.com/google/fonts https://www.google.com/fonts"

LICENSE="Apache-2.0 OFL-1.1 UbuntuFontLicense-1.0"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="sys-apps/findutils"

src_prepare() {
	# better install media-fonts/cantarell
	rm -rf "${WORKDIR}/${P}/ofl/cantarell"
	# better install media-fonts/crimson
	rm -rf "${WORKDIR}/${P}/ofl/crimsontext"
}

src_install() {
	insinto ${FONTDIR}
	find "${WORKDIR}/${P}/" -type f -iname '*.ttf' | while read fontfilename ; do doins "$fontfilename" || die "Could not install '$fontfilename'" ; done
	find "${WORKDIR}/${P}/" -type f -iname '*.otf' | while read fontfilename ; do doins "$fontfilename" || die "Could not install '$fontfilename'" ; done

	use X && font_xfont_config
	font_fontconfig

	# TODO documentation
}

