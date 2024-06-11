

### Checklist

1. **Create and Configure VM**
   - Provision a VM in Azure and "don't forget to allow required ports in network settings".
   - Install the required software (Nginx, OpenSSL).
   - Configure firewall settings to open necessary ports.

2. **Obtain SSL Certificates**
   - Generate a private key and CSR.
   - Obtain an SSL certificate from a Certificate Authority (CA).
   - Save the SSL certificate, private key, and any intermediate certificates.

3. **Configure Nginx for SSL**
   - Update the Nginx configuration to use the SSL certificates.
   - Test and reload the Nginx configuration.

4. **Azure Network Security Group (NSG) Configuration**
   - Update NSG rules to allow traffic on port 443.

5. **Verify the Setup**
   - Test access to the website over HTTPS.
   - Check logs for any issues.

### Step-by-Step Guide

#### 1. Create and Configure VM

1. **Provision a VM in Azure**:
   - Go to the Azure portal.
   - Create a new VM with your preferred settings (OS, size, region, etc.).
   - don't forget to allow required ports in network settings

2. **SSH into the VM**:
   ```sh
   ssh <username>@<vm_public_ip>
   ```

3. **Install Nginx**:
   ```sh
   sudo apt update
   sudo apt install nginx -y
   ```

4. **Install OpenSSL (if not already installed)**:
   ```sh
   sudo apt install openssl -y
   ```

5. **Configure Firewall Settings**:
   ```sh
   sudo ufw allow 'Nginx Full'
   ```

#### 2. Obtain SSL Certificates

1. **Generate a Private Key and CSR**:
   ```sh
   openssl req -new -newkey rsa:2048 -nodes -keyout private.key -out example.com.csr
   ```

2. **Submit the CSR to a CA**:
   - Use the CSR to obtain an SSL certificate from a trusted CA.
   - Save the received certificate files (e.g., `example_com.crt`, `example_com.ca-bundle`).

#### 3. Configure Nginx for SSL

1. **Place SSL Certificates on the Server**:
   ```sh
   sudo mkdir -p /var/www/ssl
   sudo cp private.key /var/www/ssl/
   sudo cp example_com.crt /var/www/ssl/
   sudo cp example_com.ca-bundle /var/www/ssl/
   ```

2. **Update Nginx Configuration**:
   Edit `/etc/nginx/nginx.conf` or create a new configuration file under `/etc/nginx/conf.d/`:

   ```nginx
   server {
       listen 80;
       listen [::]:80;
       server_name example.com;

       location / {
           return 301 https://$host$request_uri;
       }
   }

   server {
       listen 443 ssl;
       listen [::]:443 ssl;
       server_name example.com;

       ssl_certificate /var/www/ssl/example_com.crt;
       ssl_certificate_key /var/www/ssl/private.key;
       ssl_trusted_certificate /var/www/ssl/example_com.ca-bundle;

       ssl_protocols TLSv1.2 TLSv1.3;
       ssl_ciphers HIGH:!aNULL:!MD5;
       ssl_prefer_server_ciphers on;
       ssl_session_cache shared:SSL:10m;
       ssl_session_timeout 10m;

       root /usr/share/nginx/html;

       location /prod-api/ {
           proxy_set_header Host $http_host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header REMOTE-HOST $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_pass http://localhost:8082/;
       }

       location / {
           root /iot/dist/;
           try_files $uri $uri/ /index.html;
           index index.html index.htm;
       }
   }
   ```

3. **Test and Reload Nginx Configuration**:
   ```sh
   sudo nginx -t
   sudo systemctl restart nginx
   ```

#### 4. Azure Network Security Group (NSG) Configuration

1. **Open the Azure Portal**:
   - Navigate to your VM's "Networking" section.

2. **Update NSG Rules**:
   - Go to the NSG associated with your VM.
   - Add an inbound security rule:
     - **Source**: Any
     - **Source port ranges**: *
     - **Destination**: Any
     - **Destination port ranges**: 443
     - **Protocol**: TCP
     - **Action**: Allow
     - **Priority**: 100
     - **Name**: Allow-HTTPS

#### 5. Verify the Setup

1. **Test HTTPS Access**:
   ```sh
   curl -I https://example.com
   ```

2. **Check Nginx Logs** for any issues:
   ```sh
   sudo tail -f /var/log/nginx/error.log
   ```

By following these steps, you should have a fully functional Nginx web server with SSL configured, running on an Azure VM, and accessible via HTTPS.