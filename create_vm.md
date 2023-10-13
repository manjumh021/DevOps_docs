Creating a new Ubuntu VM in Azure is a common task in the realm of DevOps. Here are the steps to create a new Ubuntu VM in Azure:

1. **Log in to the Azure Portal**:
   - Open your web browser and navigate to the Azure Portal (https://portal.azure.com).
   - Sign in with your Azure account.

2. **Create a Resource Group** (if needed):
   - A resource group is a logical container for your Azure resources. You can create one or use an existing group.

3. **Click on "Create a Resource"**:
   - In the Azure Portal, click on the "+ Create a resource" button.

4. **Search for "Ubuntu Server"**:
   - In the Azure Marketplace, search for "Ubuntu Server" and select it.

5. **Click "Create"**:
   - Click the "Create" button to begin configuring your VM.

6. **Basic Settings**:
   - Fill in the basic settings, such as the VM name, region, availability options, and resource group.

7. **Instance Details**:
   - Choose the virtual machine series, such as "General Purpose" or "Compute Optimized."
   - Select the desired size and number of virtual machines.
   - Choose "Ubuntu Server" as the image.

8. **Administrator Account**:
   - Enter a username and password for the administrator account.
   - It's recommended to use SSH keys for added security. If you prefer this method, you can provide your SSH public key.

9. **Inbound Port Rules**:
   - Configure inbound port rules. Typically, you'll want to open port 22 for SSH and port 80 for HTTP access. Add other rules as needed.

10. **Tags (Optional)**:
    - Add tags to your VM for easier organization.

11. **Review + Create**:
    - Review your settings, and when you're satisfied, click "Review + Create."

12. **Review + Create (Again)**:
    - Azure will perform a validation check. If everything is in order, click "Create" to start the deployment process.

13. **Deployment**:
    - The VM deployment will begin. You can monitor the progress in the Azure Portal.

14. **Access Your VM**:
    - Once the deployment is complete, you can access your Ubuntu VM using SSH. Use the public IP address and the username/password or SSH key you provided.