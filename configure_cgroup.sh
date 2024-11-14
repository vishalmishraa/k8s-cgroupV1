#!/bin/bash
# Check if the cgroup configuration is already set
if grep -q "systemd.unified_cgroup_hierarchy=0" /etc/default/grub; then
    echo "The cgroup configuration is already set, updating grub"
    if update-grub; then
        echo "grub updated"
    else
        echo "Failed to update grub"
    fi
    echo "Rebooting the node"
    if command -v reboot &> /dev/null; then
        reboot
    else
        echo "Reboot command not found"
    fi
    exit
fi
# Add the cgroup configuration
sed -i 's/GRUB_CMDLINE_LINUX="/&systemd.unified_cgroup_hierarchy=0 /' /etc/default/grub
# Update GRUB
if update-grub; then
    echo "grub updated"
else
    echo "Failed to update grub"
fi

# Reboot the node
echo "Rebooting the node"
if command -v reboot &> /dev/null; then
    reboot
else
    echo "Reboot command not found"
fi