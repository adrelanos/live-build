#!/bin/sh

# conffile.sh - handle configuration files
# Copyright (C) 2006-2008 Daniel Baumann <daniel@debian.org>
#
# live-helper comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
# This is free software, and you are welcome to redistribute it
# under certain conditions; see COPYING for details.

set -e

Read_conffile ()
{
	if [ -n "${LH_CONFIG}" ]
	then
		FILES="${LH_CONFIG}"
	else
		for FILE in ${@}
		do
			FILES="${FILE} ${FILE}.${LH_ARCHITECTURE} ${FILE}.${DISTRIBUTION}"
			FILES="${FILES} config/$(echo ${PROGRAM} | sed -e 's|^lh_||')"
			FILES="${FILES} config/$(echo ${PROGRAM} | sed -e 's|^lh_||').${ARCHITECTURE}"
			FILES="${FILES} config/$(echo ${PROGRAM} | sed -e 's|^lh_||').${DISTRIBUTION}"
		done
	fi

	for CONFFILE in ${FILES}
	do
		if [ -f "${CONFFILE}" ]
		then
			if [ -r "${CONFFILE}" ]
			then
				Echo_debug "Reading configuration file ${CONFFILE}"
				. "${CONFFILE}"
			else
				Echo_warning "Failed to read configuration file ${CONFFILE}"
			fi
		fi
	done
}
