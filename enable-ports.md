**1. Access Azure Portal:**
   - Log in to the Azure Portal (https://portal.azure.com) using your Azure account.

**2. Locate Your Virtual Machine:**
   - In the Azure Portal, find and select the virtual machine (VM) you want to configure.

**3. Configure Network Security Groups (NSG):**
   - Network Security Groups control inbound and outbound traffic to your virtual machine. You need to configure NSGs to allow traffic on the desired ports.

**4. Add Inbound Security Rules:**
   - In the VM's settings, navigate to the "Networking" or "Network Security Group" section. Then, add new inbound security rules for UI and API access. You can create separate rules for each. Here's how to do it:

   a. For UI Access (e.g., HTTP on port 80 and HTTPS on port 443):
      - Create a rule for HTTP:
        - Name: HTTP
        - Protocol: TCP
        - Port range: 80
        - Action: Allow
        - Source: Any (0.0.0.0/0 for open access)
      - Create a rule for HTTPS:
        - Name: HTTPS
        - Protocol: TCP
        - Port range: 443
        - Action: Allow
        - Source: Any or your specific IP range.

   b. For API Access (e.g., a custom port like 8080):
      - Create a rule for your API port (e.g., 8080):
        - Name: YourAPI
        - Protocol: TCP
        - Port range: 8080
        - Action: Allow
        - Source: Any or your specific IP range.

**5. Apply Changes:**
   - Save and apply the changes to the network security group.

**6. Verify Access:**
   - After the rules are applied, you should be able to access the UI and API from your specified IP range. Test the access to ensure it's working correctly.