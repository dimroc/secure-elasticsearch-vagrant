# vi: set ft=sh :
# Used if mounting separate volume for AWS provider.
echo "Running mount_instance_store.sh"
echo "File system is $(sudo file -s /dev/xvdb)"
HAS_EXT4_FILESYSTEM=$(sudo file -s /dev/xvdb | grep -i ext4)

if [[ -z "${HAS_EXT4_FILESYSTEM}" ]];
then
  echo "Creating ext4 filesystem";

  lsblk
  sudo file -s /dev/xvdb
  sudo mkfs -t ext4 /dev/xvdb

  # Run fstab
  echo 'Mounting instance store...'
  sudo mount -a
fi

