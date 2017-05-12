FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://tcsd.conf \
    file://tcsd.service \
    file://fix-deadlock-and-potential-hung.patch \
    file://fix-event-log-parsing-problem.patch \
    file://fix-incorrect-report-of-insufficient-buffer.patch \
    file://trousers-conditional-compile-DES-related-code.patch \
    file://Fix-segment-fault-if-client-hostname-cannot-be-retri.patch \
"

SYSTEMD_SERVICE_${PN} = "tcsd.service"
SYSTEMD_AUTO_ENABLE = "enable"

TPM_CAPS_x86 = 'device/caps'
FAMILY_MAJOR_x86 = 'TCG version: 1.2'
TPM_CAPS_x86-64 = 'device/caps'
FAMILY_MAJOR_x86-64 = 'TCG version: 1.2'
TPM_CAPS_actions-s500 = 'family_major'
FAMILY_MAJOR_actions-s500 = '1'

do_install_append () {
    install -m 0600 ${WORKDIR}/tcsd.conf ${D}${sysconfdir}
    chown tss:tss ${D}${sysconfdir}/tcsd.conf

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/tcsd.service ${D}${systemd_unitdir}/system
    sed -i 's:@TPM_CAPS@:${TPM_CAPS}:' ${D}${systemd_unitdir}/system/tcsd.service
    sed -i 's/@FAMILY_MAJOR@/${FAMILY_MAJOR}/' ${D}${systemd_unitdir}/system/tcsd.service
}
