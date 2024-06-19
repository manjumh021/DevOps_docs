To reset the root password in MySQL on Ubuntu, you can follow these steps:

1. **Stop the MySQL Service**:
   First, you'll need to stop the MySQL service. Open a terminal and run:
   ```bash
   sudo systemctl stop mysql
   ```

2. **Start MySQL in Safe Mode**:
   Start MySQL without password validation by running the following command:
   ```bash
   sudo mysqld_safe --skip-grant-tables &
   ```

3. **Log into MySQL as the root user**:
   In another terminal, log in to the MySQL shell as the root user:
   ```bash
   mysql -u root
   ```

4. **Reset the root password**:
   Once you're in the MySQL shell, update the root password. You can do this by executing the following commands:
   ```sql
   FLUSH PRIVILEGES;
   ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
   ```
   Replace `'new_password'` with your desired new password.

5. **Exit the MySQL Shell**:
   Type `exit` to leave the MySQL shell:
   ```sql
   exit;
   ```

6. **Stop the MySQL Safe Mode**:
   Find the process ID (PID) of the `mysqld_safe` and `mysqld` processes and kill them. You can do this by running:
   ```bash
   sudo pkill mysqld
   sudo pkill mysqld_safe
   ```

7. **Restart the MySQL Service**:
   Start the MySQL service again:
   ```bash
   sudo systemctl start mysql
   ```

8. **Verify the new password**:
   Finally, verify that you can log in with the new root password:
   ```bash
   mysql -u root -p
   ```

   When prompted, enter the new password you set.

By following these steps, you should be able to reset the root password for MySQL on an Ubuntu system.
