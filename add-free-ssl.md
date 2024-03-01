### Prerequisites:
1. Make sure your domain is pointed to the server's IP address.
2. Nginx is installed on your server.
3. Python application is running on port 5000.

### Steps:

#### 1. Install Certbot:
```bash
sudo apt-get update
sudo apt-get install certbot
sudo apt-get install python3-certbot-nginx
```

#### 2. Obtain SSL Certificate:
Run the following command to obtain an SSL certificate for your domain. Replace `your_domain.com` with your actual domain.
```bash
sudo certbot certonly --nginx -d your_domain.com
```
Follow the instructions to complete the certificate installation.

#### 3. Configure Nginx:
Edit your Nginx configuration file to include SSL settings. Open the Nginx configuration file in a text editor (e.g., `sudo nano /etc/nginx/sites-available/default`) and add or modify the following lines:

```nginx
server {
    listen 80;
    server_name your_domain.com www.your_domain.com;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen [::]:80;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name your_domain.com www.your_domain.com;

    ssl_certificate /etc/letsencrypt/live/your_domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your_domain.com/privkey.pem;

    # Additional SSL settings can be added here

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Save the file and exit the text editor.

#### 4. Test Nginx Configuration:
Ensure that there are no syntax errors in your Nginx configuration:
```bash
sudo nginx -t
```

#### 5. Restart Nginx:
```bash
sudo systemctl restart nginx
```

#### 6. Auto-Renewal (Optional):
Let's Encrypt certificates are valid for 90 days. To automatically renew them, add a cron job:
```bash
sudo crontab -e
```

Add the following line to run the renewal check daily:
```bash
0 0 * * * certbot renew --quiet
```

Save and exit the editor.
