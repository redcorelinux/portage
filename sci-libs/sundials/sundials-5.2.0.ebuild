# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
FORTRAN_NEEDED=fortran
FORTRAN_STANDARD="77 90"
# if FFLAGS and FCFLAGS are set then should be equal

inherit cmake fortran-2 toolchain-funcs flag-o-matic

DESCRIPTION="Suite of nonlinear solvers"
HOMEPAGE="https://computation.llnl.gov/projects/sundials"
SRC_URI="https://computation.llnl.gov/projects/sundials/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/$(ver_cut 1)"
KEYWORDS="amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cxx doc examples fortran hypre lapack mpi openmp sparse static-libs superlumt threads"
REQUIRED_USE="hypre? ( mpi )"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	lapack? ( virtual/lapack )
	mpi? ( virtual/mpi sci-libs/hypre:= )
	sparse? ( sci-libs/klu )
	superlumt? ( sci-libs/superlu_mt:= )
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-fix-license-install-path.patch )

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
	use fortran && fortran-2_pkg_setup
}

src_prepare() {
	# bug #707240
	append-cflags -fcommon

	cmake_src_prepare
}

src_configure() {
	mycmakeargs+=(
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS="$(usex static-libs)"
		-DCXX_ENABLE="$(usex cxx)"
		-DFCMIX_ENABLE="$(usex fortran)"
		-DF90_ENABLE="$(usex fortran)"
		-DHYPRE_ENABLE="$(usex hypre)"
		-DHYPRE_INCLUDE_DIR="${EPREFIX}/usr/include/hypre"
		-DKLU_ENABLE="$(usex sparse)"
		-DLAPACK_ENABLE="$(usex lapack)"
		-DMPI_ENABLE="$(usex mpi)"
		-DOPENMP_ENABLE="$(usex openmp)"
		-DPTHREAD_ENABLE="$(usex threads)"
		-DSUPERLUMT_ENABLE="$(usex superlumt)"
		-DSUPERLUMT_INCLUDE_DIR="${EPREFIX}/usr/include/superlu_mt"
		-DSUPERLUMT_LIBRARY="-lsuperlu_mt"
		-DEXAMPLES_ENABLE="$(usex examples)"
		-DEXAMPLES_INSTALL=ON
		-DEXAMPLES_INSTALL_PATH="${EPREFIX}/usr/share/doc/${PF}/examples"
		-DUSE_GENERIC_MATH=ON
	)
	use sparse && mycmakeargs+=( -DKLU_LIBRARY="${EPREFIX}/usr/$(get_libdir)/libklu.so" )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	use doc && dodoc doc/*/*.pdf
}
