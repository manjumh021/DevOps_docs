To add a subdomain to an existing domain in Namecheap, you can follow these steps:

1. **Log in to Your Namecheap Account:**
   - Visit the Namecheap website (https://www.namecheap.com) and log in to your account using your username and password.

2. **Access Your Domain List:**
   - Once you're logged in, click on "Domain List" or a similar option in the dashboard to access the list of your domains.

3. **Select the Domain:**
   - Find and select the domain to which you want to add a subdomain.

4. **Navigate to DNS Management:**
   - Look for an option like "Manage Domains," "Manage," or "Manage Domain." Click on it to access the domain management options.

5. **Add a DNS Record for the Subdomain:**
   - To create a subdomain, you need to add a DNS record for it. Look for an option like "DNS Management," "Advanced DNS," or "Manage DNS." Click on it to access your domain's DNS settings.

6. **Create a Subdomain Record:**
   - In your DNS settings, you will add a new DNS record for the subdomain. This is typically done by creating a "CNAME" or "A" record.
     - **CNAME Record**: To create a CNAME record, select "CNAME" as the record type and enter the subdomain you want (e.g., "subdomain") as the host, and the destination or target (e.g., the fully qualified domain name or URL to which the subdomain points) in the "Value" or "Points to" field.
     - **A Record**: To create an A record, select "A" as the record type and enter the subdomain in the "Host" field and the IP address of the server or destination in the "Value" field.

7. **Save Your DNS Record:**
   - After entering the necessary information, save the DNS record. This will configure the subdomain to point to the specified destination.

8. **Wait for DNS Propagation:**
   - It may take some time for the DNS changes to propagate across the internet. DNS propagation can take from a few minutes to several hours. During this period, your subdomain may not be accessible from all locations.

9. **Test Your Subdomain:**
   - Once DNS propagation is complete, you can test your subdomain by entering it in a web browser or using other networking tools to verify that it's pointing to the correct destination.