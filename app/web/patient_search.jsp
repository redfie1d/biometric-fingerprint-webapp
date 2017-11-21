<%-- 
    Document   : search_patient
    Created on : Nov 24, 2016, 5:51:06 PM
    Author     : yu.fu.2015
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Patient Record</title>
    </head>
    <body>
        <form action="SearchPatientServlet">
            Patient ID: <input type="text" name="patientID" value=""/>
            <input type="submit" value="Search" />
        </form>
        <%
            String errorMsg = (String)request.getAttribute("errorMsg");
            if(errorMsg!=null){
                out.print(errorMsg);
            }
        %>
    </body>
</html>
