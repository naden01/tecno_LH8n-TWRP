#!/sbin/sh

log() {
    echo "SWAP_MODULES: $1"
    echo "SWAP_MODULES: $1" > /dev/kmsg
}

log "Manually swapping modules..."

# Unmount in case it was already bound
umount -l /lib/modules 2>/dev/null

# bind mount modules folder
mount -o bind /lib/modules/modules_old /lib/modules

if [ $? -eq 0 ]; then
    log "Success. /lib/modules is now redirected to /lib/modules/modules_old."
else
    log "Failed to bind mount."
fi