When you increase the disk size of an Ubuntu OS disk in Azure, you might find that the additional space is not immediately available in the server. This typically happens because the partition on the disk has not been expanded to use the newly allocated space. Here are the steps to properly resize the partition and filesystem:

1. **Rescan the Disk to Detect New Size:**

   First, ensure that the operating system detects the new size of the disk. You can do this by rescanning the disk.

   ```bash
   sudo rescan-scsi-bus
   ```

   If `rescan-scsi-bus` is not available, you can install it with:

   ```bash
   sudo apt-get install -y scsitools
   ```

2. **Verify the New Disk Size:**

   Use the `lsblk` or `fdisk` command to verify that the operating system recognizes the new size of the disk.

   ```bash
   lsblk
   ```

   or

   ```bash
   sudo fdisk -l
   ```

3. **Resize the Partition:**

   If you are using a tool like `fdisk`, `parted`, or `growpart`, you will need to resize the partition to take up the new available space.

   For example, using `growpart`:

   ```bash
   sudo growpart /dev/sda 1
   ```

   Here, `/dev/sda` is the disk, and `1` is the partition number. You may need to adjust these values based on your specific setup.

4. **Resize the Filesystem:**

   Once the partition has been resized, you need to resize the filesystem to use the new space. This can be done using `resize2fs` for ext4 filesystems or `xfs_growfs` for XFS filesystems.

   For ext4:

   ```bash
   sudo resize2fs /dev/sda1
   ```

   For XFS:

   ```bash
   sudo xfs_growfs /dev/sda1
   ```

   Make sure to replace `/dev/sda1` with the correct partition identifier.

5. **Verify the Resized Filesystem:**

   Finally, verify that the filesystem has been resized and is using the new space:

   ```bash
   df -h
   ```

This process will make the newly allocated disk space available to your Ubuntu server. If you encounter any issues during these steps, ensure you have a backup of your data before proceeding, and consider consulting the Azure documentation or support for further assistance.

***Fired Commands:***
```bash
sudo apt-get install -y scsitools
sudo rescan-scsi-bus
lsblk
sudo growpart /dev/sda 1
sudo resize2fs /dev/sda1
df -h
history
```
