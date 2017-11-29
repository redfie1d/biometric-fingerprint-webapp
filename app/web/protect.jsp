<%-- 
    Document   : protect
    Created on : 24 Nov, 2017, 4:00:21 PM
    Author     : JunMing
--%>

<%@page import="dao.UserDAO"%>
<%@page import="model.User"%>
<%    
    // authenticate user
    /*if (session.getAttribute("user") == null){
        response.sendRedirect("LoginUI.jsp");
    } */
    
    UserDAO userDao = new UserDAO();
    //User user = (User) session.getAttribute("user");
    User user = userDao.retrieve("admin");
%>
