# Project-Sa-Bai-2017-GIT

Software required to be installed:
1. Netbeans IDE - Java EE (https://netbeans.org/downloads/)
2. WAMP Server - Windows (http://www.wampserver.com/en/)
3. BioMiniSDK (Check BioMini SDK; check the driver and vc 2008 redistributable options when prompted)

Starting the application:
- app is a netbeans project. Open with netbeans.
- To run the web application, clean build and run.
- Ensure WAMP Server is online(green) (if you cannot login/cannot connect to database)

Typical network infrastructure:
- 1 computer will be hosting the application locally via the LAN (e.g. Host A)
- Host A can do registration with 1 biometric scanner connected
- For other computers doing registration with a biometric scanner connected, it needs to install the softwares listed above (e.g. Host B)
- Host B will need to edit the connection.properties file and set db.host to Host A's address
- Host A need to allow db access to Host B by creating new user with Host B's address in phpmyadmin
