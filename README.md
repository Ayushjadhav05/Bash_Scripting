# Multi-OS Remote Web Server Deployment Script

## 📌 Overview
This project automates the deployment of a static website on **multiple remote Linux servers** using shell scripting.

It supports **both CentOS/RHEL and Ubuntu/Debian systems** and installs all required dependencies automatically.

The setup is done from a **central machine (scriptbox)** and deployed to multiple remote servers using SSH.

---

## 🧱 Project Structure


├── multios_websetup.sh # Runs on remote servers (CentOS / Ubuntu)<br>
├── WebDeploy.sh # Runs on scriptbox (controller script)<br>
├── remhosts # List of remote hostnames or IPs
└── README.md


---

## 🔧 Scripts Explained

### 1️⃣ `multios_websetup.sh`
This script runs **on the remote server** and performs the following tasks:

- Detects the operating system (CentOS or Ubuntu)
- Installs required packages:
  - Apache web server
  - wget
  - unzip
- Starts and enables the web service
- Downloads a website template
- Deploys website files to `/var/www/html`
- Restarts the web service
- Cleans up temporary files

📌 It works on **both CentOS and Ubuntu without modification**.

---

### 2️⃣ `WebDeploy.sh`
This script runs **on the main machine (scriptbox)** and does the following:

- Reads server names/IPs from the `remhosts` file
- Copies `multios_websetup.sh` to each remote server
- Executes the script remotely using SSH
- Deletes the script from the remote server after execution
- Repeats the process for all listed servers

This allows **one-command deployment to multiple servers**.

---

### 3️⃣ `remhosts`
A plain text file containing the list of remote servers.

Example:
web01
web02
web03


Each entry should be:
- Reachable via SSH
- Properly resolvable (DNS or `/etc/hosts`)
- Accessible by the deployment user

---

## 🚀 How to Use

### ✅ Prerequisites

- Linux system (scriptbox)
- SSH access to remote servers
- Same user available on all remote machines
- `sudo` permissions on remote servers
- Passwordless SSH recommended (optional but best)

---

### 🔹 Step 1: Clone the Repository
```bash
git clone <repo-url>
cd <repo-directory>
🔹 Step 2: Update remhosts
Edit the file and add your remote servers:


vi remhosts
🔹 Step 3: Update SSH User (if needed)
In WebDeploy.sh:


USR="devops"
Change devops if your SSH user is different.

🔹 Step 4: Make Scripts Executable

chmod +x multios_websetup.sh WebDeploy.sh
🔹 Step 5: Run Deployment

./WebDeploy.sh
This will:

Connect to each server

Install Apache

Deploy the website

Start the web service

🌐 Result
After successful execution:

Apache will be running on all servers

Website will be accessible via browser:


http://<server-ip>/
🧠 Key Concepts Used
Bash scripting

SSH & SCP

OS detection

Package management (yum / apt)

Systemd service management

Looping over multiple hosts

Automation fundamentals (DevOps)

⚠️ Notes
This project is designed for lab / learning / DevOps practice

In production environments, tools like Ansible are recommended

Ensure SSH security best practices are followed

📈 Future Improvements
Passwordless SSH enforcement

Logging and error handling

Rollback mechanism

Ansible playbook version

Support for more Linux distributions

👨‍💻 Author
Created as part of Linux & DevOps automation learning.

