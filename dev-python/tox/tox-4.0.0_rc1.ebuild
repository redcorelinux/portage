# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

MY_P=${P/_}
DESCRIPTION="virtualenv-based automation of test activities"
HOMEPAGE="
	https://tox.readthedocs.io/
	https://github.com/tox-dev/tox/
	https://pypi.org/project/tox/
"
SRC_URI="
	https://github.com/tox-dev/tox/archive/${PV/_}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/cachetools-5.2[${PYTHON_USEDEP}]
	>=dev-python/chardet-5[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.6[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.3[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-2.5.4[${PYTHON_USEDEP}]
	>=dev-python/pluggy-1[${PYTHON_USEDEP}]
	>=dev-python/pyproject-api-1.1.2[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/tomli-2.0.1[${PYTHON_USEDEP}]
	' 3.8 3.9 3.10)
	>=dev-python/virtualenv-20.16.7[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		>=dev-python/distlib-0.3.6[${PYTHON_USEDEP}]
		>=dev-python/filelock-3.8[${PYTHON_USEDEP}]
		>=dev-python/flaky-3.7[${PYTHON_USEDEP}]
		>=dev-python/psutil-5.9.4[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		>=dev-python/re-assert-1.1[${PYTHON_USEDEP}]
		>=dev-python/time-machine-2.8.2[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	local EPYTEST_DESELECT=(
		# Internet
		tests/tox_env/python/virtual_env/package/test_package_cmd_builder.py::test_build_wheel_external
	)

	epytest
}
