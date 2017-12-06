<%-- 
    Document   : createTriageAndConsult
    Created on : Dec 1, 2016, 2:39:05 PM
    Author     : yu.fu.2015
--%>

<%@page import="model.Vitals"%>
<%@page import="dao.VitalsDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.VisitDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Triage And Consult</title>
    </head>
    <body>
        
        Create Triage
        <form action="CreateVitalsServlet" method="POST">
            <input type="text" name="visitId" value=""/>
            <input type="text" name="height" value="" />
            <input type="text" name="weight" value="" />
            <input type="text" name="systolic" value="" />
            <input type="text" name="diastolic" value="" />
            <input type="submit" value="Create Triage" />
        </form>
        <%
            String successMsg = (String) request.getAttribute("successMsg");
            if (successMsg != null) {
                out.print(successMsg);
                int visitId = (int) request.getAttribute("visitId");
                String visitID = ""+visitId;
                TriageDAO triageDAO = new TriageDAO();
                Triage triage = triageDAO.getDataByVisitID(visitId);
                
        %>
        
        Consult Record
        <table border="1">
            <tbody>
                <tr>
                    <td>Visit ID</td>
                    <td><%=visitId%></td>
                </tr>
                <tr>
                    <td>Height</td>
                    <td><%out.print(triage.getHeight());%></td>
                </tr>
                <tr>
                    <td>Weight</td>
                    <td><%out.print(triage.getWeight());%></td>
                </tr>
                <tr>
                    <td>Systolic</td>
                    <td><%out.print(triage.getSystolic());%></td>
                </tr>
                <tr>
                    <td>Diastolic</td>
                    <td><%out.print(triage.getDiastolic());%></td>
                </tr>
                
            </tbody>
        </table>

        <form action="CreateConsultServlet" method="POST">
            <input type="hidden" name="visitId" value=<%=visitID%>/>
            <input type="text" name="doctor" value="" />
            <input type="text" name="notes" value="" />
            <input type="text" name="diagnosis" value="" />
            <input type="text" name="problems" value="" />
            <input type="submit" value="Create Consult Record" />
        </form>
        <%
            }
            ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
            if (errors != null) {
                for (String e : errors) {
                    out.print(e + "</br>");
                }
            }
            String successmsg = (String) request.getAttribute("successmsg");
            if(successmsg !=null){
                out.print(successmsg);
            }
        %>
    </body>
</html>
