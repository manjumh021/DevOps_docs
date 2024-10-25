To implement log rotation for Gunicorn logs, you can use `logrotate`, a tool designed for managing and rotating logs automatically. Here’s how you can set up log rotation specifically for Gunicorn’s access and error logs:

### 1. **Create a Logrotate Configuration File for Gunicorn**

1. Create a new logrotate configuration file in `/etc/logrotate.d/`. You can name it based on your application or service, e.g., `gunicorn_app`:

   ```bash
   sudo nano /etc/logrotate.d/gunicorn_app
   ```

2. Add the following configuration to define how you want the logs rotated:

   ```bash
   /path/to/your/app/logs/access.log /path/to/your/app/logs/gunicorn-error.log {
       daily                  # Rotate logs daily
       missingok              # Don’t throw an error if the log file is missing
       rotate 7               # Keep the last 7 rotated logs
       compress               # Compress logs to save space
       delaycompress          # Compress logs only after the next rotation
       notifempty             # Don’t rotate if the log file is empty
       copytruncate           # Truncate the log file in place without changing the file descriptor
   }
   ```

   - **`/path/to/your/app/logs/access.log`** and **`/path/to/your/app/logs/gunicorn-error.log`**: Replace these paths with the actual locations of your Gunicorn log files.
   - **`copytruncate`**: This option is helpful for rotating logs without restarting Gunicorn, as it truncates the log file in place while allowing Gunicorn to continue writing.

### 2. **Test the Logrotate Configuration**

To ensure your configuration is valid, you can test it with the following command:

```bash
sudo logrotate -d /etc/logrotate.d/gunicorn_app
```

This runs logrotate in debug mode (`-d`), showing you what it would do without actually rotating the logs. Check for any errors in the output.

### 3. **Force a Log Rotation Test**

To perform a test run and actually rotate the logs, use:

```bash
sudo logrotate -f /etc/logrotate.d/gunicorn_app
```

### 4. **Verify Rotation**

After forcing rotation, check the logs directory (`/path/to/your/app/logs/`) to ensure the logs were rotated as specified. You should see the rotated files, such as `access.log.1`, `gunicorn-error.log.1`, etc., with older logs compressed if `compress` was specified.

### 5. **Automated Log Rotation**

`logrotate` is typically scheduled to run daily through a cron job located at `/etc/cron.daily/logrotate`, so the rotation will automatically follow the schedule you’ve set in your configuration.

This setup will keep your Gunicorn logs manageable and free up disk space regularly without manual intervention.