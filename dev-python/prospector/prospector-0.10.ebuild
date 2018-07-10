# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit eutils distutils-r1

DESCRIPTION="Inspects Python source files about type and location of classes, methods..."
HOMEPAGE="https://github.com/landscapeio/prospector/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/pycares[${PYTHON_USEDEP}]"

python_test() {
    esetup.py test
}
