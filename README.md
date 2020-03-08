# Project Sa'Bai 2017 Biometric Fingerprint Web Application
Project Sa’Bai is an overseas community involvement project (OCIP) based in Phnom Penh, Cambodia and led by students from the National University of Singapore (NUS) Yong Loo Lin School of Medicine, that has been serving the underprivileged community in Cambodia since 2006. Besides holding free medical screenings and consultations at four schools and two villages, they also run various specialist clinics such as Vision, Dental, ENT and Women’s as well as teaching villagers skills and habits for use in their daily lives. In addition, they organise direct initiatives that target community-specific needs through their Water Filtration project, and their Referral system, which aims to reconnect the locals back into the Cambodian healthcare system and meet their healthcare needs.

With the help of students from the Singapore Management University (SMU), they have also developed a fully functioning Biometrics system that captures data from a patient’s previous visits and keeps track of the population’s health over the years.

This GIT repository contains the necessary files to setup the Biometrics System used in Project Sa'Bai's clinics.

For more information, please visit https://projectsabai.com/

## Typical Network Infrastructure Set-Up

Host A
- Main computer/server hosting the application locally via the Local Area Network (LAN).
- Can do registration with 1 biometric scanner connected.
- It needs to install the softwares listed below.

Host B
- Secondary computer doing registration with a biometric scanner connected.
- It needs to install the softwares listed below.

Host C
- Computer which just connects to Host A for clinical functions other than registration.

## Softwares required to be installed for Host A & B
1. [Netbeans IDE - Java EE](https://netbeans.org/downloads/)
2. [WAMP Server - Windows](http://www.wampserver.com/en/)
3. BioMiniSDK (Tick BioMini SDK; tick the driver and vc 2008 redistributable checkboxes when prompted)

**IMPORTANT: Restart your computer after installing BioMini SDK**

## After Installing
### Database Set-Up
1. Start Up WAMP Server. Left click the WAMP icon in the taskbar, click phpMyAdmin.
2. Login with username "root" and leave password blank.
3. Create a new database called "sabai"
4. Import the schema and table structure from the database folder located in this repo.

### Host A Set-Up
1. Create a folder called "patient-images" (can be anywhere you want) and share this on your local area network:
    1. After creating, right click the newly created "patient-images" folder > Select "Properties" > Select "Sharing" Tab > Click "Share"
    2. In the Pop-up Window > Click the dropdown menu > Select "Everyone" > Set Permission Level to "Read/Write" > Click "Share"
    3. To view your shared folders in network, search "Services" > Click "Function Discovery Resource Publication" > Click "Start"


2. Replace the old image path with the new image path:
    1. Replace the path at line 115 of "CreatePatientServlet" with the path to the shared folder (e.g. "\\\\JM-ASUS-LAPTOP\\patient-images\\")
    2. Replace the path at line 81 of "UpdatePatientServlet" with the path to the shared folder
    3. Replace "imgName" in "existing_patient.jsp" & "new_consult.jsp" with the path to the shared folder


3. Allow database access for ip addresses of Host Bs in phpMyAdmin (optional if there are no Host Bs):
    1. In phpMyAdmin browser interface, click the database "sabai" > "privileges" tab > "Add user account"
    2. Key in "root" in username field, Host B's IP address in Host name field & a temporary password (e.g. 123) in password field > Tick "Check all" for Global Privileges > Click "Go"
    3. Under "User accounts" > select the newly created user account > click "Edit Privileges" > "Change Password" > Select "No Password" > Click "Go"

### Host B Set-Up
1. Edit the "connection.properties" file and set "db.host" field to Host A's IP Address to connect to Host A's database


2. Replace the old image path with the new image path:
    1. Replace the path at line 115 of "CreatePatientServlet" with the path to Host A's shared folder (e.g. "\\\\JM-ASUS-LAPTOP\\patient-images\\")
    2. Replace the path at line 81 of "UpdatePatientServlet" with the path to Host A's shared folder
    3. Replace "imgName" in "existing_patient.jsp" & "new_consult.jsp" with the path to Host A's shared folder

## Running the application
### Host A
1. The app folder is a netbeans project. Open with netbeans.
2. To run the web application, clean, build and run. Make sure the biometric scanner and external webcam is connected.
3. Start up WAMP Server. Ensure WAMP Server is online (green icon in taskbar).

* Host A can access the application via http://localhost:8084/SabaiBiometrics/
    * To let Host Bs or Cs connect to Host A, they need to know Host A's IP Address
    * To check your local IP address assigned by the router, type cmd > ipconfig > IPv4 Address

### Host B
1. The app folder is a netbeans project. Open with netbeans.
2. To run the web application, clean, build and run. Make sure the biometric scanner and external webcam is connected.
3. Host B does not need to start up a wamp server because it is connecting to Host A's database.

* Host B can access the application via http://localhost:8084/SabaiBiometrics/
    * Host B host its own seperate application from Host A to run the second biometric scanner and external webcam
    * Host B only needs to know Host A's IP Address and replace the "db.host" field of the "connection.properties" file with Host A's IP Address

### Host C
* Host C just needs to know Host A's IP Address to access the application
    * For example, if Host A's local IP Address = 192.168.X.X, type http://192.168.X.X:8084/SabaiBiometrics/ in the browser URL

## Troubleshooting
1. If typing the URL into the browser does not bring you to the application's login page:
    1. Ensure Host A's firewall is turned off to allow access.
2. If you can't login after keying in the correct credentials at the login page:
    1. If you are logging in as Host A, ensure WAMP Server is started and online (green icon in taskbar).
    2. If you are logging in as a Host B, ensure Host A has allowed your IP address access to database in phpMyAdmin.
3. When the scan button is clicked but the biometric scanner does not light up to scan:
    1. Navigate to the output of Apache Tomcat in netbeans and stop the server (click the red square button).
    2. Clean and build project again.
    3. Make sure the project is able to build successfully, before clicking run.
4. When creating a new patient, you are not given the new patient ID:
    1. This is most likely because the image path specified in CreatePatientServlet is wrong.
    2. Ensure Part 2 of Host A Set-Up is done if you are Host A. 
    3. Ensure Part 2 of Host B Set-Up is done if you are Host B.

## Contributors
Project Sa'Bai 2017
* Tam Kei Wen
* Pei Jun Ming

Project Sa'Bai 2016
* Tan Chee Wei
* Kirby Au Loong Zer
* Sim Kai Long
* Low Wen Jun
* Fu Yu

## Authors
* README.MD - Pei Jun Ming
