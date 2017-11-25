<%-- 
    Document   : protect
    Created on : 24 Nov, 2017, 4:00:21 PM
    Author     : JunMing
--%>

<%@page import="model.User"%>
<%    
    // authenticate user
    if (session.getAttribute("user") == null){
        response.sendRedirect("LoginUI.jsp");
    } 

    User user = (User) session.getAttribute("user");
%>
