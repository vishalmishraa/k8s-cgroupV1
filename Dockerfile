FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y grub2

# Copy the script into the container
COPY configure_cgroup.sh /usr/local/bin/configure_cgroup.sh

# Make the script executable
RUN chmod +x /usr/local/bin/configure_cgroup.sh

# Run the script
CMD ["/usr/local/bin/configure_cgroup.sh"] 
