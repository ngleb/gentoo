# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit cmake python-single-r1

MY_PN="libArcus"

DESCRIPTION="This library facilitates communication between Cura and its backend"
HOMEPAGE="https://github.com/Ultimaker/libArcus"
SRC_URI="https://github.com/Ultimaker/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/3"
KEYWORDS="~amd64 ~x86"
IUSE="examples python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="${PYTHON_DEPS}
	dev-libs/protobuf
	$(python_gen_cond_dep '
		dev-python/sip[${PYTHON_MULTI_USEDEP}]
		python? ( dev-python/protobuf-python[${PYTHON_MULTI_USEDEP}] )
	')"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_PYTHON=$(usex python ON OFF)
		-DBUILD_EXAMPLES=$(usex examples ON OFF)
		-DBUILD_STATIC=$(usex static-libs ON OFF)
	)

	cmake_src_configure
}
