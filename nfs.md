**On the NFS Server:**

1. **Install NFS Server**:
   If NFS server is not already installed, you can install it with the following command:
   ```bash
   sudo apt-get update
   sudo apt-get install nfs-kernel-server
   ```

2. **Create a Directory to Share**:
   Create a directory that you want to share over NFS. For example, let's create a directory named "nfs_share":
   ```bash
   sudo mkdir /nfs_share
   ```

3. **Edit the Exports File**:
   Edit the `/etc/exports` file to specify which machines are allowed to access the shared directory. Open it with a text editor, like `nano` or `vi`:
   ```bash
   sudo nano /etc/exports
   ```

4. Add the following line to allow access from a specific IP address or range (replace IP_RANGE with the actual IP range):
   ```plaintext
   /nfs_share IP_RANGE(rw,sync,no_subtree_check)
   ```

   For example, to allow access from any IP address (not recommended for production use):
   ```plaintext
   /nfs_share *(rw,sync,no_subtree_check)
   ```

5. **Save and Exit**:
   Save the file and exit the text editor.

6. **Restart NFS Service**:
   Restart the NFS service to apply the changes:
   ```bash
   sudo systemctl restart nfs-kernel-server
   ```

**On the Machine Where You Want to Mount the NFS Drive:**

1. **Install NFS Client**:
   If the NFS client is not installed, you can install it with the following command:
   ```bash
   sudo apt-get update
   sudo apt-get install nfs-common
   ```

2. **Create a Mount Point**:
   Create a directory where you want to mount the NFS share. For example, let's create a directory named "mount_point":
   ```bash
   sudo mkdir /mount_point
   ```

3. **Mount the NFS Share**:
   Use the `mount` command to mount the NFS share from the server to the mount point. Replace `server_ip` with the IP address or hostname of the NFS server and `nfs_share` with the shared directory's name:
   ```bash
   sudo mount -t nfs server_ip:/nfs_share /mount_point
   ```

4. **Verify the Mount**:
   You can check if the NFS share is successfully mounted by running:
   ```bash
   df -h
   ```