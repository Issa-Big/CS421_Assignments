Simple API with students and subjects for Software Engineering program - CS421 Assignments

This project is a part of the **Application Deployment and Management (CS421)** course at **University of Dodoma**. It demonstrates the creation and deployment of a simple RESTful API with two endpoints using **Node.js** and **Express.js**.

## 👨‍💻 Author
- **Name**: ISSA AMANI MFALLA
- **Reg No.**: T21-03-14087
- **Course**: BSc in Software Engineering

## 📌 Project Description

### 1.0 Specific Tasks:
This API exposes two endpoints:

- **GET /students**  
  Returns a list of 10 students with their full names and enrolled programs.

- **GET /subjects**  
  Returns a list of Software Engineering subjects, grouped by academic year (Year 1 to Year 4).


---

## ⚙️ Setup Instructions

### 1.1. Clone the Repository

```bash
git clone https://github.com/Issa-Big/CS421_Assignments.git
cd CS421_Assignments
```
**1.2. Install Dependencies**
Ensure you have Node.js and npm installed

Run this command in your terminal to install all the usefull dependencies
```
npm init -y
npm install express
```
###  1.3. Create/Edit **index.js** 
This is where you will write your API code and save them withim the same directory you install the dependencies and configuration files.

### 1.4. Run Your API
Save the file, then in terminal:

```
node index.js
```
You should see after running that command:

```
Server running at http://localhost:3000
```
Now open your browser and test localy to see if the code run effectively:
```
http://localhost:3000/students
```
![Pasted image (2)](https://github.com/user-attachments/assets/9c547923-f675-4d49-8fd7-67088007bd07)

```
http://localhost:3000/subjects
```
![Pasted image](https://github.com/user-attachments/assets/9f20e103-2dd8-40bf-9820-69a81e6bd6cd)


 ### 2.0 Deployment on AWS

>>>Go to https://aws.amazon.com/console and log in.

>>>Navigate to EC2 > Instances > Launch Instance.

>>>Select:

    Name: CS421-api

    AMI: Ubuntu Server 22.04 LTS (free tier eligible)

    Instance type: t3.micro

    Key pair: Create or use an existing one

    Security Group: Open ports 22 (SSH), 80 (HTTP)
    
![Pasted image (3)](https://github.com/user-attachments/assets/049b5264-0b69-4763-ab70-a18385d6167e)

![Pasted image (4)](https://github.com/user-attachments/assets/7e9e0ce6-68ef-46b0-bb27-7b172f266268)

![Pasted image (5)](https://github.com/user-attachments/assets/5b4b65ef-179e-448b-b6d5-faa978f4a9ea)


>>>Launch it and note the Public IPv4 address.

Looking on the instance we can see that the server status is running and we got a public ip address to host our API.
![Pasted image (6)](https://github.com/user-attachments/assets/2a3a6182-2b38-4c4f-8ee8-08124f7c308e)


**### 2.1 SSH into the Instance**
>>>From your terminal run:
```
sudo ssh -i myKey.pem ubuntu@16.171.238.29 ### your public-ip address from the aws instance
```
![Pasted image (7)](https://github.com/user-attachments/assets/626df91e-589c-45a0-9571-e5dd9b90b78d)

>>>Install Node.js and Nginx on the Server
```
sudo apt install nodejs npm -y
```
![Pasted image (8)](https://github.com/user-attachments/assets/e903bccb-aee3-4afb-a137-75e9ef5bf5a5)

>>>Verify versions
```
node -v
npm -v
```
![Pasted image (9)](https://github.com/user-attachments/assets/797e1a54-ef2a-4cf6-be2f-ccc524a08cc2)

>>>Install Nginx
```
sudo apt install nginx -y
```
![Pasted image (10)](https://github.com/user-attachments/assets/7033c461-ffc7-46d2-9287-5c7bd0db3f44)

>>>Start and enable Nginx
```
sudo systemctl start nginx
sudo systemctl enable nginx
```
![Pasted image (11)](https://github.com/user-attachments/assets/d75e024c-8bcd-4b04-b5df-8fb660b2d4f2)

### 2.2 Transfer Your API to the Server
>>> From my  local machine (in my  project directory):
```
scp -i myKey.pem -r * ubuntu@16.171.238.29:/home/ubuntu/CS421-API
```
![Pasted image (16)](https://github.com/user-attachments/assets/908e7c68-ef91-47c6-bede-1373de3cb939)

>>>Then on the server:
```
cd CS421-API
npm install
```
![Pasted image (12)](https://github.com/user-attachments/assets/34ad30a2-76b2-4929-b659-319e8e89d19b)

### 2.3 Creating Database on the server
>>>Using MYSQL database by installing it in the server and start mysql service. 
![image](https://github.com/user-attachments/assets/06050c1f-5a06-4f50-85d3-8dcf801bb0c1)

>>>Create tables subjects and students
![image](https://github.com/user-attachments/assets/62a1fa51-9435-4c4f-ada0-eafb0ef6597f)

>>>Inserting the data on the tables
![image](https://github.com/user-attachments/assets/ed551145-13cd-4f1b-b7e2-5384bd510aac)

>>> Ok then the data are succesfully inserted
![image](https://github.com/user-attachments/assets/cac64498-0051-451b-aa26-519c455e142c)

 ### 2.4.Install PM2 to Keep API Running
 
>>>Then on the server:
```
sudo npm install -g pm2
```
![Pasted image (13)](https://github.com/user-attachments/assets/492a3f69-be85-4923-842b-e2964b0a04ad)

```
pm2 start index.js
```
![Pasted image (14)](https://github.com/user-attachments/assets/f96fa992-c536-4f1e-8dab-6a9efcb5ecfd)

```
pm2 startup
pm2 save
``
![Pasted image (15)](https://github.com/user-attachments/assets/e93d813c-6eb7-4f1a-9fff-6764d068fdd1)
```

### 2.5 Configure Nginx as a Reverse Proxy

>>>Open the nginx default file and replace the existing location / block with:
![Pasted image (17)](https://github.com/user-attachments/assets/c8c59c1e-c68d-4ebe-89b6-b09fe54e187a)

>>>Then run :
```
sudo nginx -t
sudo systemctl restart nginx
```
![Pasted image (18)](https://github.com/user-attachments/assets/9f71bc3d-11ef-4391-9c56-dee29634479b)

### 2.6 Test the API
Locate the url to the browser to see if the API works 

>>> For **/student**
http://16.171.238.29/students

![Pasted image (19)](https://github.com/user-attachments/assets/f50fa42c-3b48-4184-b2f9-83738b298e7d)

>>> For **/subject**
http://16.171.238.29/subjects

![Pasted image (20)](https://github.com/user-attachments/assets/9c4aea23-56b7-4687-b3b5-8db71d7f3c46)

Thank You Sir....!!!
###########################################################################################################################


##############################################  ASSIGNNMENT 2 ################################################################

### 3.0 Backup Schemes

**A.Full Backup**: A complete copy of all data every time a backup is made. The system saves every file and database at once, regardless of whether it has changed or not.

  >>>Advantages:

  Simplified restore process.

  All data is backed up in a single operation.

 >>>Disadvantages:

  Requires more time and storage space.

  Can cause heavy load during backup.

  **B. Incremental Backup** :  Only backs up data that has changed since the last backup (whether full or incremental). After the first full backup, each new backup only saves new or modified files.

  >>>Advantages:

  aves time and storage.

  Efficient for frequent backups.

  >>>Disadvantages:

  Slower recovery, because multiple incremental backups must be restored in sequence.

  Backup chain becomes complex.

**C. Differential Backup :** Backs up all changes made since the last full backup. After a full backup, each differential backup keeps growing until the next full backup is made.
 
>>> Advantages:

  Faster restore than incremental backup (only full + last differential needed).

  Easier backup management compared to incremental.

>>>Disadvantages:

  Larger backup sizes than incremental.

  Time for backup increases as more changes accumulate.

  ### 3.1 Bash Script Development.
  All the script i need to Copy scripts to your server under `~/CS421_API/bash_scripts`.  
  
**A.health_check.sh** 

  >>>What This Script Does:
  ✅ Logs CPU, memory, and disk usage

  ✅ Warns if disk space is above 90%

  ✅ Checks if Nginx is running

  ✅ Sends curl request to /students and /subjects

  ✅ Logs everything to /var/log/server_health.log with timestamps
  
>>>After ttest manually we can see the result of the script 
![image](https://github.com/user-attachments/assets/deb9656a-046b-4c0d-9aed-ea1643d3c911)


### B.backup_api.sh
✅ Create /home/ubuntu/backups directory if missing	
✅Compress the API project folder (CS421-API) into a .tar.gz	
✅Export your MySQL database into a .sql file	
✅ Delete any backup files older than 7 days	
✅Log every step into /var/log/backup.log

After test manually we can see the result of the script
>>>You can  see files like:
![image](https://github.com/user-attachments/assets/271d722b-a29d-410c-917b-5d49add7f407)

>>>Check the logs in ``` cat /var/log/backup.log ```

### C.update_server.sh

This script will:
✅Update Ubuntu packages (apt update && apt upgrade -y)

✅Pull latest changes from your GitHub repository (Assignment 1 project)

✅Restart Nginx to apply any API changes

✅Log everything into /var/log/update.log

✅Handle errors safely (e.g., if Git pull fails, don't restart services)

Through testing manually we can see the scripts works perfectly
![image](https://github.com/user-attachments/assets/806673d6-b1cf-4cf9-80ec-5b41111c2768)

We can see changes were successfully pulled to the git repo
![image](https://github.com/user-attachments/assets/c077010a-5f5a-4485-ac94-266cb597867e)


### 3.2 Setup & Usage  
1. Copy scripts to your server under `~/bash_scripts`.  
2. `chmod +x bash_scripts/*.sh` 
![image](https://github.com/user-attachments/assets/871a88fb-1283-465a-8de6-267f3c827a89)

### Dependencies: `curl`, `tar`, `mysql_dump` (MYSQL client), `git`, `systemctl` .

### Scheduling (cron)

Check if Cron is Installed
```
sudo systemctl status cron
```
![image](https://github.com/user-attachments/assets/4b71f79c-4efe-48af-afb9-c1bf77f4af08)

Once it's installed, you can enable and start it
```
sudo systemctl enable cron
sudo systemctl start cron
```
![image](https://github.com/user-attachments/assets/442b19fe-c98d-45d6-8f3b-0f2538eb6240)


```cron
# Run health_check every 6 hours
0 */6 * * * /home/ubuntu/CS421_API/bash_scripts/health_check.sh >> /var/log/server_health.log 2>&1

# Run backup_api daily at 2 AM
0 2 * * * /home/ubuntu/CS421_API/bash_scripts/backup_api.sh >> /var/log/backup.log 2>&1

# Run update_server every 3 days at 3 AM
0 3 */3 * * /home/ubuntu/CS421_API/bash_scripts/update_server.sh >> /var/log/update.log 2>&1
```
![image](https://github.com/user-attachments/assets/c74dd620-051d-485c-85db-330760233b3d)

### Important Reminder

If you get a "permission denied" error when scripts run manually:

    Check the script permissions:
```
chmod +x /home/ubuntu/CS421_API/bash_scripts/*.sh
```
Or if a log file cannot be written:
```
sudo chmod 666 /var/log/*.log
```


### Deployment
The API has been deployed on an AWS Ubuntu server. Access it at: [http://16.171.238.29/subjects] [http://16.171.238.29/students]
