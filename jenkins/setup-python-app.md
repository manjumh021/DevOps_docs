Here’s a complete step-by-step documentation you can include in your internal docs for enabling Jenkins to run `sudo` commands in a pipeline using **passwordless `sudo` access** via `sudoers`:

---

## 🧰 Setting Up Passwordless `sudo` for Jenkins in CI/CD Pipelines

### ✅ Objective

Allow the Jenkins user to execute specific `sudo` commands (`mv`, `systemctl`) without being prompted for a password. This enables systemd service deployment or restart from within Jenkins pipelines securely.

---

### 🔐 Why Use Passwordless `sudo`?

* Prevents Jenkins pipeline from getting stuck or failing due to password prompts.
* Avoids storing sensitive passwords in Jenkins credentials.
* Ensures smooth, unattended execution in CI/CD environments.
* Limits sudo access only to necessary commands (minimizing risk).

---

### 🪜 Steps

#### 1. **Log in to the Jenkins Host**

SSH into the server where Jenkins is installed and running.

```bash
ssh user@your-server-ip
```

---

#### 2. **Open the `sudoers` file securely**

Use the `visudo` command to safely edit the `sudoers` file. This prevents syntax errors that could lock you out.

```bash
sudo visudo
```

---

#### 3. **Add the following rule for Jenkins user**

At the end of the file, add:

```bash
jenkins ALL=(ALL) NOPASSWD: /bin/mv, /bin/systemctl
```

> 🔁 Replace `jenkins` with the actual user Jenkins is running as, if different.

---

#### 4. **Save and exit**

* If using `nano` inside `visudo`: press `Ctrl+O` to save, then `Ctrl+X` to exit.
* If using `vi`: press `Esc`, then type `:wq` and press `Enter`.

---

#### 5. **Verify sudo access**

Switch to the Jenkins user (if not already running as it):

```bash
sudo -u jenkins -i
```

Then try the following test:

```bash
sudo -n systemctl status
```

* If you **don’t see a password prompt**, it’s working correctly.
* If you get a `sudo: a password is required` error, review the `sudoers` configuration.

---

### 🧪 Sample Jenkins Pipeline Snippet

```groovy
pipeline {
    agent any

    environment {
        APP_NAME = "python-app"
        REPO_URL = "https://github.com/manjumh021.git"
        BRANCH = "main"
        WORKDIR = "/root/dev_ops"
        VENV_DIR = "${WORKDIR}/venv"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: "${BRANCH}", credentialsId: 'github_token', url: "${REPO_URL}"
            }
        }

        stage('Set up Virtual Environment') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Create systemd service') {
            steps {
                script {
                    def serviceFile = """
                    [Unit]
                    Description=FastAPI App
                    After=network.target

                    [Service]
                    User=jenkins
                    WorkingDirectory=${WORKDIR}
                    ExecStart=${VENV_DIR}/bin/gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app --bind 0.0.0.0:8000
                    Restart=always

                    [Install]
                    WantedBy=multi-user.target
                    """
                    writeFile file: "${APP_NAME}.service", text: serviceFile

                    sh """
                        sudo mv ${APP_NAME}.service /etc/systemd/system/${APP_NAME}.service
                        sudo systemctl daemon-reexec
                        sudo systemctl daemon-reload
                        sudo systemctl enable ${APP_NAME}
                        sudo systemctl restart ${APP_NAME}
                    """
                }
            }
        }
    }
}
```

---

### ✅ Summary

| Item                       | Status |
| -------------------------- | ------ |
| Password prompt avoided    | ✅      |
| Secure shell compatibility | ✅      |
| Commands scoped to need    | ✅      |

---
