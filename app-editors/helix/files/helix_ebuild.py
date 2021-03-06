#!/usr/bin/env python
"""
Generates a helix ebuild, run from a git clone with a tag checked out
"""
import re
import os
import string
import pathlib
import datetime
import tempfile
import subprocess

import tomli

EBUILD_TEMPLATE = """
# Copyright ${copyright} Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by helix_ebuild.py (see FILESDIR)

EAPI=8

CRATES="
${CRATES}
"

LANGUAGES=(
${LANGUAGES}
)

inherit bash-completion-r1 cargo

DESCRIPTION="A post-modern text editor."
HOMEPAGE="
	https://helix-editor.com/
	https://github.com/helix-editor/helix
"
SRC_URI="
	https://github.com/helix-editor/helix/archive/refs/tags/$${PV}.tar.gz -> $${P}.tar.gz
	$$(cargo_crate_uris)
"

LICENSE="${LICENSE}"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +grammar"

QA_FLAGS_IGNORED="
	usr/bin/hx
	usr/share/helix/runtime/grammars/.*\\.so
"

DOCS=(
	README.md
	CHANGELOG.md
	book/
	docs/
)

language_uris() {
	local line

	for line in "$${LANGUAGES[@]}"; do
		read -r name url commit <<< "$${line}"

		printf '%s/archive/%s.tar.gz -> %s-%s.tar.gz\\n' "$${url}" "$${commit}" "$${url##*/}" "$${commit}"
	done
}

SRC_URI+="grammar? ( $$(language_uris) )"

src_prepare() {
	local line

	if use grammar; then
		for line in "$${LANGUAGES[@]}"; do
			read -r name url commit <<< "$${line}"

			mkdir -p "$${S}"/runtime/grammars/sources/$${name} || die
			cp --reflink=auto --recursive \\
				"$${WORKDIR}"/$${url##*/}-$${commit}/* \\
				"$${S}"/runtime/grammars/sources/$${name} || die
		done
	fi

	eapply_user
}

src_compile() {
	local -x HELIX_DISABLE_AUTO_GRAMMAR_BUILD=1
	local -x HELIX_RUNTIME="$${S}/runtime"

	cargo_src_compile

	if use grammar; then
		target/release/hx --grammar build || die
	fi
}

src_install() {
	if use grammar; then
		rm -rf "$${S}"/runtime/grammars/sources || die
	fi

	insinto /usr/share/helix
	doins -r runtime

	use doc && dodoc -r "$${DOCS[@]}"

	cargo_src_install --path helix-term

	newbashcomp contrib/completion/hx.bash hx

	insinto /usr/share/zsh/site-functions
	newins contrib/completion/hx.zsh _hx

	insinto /usr/share/fish/vendor_completions.d
	doins contrib/completion/hx.fish
}
"""
LANGUAGES_FILE = pathlib.Path("languages.toml")
LICENSE_RE = r"[\s]*LICENSE=['\"](?P<licenses>[^\"']*)[\"'].*"


def main():
    workdir = pathlib.Path().resolve()
    os.chdir("helix-term")
    cargo_ebuild_proc = subprocess.run(
        ("cargo", "ebuild", "--noaudit"), check=True, capture_output=True, text=True
    )
    os.chdir(workdir)

    tag_process = subprocess.run(
        ("git", "describe", "--tags"), check=True, capture_output=True, text=True
    )
    if not (
        cargo_ebuild := pathlib.Path(
            "helix-term",
            cargo_ebuild_proc.stdout.split("\n")[-2].partition(":")[2].strip(),
        )
    ).exists():
        raise RuntimeError(f"Can't find ebuild {cargo_ebuild}")

    new_ebuild = pathlib.Path(f"helix-{tag_process.stdout.strip()}.ebuild")

    with LANGUAGES_FILE.open("rb") as languages_file:
        language_list = tomli.load(languages_file)

    license_re = re.compile(LICENSE_RE)
    with (
        tempfile.TemporaryFile("wt+") as tmpfile,
        cargo_ebuild.open("rt+", encoding="utf-8") as cargo_ebuild_file,
    ):
        cargo_ebuild.unlink()

        crates = ""
        licenses = None
        in_crates = False
        for line in cargo_ebuild_file.readlines():
            if (license_match := license_re.match(line)) is not None:
                licenses = license_match.group("licenses")
                licenses = " ".join((lc for lc in licenses.split(" ") if lc != "MPL-2.0+"))

            elif line.startswith("CRATES="):
                in_crates = True
                continue

            elif in_crates:
                if line.strip() == "":
                    continue

                elif line.strip() == '"':
                    in_crates = False
                    continue

                crates += line

        languages = ""
        for language in language_list.get("grammar", []):
            if source := language.get("source"):
                languages += f'\n\t"{language["name"]} {source["git"]} {source["rev"]}"'

        tmpfile.seek(0)

    year = datetime.datetime.now().year
    copyright_date = f"2023-{year}" if year > 2022 else "2023"

    template = string.Template(EBUILD_TEMPLATE.lstrip("\n"))
    with new_ebuild.open("wt", encoding="utf-8") as output_file:
        output_file.write(
            template.substitute(
                CRATES=crates.strip("\n"),
                LANGUAGES=languages.strip("\n"),
                LICENSE=licenses,
                copyright=copyright_date,
            ),
        )

    print("\n".join(cargo_ebuild_proc.stdout.split("\n")[:-2]))
    print(f"Wrote: {new_ebuild}")


if __name__ == "__main__":
    main()
