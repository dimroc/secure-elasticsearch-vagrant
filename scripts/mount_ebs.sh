# vi: set ft=bash :
# Used if mounting separate EBS volume for AWS provider.

echo 'Mounting extra EBS volume...'

lsblk
sudo file -s /dev/xvdf
sudo mkfs -t ext4 /dev/xvdf
sudo mkdir -p /data
sudo mount /dev/xvdf /data

# Fix fstab
sudo sh -c 'echo \
"LABEL=cloudimg-rootfs / ext4 defaults,discard 0 0
/dev/xvdb / auto defaults,nobootwait,comment=cloudconfig 0 2
/dev/xvdf /data ext4 defaults,nofail 0 2"\
    > /etc/fstab'

# Run checks
sudo mount -a
