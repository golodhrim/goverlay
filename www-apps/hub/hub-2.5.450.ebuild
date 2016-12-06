# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

DESCRIPTION="JetBrains Hub"
HOMEPAGE="http://www.jetbrains.com/hub/"
MY_WAR="hub-ring-bundle-${PV}.zip"
SRC_URI="http://download.jetbrains.com/hub/$(get_version_component_range 1-2)/${MY_WAR} -> hub-${PV}.zip"

LICENSE=""
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	true;
}

src_install() {
	dodir /usr/share/teamcity
	cp ${DISTDIR}/${MY_WAR} ${D}/usr/share/teamcity/teamcity-${SLOT}.war
}
