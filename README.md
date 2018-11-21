# Project-Sa-Bai-2017-GIT

## Typical Network Infrastructure Setup

Host A:
- Main computer/server hosting the application locally via the Local Area Network (LAN)
- Can do registration with 1 biometric scanner connected

Host B:
- Secondary computer doing registration with a biometric scanner connected
- It needs to install the softwares listed above

Host C:
- Computer which just connects to Host A's ip address for clinical functions other than registration.

## Softwares required to be installed for Host A & B
1. Netbeans IDE - Java EE (https://netbeans.org/downloads/ )
2. WAMP Server - Windows (http://www.wampserver.com/en/ )
3. BioMiniSDK (Tick BioMini SDK; tick the driver and vc 2008 redistributable checkboxes when prompted)

***IMPORTANT Restart your computer after installing BioMini SDK***

## After Installing
### Host A Requirements
1. Allow database access for ip addresses of Host Bs in phpMyAdmin
- In phpMyAdmin interface, click sabai > privileges > Add user account
- Key in root in username field, Host B's IP address in Host name field & a temporary password (e.g. 123) in password field > Tick check all for global privileges > Click go
- Under User accounts > select the newly created user account > click Edit Privileges > Change Password > Select No Password > Click go

2. Create a folder called patient-images (can be anywhere) and share this on the Local Area Network (LAN)
- Right click the newly created patient-images folder > properties > Sharing tab > Click Share
- In the pop-up window > Click the dropdown menu > Select Everyone > Set Permission Level to Read/Write > Click Share
- To view your shared folders in network, Services > Function Discovery Resource Publication > Start

3. Replace image path in netbeans project files
- Replace line 115 of CreatePatientServlet with the path to the shared folder (e.g. "\\\\JM-ASUS-LAPTOP\\patient-images\\")
- Replace line 81 of UpdatePatientServlet with the path to the shared folder
- Replace imgName in existing_patient.jsp & new_consult.jsp with the path to the shared folder

### Host B Requirements
1. Need to edit the connection.properties file and set db.host to Host A's address
2. Replace image path in netbeans project files
- Replace line 115 of CreatePatientServlet with the path to the shared folder (e.g. "\\\\JM-ASUS-LAPTOP\\patient-images\\")
- Replace line 81 of UpdatePatientServlet with the path to the shared folder
- Replace imgName in existing_patient.jsp & new_consult.jsp with the path to the shared folder

### Database Credentials
- phpMyAdmin username: root
- Password is blank

## Running the application
### Host A
1. The app folder is a netbeans project. Open with netbeans.
2. To run the web application, clean build and run. Make sure the biometric scanner and external webcam is connected.
3. Start up WAMP Server. Ensure WAMP Server is online (green icon in taskbar)

- For Host A, it can access the application via http://localhost:8084/SabaiBiometrics/
- To let other hosts connect to Host A, they need to know Host A's IP Address
- To check your local IP address assigned by the router, type cmd > ipconfig > IPv4 Address

### Host B
1. The app folder is a netbeans project. Open with netbeans.
2. To run the web application, clean build and run. Make sure the biometric scanner and external webcam is connected.
3. Host B does not need to start up a wamp server if it is connecting to Host A's database.

### Host C
- Host C just needs to connect to Host A's IP Address
- For example, if Host A's local IP Address = 192.168.X.X, type http://192.168.X.X:8084/SabaiBiometrics/ in the browser URL

## Troubleshooting
1. If typing the URL into the browser does not bring you to the application's login page, ensure Host A's firewall is off.
2. If you can't login after keying in the correct credentials, there might be 2 causes:
- If you are logging in as Host A, ensure WAMP Server is started and online (green icon in taskbar)
- If you are logging in as a Host B, ensure Host A has allowed your IP address access to database in phpMyAdmin.
3. When scan button is clicked and biometric scanner does not scan, navigate to the output of Apache Tomcat in netbeans and stop the server (red square button). Clean and build project again, making sure that project is able to be built successfully, before running project. 
4. When we click the create new patient button in new patient registration and patient ID does not appear, its most likely the image path specified in CreatePatientServlet is wrong. Ensure Part 3 of Host A Requirements is done if you are Host A. Ensure Part 2 of Host B Requirements is done if you are Host B.
