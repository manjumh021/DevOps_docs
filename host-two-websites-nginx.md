To achieve hosting two websites using Nginx with a subdirectory approach, you can use the following configuration. Let's assume your main site is located in the root directory and the admin site is located in the "/system-control" subdirectory.

1. **Create the directories and sample HTML files:**

   ```bash
   mkdir /var/www/main-site
   mkdir /var/www/admin-site
   ```

   Create sample HTML files:

   **/var/www/main-site/index.html:**

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta http-equiv="X-UA-Compatible" content="IE=edge">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Main Site</title>
   </head>
   <body>
       <h1>Main Site Content</h1>
   </body>
   </html>
   ```

   **/var/www/admin-site/index.html:**

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta http-equiv="X-UA-Compatible" content="IE=edge">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Admin Site</title>
   </head>
   <body>
       <h1>Admin Site Content</h1>
   </body>
   </html>
   ```

2. **Nginx Configuration:**

   Create a new Nginx configuration file, for example, `/etc/nginx/sites-available/example.com`.

   ```nginx
   server {
       listen 80;
       server_name xx.xx.xx.xx;

       root /var/www/main-site;
       index index.html;

       location /system-control {
           alias /var/www/admin-site;
           index index.html;
       }

       location / {
           try_files $uri $uri/ =404;
       }
   }
   ```

   This configuration listens on port 80 and handles requests to the IP address `xx.xx.xx.xx`. It serves the main site from the root directory and the admin site from the "/system-control" subdirectory.

3. **Create a symbolic link to enable the site:**

   ```bash
   ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
   ```

4. **Test Nginx configuration:**

   Ensure there are no syntax errors in your configuration:

   ```bash
   nginx -t
   ```

5. **Reload Nginx:**

   ```bash
   service nginx reload
   ```

Now, you should be able to access the main site by visiting `http://xx.xx.xx.xx` and the admin site by visiting `http://xx.xx.xx.xx/system-control` in your web browser. Adjust the paths and configurations according to your specific setup and requirements.