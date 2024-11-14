#!/bin/bash

# Check if the cgroup configuration is already set
if grep -q "systemd.unified_cgroup_hierarchy=0" /etc/default/grub; then
    echo "The cgroup configuration is already set updating greb and rebooting the node"
    update-grub
    reboot
fi

# Add the cgroup configuration
sed -i 's/GRUB_CMDLINE_LINUX="/&systemd.unified_cgroup_hierarchy=0 /' /etc/default/grub

# Update GRUB
update-grub
 
# Reboot the node
reboot