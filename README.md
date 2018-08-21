# Project-Sa-Bai-2017-GIT

Software required to be installed:
1. Netbeans IDE - Java EE (https://netbeans.org/downloads/)
2. WAMP Server - Windows (http://www.wampserver.com/en/)
3. BioMiniSDK (Check BioMini SDK; check the driver and vc 2008 redistributable options when prompted)

Starting the application
- app is a netbeans project. Open with netbeans.
- To run the web application, clean build and run.
- Ensure WAMP Server is online(green) (if you cannot login/cannot connect to database)

Typical network infrastructure setup

Host A:
- Main computer/server hosting the application locally via the LAN
- Can do registration with 1 biometric scanner connected

Host B:
- Secondary computer doing registration with a biometric scanner connected, it needs to install the softwares listed above.

Host C:
- Computer which just connects to Host A's ip address for clinical functions other than registration.

Host A requirements:
- Need to allow db access to Host B's address by creating new user with Host B's address in phpmyadmin
- Need to set up a shared folder containing patient images for Host Bs to read/write patient image when creating/updating patient.

Host B requirements:
- Need to edit the connection.properties file and set db.host to Host A's address
- Edit imgName in existing_patient.jsp & new_consult.jsp to folder path shared by Host A
