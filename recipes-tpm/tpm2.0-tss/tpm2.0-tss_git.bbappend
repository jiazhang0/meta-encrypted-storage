#
# Copyright (C) 2016-2017 Wind River Systems, Inc.
#

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
