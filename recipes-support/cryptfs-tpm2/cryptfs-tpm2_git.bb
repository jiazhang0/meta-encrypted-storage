#
# Copyright (C) 2016-2017 Wind River Systems, Inc.
#

SUMMARY = "A tool used to create, persist, evict a passphrase \
for full-disk-encryption with TPM 2.0"
DESCRIPTION = " \
This project provides with an implementation for \
creating, persisting and evicting a passphrase with TPM 2.0. \
The passphrase and its associated primary key are automatically \
created by RNG engine in TPM. In order to avoid saving the \
context file, the created passphrase and primary key are always \
persistent in TPM. \
"
SECTION = "devel"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=35c0ab29d291dbbd14d66fd95521237f"

SRC_URI = " \
    git://github.com/WindRiver-OpenSourceLabs/cryptfs-tpm2.git \
"
SRCREV = "768c100b5ca7d5cc3a3c902ac01dfcf24c6efc8b"
PV = "0.5.1+git${SRCPV}"

DEPENDS += "tpm2.0-tss"
RDEPENDS_${PN} += "libtss2 libtctisocket tpm2.0-tools"

PACKAGES =+ " \
    ${PN}-initramfs-script \
"

PARALLEL_MAKE = ""

S = "${WORKDIR}/git"

EXTRA_OEMAKE = " \
    prefix="${prefix}" \
    sbindir="${sbindir}" \
    libdir="${libdir}" \
    includedir="${includedir}" \
    tpm2_tss_includedir="${STAGING_LIBDIR}" \
    tpm2_tss_libdir="${STAGING_INCDIR}" \
    CC="${CC}" \
    EXTRA_CFLAGS="${CFLAGS}" \
    EXTRA_LDFLAGS="${LDFLAGS}" \
"

do_install() {
    oe_runmake install DESTDIR="${D}"

    if [ x"${@bb.utils.contains('DISTRO_FEATURES', 'storage-encryption', '1', '0', d)}" = x"1" ]; then
        install -m 0500 ${S}/script/init.cryptfs ${D}
    fi
}

FILES_${PN}-initramfs-script = "\
    /init.cryptfs \
"

FILES_${PN} = "\
    ${sbindir} \
    ${libdir} \
"
