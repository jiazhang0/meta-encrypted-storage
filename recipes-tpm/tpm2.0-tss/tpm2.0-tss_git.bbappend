#
# Copyright (C) 2016 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit systemd

SRC_URI += "\
	file://tpm2.0-tss.service \
"

RRECOMMENDS_${PN} += "\
	kernel-module-tpm-crb \
	kernel-module-tpm-tis \
"

TPM_DESCRIPTION_x86 = 'device/description'
FAMILY_MAJOR_x86 = 'TPM 2.0'
TPM_DESCRIPTION_x86-64 = 'device/description'
FAMILY_MAJOR_x86-64 = 'TPM 2.0'
TPM_DESCRIPTION_actions-s500 = 'family_major'
FAMILY_MAJOR_actions-s500 = '2'

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/tpm2.0-tss.service ${D}${systemd_unitdir}/system
    sed -i 's:@TPM_DESCRIPTION@:${TPM_DESCRIPTION}:' ${D}${systemd_unitdir}/system/tpm2.0-tss.service
    sed -i 's:@FAMILY_MAJOR@:${FAMILY_MAJOR}:' ${D}${systemd_unitdir}/system/tpm2.0-tss.service
}

SYSTEMD_PACKAGES = "resourcemgr"
SYSTEMD_SERVICE_resourcemgr = "tpm2.0-tss.service"
SYSTEMD_AUTO_ENABLE_resourcemgr = "enable"

FILES_resourcemgr += "${systemd_unitdir}/system/tpm2.0-tss.service"
