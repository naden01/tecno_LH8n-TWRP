#
#	This file is part of the OrangeAERA Recovery Project
# 	Copyright (C) 2025 The OrangeAERA Recovery Project
#
#	OrangeAERA is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeAERA is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

#
#	This file is part of the OrangeAERA Recovery Project
# 	Copyright (C) 2025 The OrangeAERA Recovery Project
#
#	OrangeAERA is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeAERA is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

#set -o xtrace
FDEVICE="LH8n"

aera_get_target_device() {
	export script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
	if echo "$script_path" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	elif echo "$0" | grep -q "$FDEVICE"; then
		AERA_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$AERA_BUILD_DEVICE" ]; then
	aera_get_target_device
fi

if [ "$AERA_BUILD_DEVICE" = "$FDEVICE" ]; then
	echo "Detected build device: $AERA_BUILD_DEVICE"

# AERA device build settings
	export AERA_BUILD_TYPE=Beta
	
# other
export AERA_VIRTUAL_AB_DEVICE=1
export AERA_ENABLE_APP_MANAGER=1
export AERA_VENDOR_BOOT_RECOVERY=1
export AERA_RECOVERY_VENDOR_BOOT_PARTITION="/dev/block/by-name/vendor_boot"
export AERA_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export AERA_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export AERA_USE_XZ_UTILS=1
export AERA_USE_BASH_SHELL=1
export AERA_ASH_IS_BASH=1
export AERA_USE_TAR_BINARY=1
export AERA_USE_LZ4_BINARY=1
export AERA_USE_SED_BINARY=1
export AERA_USE_ZSTD_BINARY=1
export AERA_USE_NANO_EDITOR=1
export AERA_USE_UPDATED_MAGISKBOOT=1
export AERA_DELETE_AROMAFM=1
export AERA_USE_DATE_BINARY=1

# KSU, etc.
	export AERA_ENABLE_KERNELSU_SUPPORT=1
	export AERA_ENABLE_KERNELSU_NEXT_SUPPORT=1
	export AERA_ENABLE_SUKISU_SUPPORT=1

TFILE=$PWD/out/hapticspath.patched
[ ! -d "out" ]&& mkdir -p out
RET=0
REVERSE=0

cd bootable/recovery
git apply --reverse --check ../../device/tecno/LH8n/patches/0001-Change-haptics-activation-file-path.patch || REVERSE=$?
cd ../../

if [ -f "$TFILE" ];then
    echo "haptics path patched already, skipping"
elif [ $REVERSE -eq 0 ]; then
	echo "$TFILE is not found but git is able to reverse haptics path patch, assuming it's already patched, skipping"
else
    cd bootable/recovery
    git apply ../../device/tecno/LH8n/patches/0001-Change-haptics-activation-file-path.patch || RET=$?
    cd ../../
    if [ $RET -ne 0 ];then
	echo "ERROR: minuitwrp/events.cpp could not be patched! Vibration in TWRP will not work."
    else
	echo "OK: minuitwrp/events.cpp patched"
	touch $TFILE
    fi
fi
