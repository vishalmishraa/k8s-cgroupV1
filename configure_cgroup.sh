#!/bin/bash

# Function to update GRUB
update_grub() {
    if command -v update-grub &> /dev/null; then
        if update-grub; then
            echo "GRUB updated successfully"
        else
            echo "Failed to update GRUB"
            exit 1
        fi
    else
        echo "update-grub command not found, cannot proceed"
        exit 1
    fi
}

# Function to reboot the node
reboot_node() {
    echo "Rebooting the node"
    if command -v reboot &> /dev/null; then
        reboot
    else
        echo "Reboot command not found, please manually reboot the node"
        exit 1
    fi
}

# Check if the cgroup configuration is already set
if grep -q "systemd.unified_cgroup_hierarchy=0" /etc/default/grub; then
    echo "The cgroup configuration is already set, updating GRUB"
    update_grub
else
    # Add the cgroup configuration
    sed -i 's/GRUB_CMDLINE_LINUX="/&systemd.unified_cgroup_hierarchy=0 /' /etc/default/grub
    update_grub
fi

# Check if running inside a Kubernetes pod
if grep -q "/kubepods" /proc/1/cgroup; then
    echo "Running inside a Kubernetes pod, skipping reboot"
    echo "Please manually reboot the node to apply changes"
else
    reboot_node
fi