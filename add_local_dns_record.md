You can test the `example.com` application without adding the IP to DNS by modifying your local `hosts` file. This allows you to map the domain to the IP address locally on your machine. Here’s how you can do it:

### For Windows:
1. **Open Notepad as Administrator**:
   - Search for "Notepad" in the Start menu.
   - Right-click on Notepad and select "Run as administrator."
   
2. **Open the Hosts File**:
   - In Notepad, go to `File > Open`.
   - Navigate to `C:\Windows\System32\drivers\etc\`.
   - In the "File name" field, type `hosts` and click `Open`.
   
3. **Add the Domain and IP Address**:
   - At the end of the file, add a new line with the IP address followed by the domain name. For example:
     ```
     123.456.789.101 example.com
     ```
   - Replace `123.456.789.101` with the actual IP address of your server.
   
4. **Save the File**:
   - Save the file and close Notepad.
   
5. **Flush DNS Cache (Optional)**:
   - Open Command Prompt as Administrator and run:
     ```
     ipconfig /flushdns
     ```

### For macOS/Linux:
1. **Open the Terminal**.
   
2. **Edit the Hosts File**:
   - Run the following command to edit the hosts file with a text editor like `nano`:
     ```bash
     sudo nano /etc/hosts
     ```
   
3. **Add the Domain and IP Address**:
   - At the end of the file, add a new line with the IP address followed by the domain name. For example:
     ```
     123.456.789.101 example.com
     ```
   - Replace `123.456.789.101` with the actual IP address of your server.
   
4. **Save and Exit**:
   - Press `Ctrl + O` to save, then `Ctrl + X` to exit.
   
5. **Flush DNS Cache (Optional)**:
   - On macOS, you can flush the DNS cache by running:
     ```bash
     sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
     ```
   - On Linux, the command may vary depending on the distribution. Common commands include:
     ```bash
     sudo systemctl restart network-manager
     ```
   
After doing this, when you visit `example.com` in your browser, it will resolve to the IP address you specified without needing to update the DNS.

To verify that `example.com` is indeed pointing to the server with IP `156.88.44.66` after modifying your `hosts` file, you can follow these steps:

### 1. **Using Command Line Tools**

#### **On Windows:**
- **Use `ping` Command:**
  - Open Command Prompt (`cmd`).
  - Run the following command:
    ```bash
    ping example.com
    ```
  - Check the IP address in the response. It should show `156.88.44.66`.

#### **On macOS/Linux:**
- **Use `ping` Command:**
  - Open Terminal.
  - Run the following command:
    ```bash
    ping example.com
    ```
  - Check the IP address in the response. It should show `156.88.44.66`.

- **Use `dig` Command (Linux and macOS):**
  - Open Terminal.
  - Run the following command:
    ```bash
    dig +short example.com
    ```
  - This command should return `156.88.44.66` if your `hosts` file is correctly configured.

### 2. **Check in Browser's Developer Tools**
- Open your browser and navigate to `example.com`.
- Right-click on the page and select "Inspect" or press `F12` to open Developer Tools.
- Go to the "Network" tab and reload the page.
- Click on the first request (usually `example.com`).
- In the "Headers" section, check the "Remote Address" or "Host" field. It should display `156.88.44.66`.

### 3. **Using cURL**
- **On macOS/Linux/Windows (with cURL installed):**
  - Open Terminal or Command Prompt.
  - Run the following command:
    ```bash
    curl -I http://example.com
    ```
  - The response headers should show the server information, indicating that the request was served by the application hosted on `156.88.44.66`.

If everything is set up correctly, these methods will confirm that `example.com` is resolving to `156.88.44.66` on your local machine.