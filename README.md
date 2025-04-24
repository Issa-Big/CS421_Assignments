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


 ### 2.3.Install PM2 to Keep API Running
 
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

### 2.4 Configure Nginx as a Reverse Proxy

>>>Open the nginx default file and replace the existing location / block with:
![Pasted image (17)](https://github.com/user-attachments/assets/c8c59c1e-c68d-4ebe-89b6-b09fe54e187a)

>>>Then run :
```
sudo nginx -t
sudo systemctl restart nginx
```
![Pasted image (18)](https://github.com/user-attachments/assets/9f71bc3d-11ef-4391-9c56-dee29634479b)

### 2.5 Test the API
Locate the url to the browser to see if the API works 

>>> For **/student**
http://16.171.238.29/students

![Pasted image (19)](https://github.com/user-attachments/assets/f50fa42c-3b48-4184-b2f9-83738b298e7d)

>>> For **/subject**
http://16.171.238.29/subjects

![Pasted image (20)](https://github.com/user-attachments/assets/9c4aea23-56b7-4687-b3b5-8db71d7f3c46)

Thank You Sir....!!!
