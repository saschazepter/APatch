#!/bin/bash

set -e

. /etc/default/openmediavault
. /usr/share/openmediavault/scripts/helper-functions

pref="/etc/apt/preferences.d/omvextras.pref"
backports=${OMV_APT_USE_KERNEL_BACKPORTS:-"yes"}

# Add seabios to the backports pinning file if it isn't already there.
if omv_checkyesno ${backports} && [ -f "${pref}" ] && ! grep -q "^Package: seabios$" "${pref}"; then
  dist="$(lsb_release --codename --short)"
  priority=${OMV_APT_KERNEL_BACKPORTS_PINPRIORITY:-500}
  echo -e "Package: seabios\nPin: release n=${dist}-backports\nPin-Priority: ${priority}\n" >> ${pref}
  chmod 644 ${pref}
fi

exit 0
