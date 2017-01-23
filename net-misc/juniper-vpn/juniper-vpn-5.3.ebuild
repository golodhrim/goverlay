inherit eutils libtool versinator linux-info

DESCRIPTION="Juniper Networks SSL VPN"
HOMEPAGE="http://www.juniper.net/products_and_services/ssl_vpn_secure_access/"
SRC_URI=""

LICENSE="Juniper"
RESTRICT="nomirror"
SLOT=0
KEYWORDS="-* ~amd64 x86"
IUSE="lesstif +rpm"

DEPEND=""
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-java )
	rpm? ( app-arch/rpm )
	dev-libs/openssl
	sys-libs/zlib
	>=virtual/jre-1.4.2
	!lesstif? ( x11-libs/openmotif )
	lesstif? ( x11-libs/lesstif )"

pkg_setup() {
	# Setup kernel info for query.
	linux-info_pkg_setup
	
	ebegin "Checking for Universal TUN/TAP device driver support"
	linux_chkconfig_present TUN
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "${DESCRIPTION} requires TUN/TAP support!"
		eerror "Please enable TUN/TAP support in your kernel config, found at:"
		eerror
		eerror "  Device Drivers-->"
		eerror "    Network device support-->"
		eerror "      <M> Universal TUN/TAP device driver support"
		eerror
		eerror "and recompile your kernel..."
		die "TUN/TAP support not detected!"
	fi
}

src_install() {
	# Default location and version number for libs.
	LIBCRYPT_LOC="/usr/lib"

	# We need to pretend we are redhat so the software will actuallz install.
	if ! use rpm && ! has_version app-arch/rpm ; then
		ewarn "*** BIG FAT WARNING ***"
		ewarn "You are building without rpm support!"
		ewarn "We will implement a hack to allow ${DESCRIPTION} to function correctly."
		ewarn "  ln -s /bin/true /usr/bin/rpm"
		mkdir -p ${D}/usr/bin
		ln -s /bin/true ${D}/usr/bin/rpm
	fi

	# Create Lib Location
	mkdir -p ${D}/${LIBCRYPT_LOC}
	
	# This is a dirty hack because they are called different
	# names on redhat 9.
	ln -s libssl.so ${D}/${LIBCRYPT_LOC}/libssl.so.2
	ln -s libcrypto.so ${D}/${LIBCRYPT_LOC}/libcrypto.so.2

	# LAST CHECK SHOWS GENTOO CORRECT VERSION
	# If we use lesstif we need to add one more symlink
	if use lesstif ; then
		ln -s libXm.so.2 ${D}/${LIBCRYPT_LOC}/libXm.so.3
	fi

	# Add the following to /etc/ld.so.conf and then run ldconfig
	mkdir -p ${D}/etc/env.d
	echo "LDPATH=\"/usr/X11R6/lib\"" >> ${D}/etc/env.d/99JuniperVPN
}

pkg_postinst() {
	einfo ""
	einfo "please be sure to remove any juniper networking information in your home directory."
	einfo "  rm -rf ~/.juniper_networks"
	einfo ""
}
