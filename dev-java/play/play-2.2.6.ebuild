# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user versionator

DESCRIPTION="The High Velocity Web Framework For Java and Scala"
HOMEPAGE="http://www.playframework.com/"

SRC_URI="http://downloads.typesafe.com/play/${PV}/play-${PV}.zip"

LICENSE="Apache-2.0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
SLOT="$(get_version_component_range 1-2)"
IUSE=""
RESTRICT="mirror"

DEPEND=">=virtual/jdk-1.6
       "

RDEPEND=">=virtual/jre-1.6
        "

pkg_setup() {
        enewgroup playdevelopers
}

src_install() {
	dodir "/opt"
        cp -a "${S}/" "${D}/opt/" || die

        keepdir "/opt/${P}/framework/sbt"

	fowners -R root:playdevelopers "/opt/${P}"
        find "${D}/opt/${P}/" -type d -print0 | xargs -0 chmod 0770
	find "${D}/opt/${P}/" -type f -perm /111 -print0 | xargs -0 chmod 0770
        find "${D}/opt/${P}/" -type f ! -perm /111 -print0 | xargs -0 chmod 0660

        make_wrapper "${P}" "/opt/${P}/${PN}"
        elog "You must be in the playdevelopers group to use Play2 framework."
}
