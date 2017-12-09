<%-- 
    Document   : Logout
    Created on : 24 Nov, 2017, 3:53:03 PM
    Author     : JunMing
--%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Successfully logged out</title>
        <!-- Bootstrap core CSS -->
        <link href="style/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%
            session.removeAttribute("user");
            session.invalidate();
        %> 

        <div class="container">

            <div class="starter-template">
                <h2 class="text-center font-vonique">You have logged out successfully.</h2>
            </div>
            <br />

            <div class="text-center">
                <a class="btn btn-primary btn-lg" href="LoginUI.jsp">Back to Login</a>
            </div>
        </div>
    </body>
</html>