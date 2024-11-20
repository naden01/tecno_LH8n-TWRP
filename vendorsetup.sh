#!/bin/bash

export OF_DISABLE_OTA_MENU=1
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1
export OF_DEFAULT_KEYMASTER_VERSION=4.1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_MAINTAINER="nazephyrus"
export FOX_VARIANT="Stable"

export FOX_USE_BASH_SHELL=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_ASH_IS_BASH=1
export OF_ENABLE_LPTOOLS=1
export FOX_DELETE_AROMAFM=1
export FOX_ENABLE_APP_MANAGER=1
export OF_SUPPORT_VBMETA_AVB2_PATCHING=1

export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1

export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

export OF_USE_LZ4_COMPRESSION=true

export OF_USE_MAGISKBOOT="1"
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"

export OF_SCREEN_H=2460
export OF_STATUS_H=95
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_ALLOW_DISABLE_NAVBAR=0
export OF_CLOCK_POS=1

# Important build settings
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL="C"

# use magisk 27.0 for the magisk addon
export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v28.0.zip
export MAGISK_VER=28.0

# instruct magiskboot v26+ to always patch the vbmeta header when patching the recovery/boot image; do *not* remove!
export FOX_PATCH_VBMETA_FLAG=1

# flashlight
export OF_FLASHLIGHT_ENABLE=1
export OF_FL_PATH1="/sys/class/torch/torch_level"
