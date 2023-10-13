**Note**: Ensure that your certificate files are in the appropriate format (PEM or DER), and they match your domain.

1. **Copy Certificates to Your Server**:
   First, copy your SSL certificate and private key to your server. You can use SCP or other methods to transfer the files to your server.

   ```bash
   scp your_domain.crt your_domain.key user@your_server_ip:/path/to/ssl/files/
   ```

2. **Create a Directory for SSL Certificates**:
   Create a directory to store your SSL certificates. It's a good practice to keep them in a separate location:

   ```bash
   sudo mkdir /etc/nginx/ssl
   ```

3. **Move Certificates to the SSL Directory**:
   Move the certificate and key files to the SSL directory you just created:

   ```bash
   sudo mv /path/to/ssl/files/your_domain.crt /etc/nginx/ssl/
   sudo mv /path/to/ssl/files/your_domain.key /etc/nginx/ssl/
   ```

4. **Configure Nginx**:
   Open the Nginx configuration file for your website using a text editor. Typically, Nginx site configuration files are stored in `/etc/nginx/sites-available/`. Edit the file for your website:

   ```bash
   sudo nano /etc/nginx/sites-available/your_site
   ```

   Inside your server block, add or modify the following lines to specify the SSL certificate and key files:

   ```nginx
   server {
       listen 443 ssl;
       server_name your_domain.com;

       ssl_certificate /etc/nginx/ssl/your_domain.crt;
       ssl_certificate_key /etc/nginx/ssl/your_domain.key;

       # ... Rest of your Nginx configuration ...
   }
   ```

   Be sure to replace `your_domain.crt` and `your_domain.key` with the actual file names and `your_domain.com` with your domain.

5. **Test Nginx Configuration**:
   Verify that your Nginx configuration is valid:

   ```bash
   sudo nginx -t
   ```

6. **Reload Nginx**:
   If the configuration test passes, reload Nginx to apply the changes:

   ```bash
   sudo systemctl reload nginx
   ```