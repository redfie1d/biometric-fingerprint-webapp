<%-- 
    Document   : LoginUI
    Created on : 21 Nov, 2017, 2:46:13 PM
    Author     : JunMing
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Sabai | Biometric System</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.6 -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="template-resources/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
              page. However, you can choose any other skin. Make sure you
              apply the skin class to the body tag so the changes take effect.
        -->
        <link rel="stylesheet" href="template-resources/css/skins/skin-blue.min.css">
        <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
        <link rel="stylesheet" href="css/sabai.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="hold-transition skin-blue sidebar-mini <!--sidebar-collapse-->" style="background-color:#ecf0f5">

        <!-- Main Header -->
        <header class="main-header">



            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation" style="margin-left:0px">

                <!-- Logo -->
                <a class="logo" style="background-color:#3c8dbc; margin:0 auto; float:none; overflow:visible" >
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <span class="logo-mini"><b>Sb</b>B</span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><b>Sabai</b>Biometric</span>
                </a>

                <!-- Sidebar toggle button-->
                <!--                    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                                        <span class="sr-only">Toggle navigation</span>
                                    </a>-->
                <!-- Navbar Right Menu -->
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- User Account Menu -->
                        <li class="dropdown user user-menu">
                        </li>
                        <!-- Control Sidebar Toggle Button -->
                        <li>
                            <!--<a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>-->
                        </li>
                    </ul>
                </div>
            </nav>
        </header>

        <div class="container-login">

            <div class="starter-template">
                <br>
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
                            <td style="font-family:Helvetica">
                                Username:
                            </td>
                            <td>
                                <div class="form-group">
                                    <input type='text' class="form-control" name='username' />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-family:Helvetica">
                                Password:
                            </td>
                            <td>
                                <div class="form-group">
                                    <input type='password' class="form-control" name='password' />
                                </div>
                            </td>
                        </tr>
                    </table>
                    <button type="submit" class="btn btn-primary">Login</button>
                </form>
                </body>
        </div>
    </center>

</center>
</html>
