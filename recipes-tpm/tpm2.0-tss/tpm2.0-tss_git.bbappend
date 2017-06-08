#
# Copyright (C) 2016-2017 Wind River Systems, Inc.
#

RRECOMMENDS_${PN} += "\
	kernel-module-tpm-crb \
	kernel-module-tpm-tis \
"

TPM_DESCRIPTION = 'device/description'
FAMILY_MAJOR = 'TPM 2.0'
