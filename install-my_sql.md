1. **Update Package Repositories**:

   Before installing any software, it's a good practice to ensure your package repositories are up to date:

   ```bash
   sudo apt-get update
   ```

2. **Install MySQL Server**:

   You can install the MySQL Server package using the following command:

   ```bash
   sudo apt-get install mysql-server
   ```

3. **Secure Your MySQL Installation**:

   After installation, you should run a script to secure your MySQL installation. This script will guide you through several security-related questions and set a root password, remove anonymous users, disallow root login remotely, and more:

   ```bash
   sudo mysql_secure_installation
   ```

   Follow the prompts to configure your MySQL installation securely.

4. **Start and Enable MySQL Service**:

   MySQL might not start automatically after installation. You can start and enable the service with these commands:

   ```bash
   sudo systemctl start mysql
   sudo systemctl enable mysql
   ```

5. **Check MySQL Status**:

   You can check the status of MySQL to ensure it's running properly:

   ```bash
   sudo systemctl status mysql
   ```

   You should see output indicating that MySQL is active and running.

6. **Access MySQL**:

   You can access MySQL by running the following command:

   ```bash
   sudo mysql
   ```

   You can now use MySQL commands to interact with the database.

7. **Optional: Create a Database and User**:

   If you want to create a new database and user, you can do so using MySQL commands. For example, to create a database named "mydatabase" and a user named "myuser" with a password, you can use the following commands:

   ```sql
   CREATE DATABASE mydatabase;
   GRANT ALL ON mydatabase.* TO 'myuser'@'localhost' IDENTIFIED BY 'mypassword';
   FLUSH PRIVILEGES;
   ```

   Replace `'myuser'`, `'mypassword'`, and `'mydatabase'` with your desired values.