<%-- 
    Document   : LoginUI
    Created on : 21 Nov, 2017, 2:46:13 PM
    Author     : JunMing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sabai Biometric </title>
        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="template-resources/css/skins/skin-blue.min.css">
        <link rel="stylesheet" href="css/sabai.css">
    </head>
    <body>
        <div class="container-login">

            <div class="starter-template">
                <h1 class="font-vonique" style="text-align:center">SaBai Biometric</h1>
            </div>
            <center> 
             <%
                    String errorMsg = (String) request.getAttribute("errorMessage");

                    if (errorMsg != null) {
                        out.println("<font color='red'>" + "* " + errorMsg + "</font>");
                    }
                %>

                <form action='LoginServlet' method='post'>
                    <table>
                        <tr>
                            <td>
                                Username:
                            </td>
                            <td>
                                <div class="form-group">
                                <input type='text' class="form-control" name='username' />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Password:
                            </td>
                            <td>
                                <div class="form-group">
                                <input type='password' class="form-control" name='password' />
                                </div>
                            </td>
                        </tr>
                    </table>
                    <button type="submit" class="btn btn-primary">Login!</button>
                </form>
                </body>
        </div>
            </center>
               
    </center>
</html>
