#
# Copyright (C) 2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-yocto:"

SRC_URI += " \
    ${@base_contains('MACHINE_FEATURES', 'encrypted-storage', 'file://dmcrypt.scc', '', d)} \
    ${@base_contains('MACHINE_FEATURES', 'encrypted-storage', 'file://dmcrypt.cfg', '', d)} \
"
