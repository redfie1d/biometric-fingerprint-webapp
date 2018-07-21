<%-- 
    Document   : webcam_test
    Created on : 24 Nov, 2016, 8:27:47 PM
    Author     : tcw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Untitled Document</title>
        <script src="js/jquery.min.js"></script>
    </head>

    <body>
        <script src="js/webcam.js"></script>

        <div id="my_camera" style="width:320px; height:240px;"></div>
        <div id="my_result"></div>

        <script language="JavaScript">
            
            $(document).ready(function () {
                $("#abc123").click(function () {
                    alert("a");
                    Webcam.attach('#my_camera');
                });


            });

            function take_snapshot() {
                Webcam.snap(function (data_uri) {
                    document.getElementById('my_result').innerHTML = '<img src="' + data_uri + '"/>';
                });
            }
        </script>

        <a href="javascript:void(take_snapshot())">Take Snapshot</a>
        <button id="abc123">123</button>
    </body>
</html>
