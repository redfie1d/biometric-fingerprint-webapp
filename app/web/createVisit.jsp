<%-- 
    Document   : createVisit
    Created on : Dec 1, 2016, 2:13:36 PM
    Author     : yu.fu.2015
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create A Visit</title>
    </head>
    <body>
        <%String patientId = request.getParameter("patientId");%>
        <form action="CreateVisitServlet">
            Patient ID: <input type="text" name="patientId" value=<%=patientId%> />
            <input type="submit" value="Create" />
        </form>
        <%
            String successMsg = (String)request.getAttribute("successMsg");
            if(successMsg!=null){
                out.print(successMsg);
                
            }
            
        %>
        <a href="starter.jsp">Register Patient</a>
    </body>
</html>
