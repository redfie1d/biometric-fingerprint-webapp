<%-- 
    Document   : patient_records
    Created on : Nov 24, 2016, 6:44:27 PM
    Author     : yu.fu.2015
--%>

<%@page import="dao.VisitDAO"%>
<%@page import="model.Visit"%>
<%@page import="dao.AllergyDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Records</title>
    </head>
    <body>
        <h1>Patient Records</h1>
        <table border="1">

            <tbody>
                <tr>
                    <td>Patient ID</td>
                    <td><%=request.getAttribute("patientId")%></td>
                </tr>
                <tr>
                    <td>Name</td>
                    <td><%=request.getAttribute("name")%></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td><%=request.getAttribute("gender")%></td>
                </tr>
                <tr>
                    <td>Birth Year</td>
                    <td><%=request.getAttribute("birthYear")%></td>
                </tr>
                <tr>
                    <td>Village</td>
                    <td><%=request.getAttribute("village")%></td>
                </tr>
                <tr>
                    <td>Parent ID</td>
                    <td><%=request.getAttribute("parentId")%></td>
                </tr>
                <tr>
                    <td>Allergies</td>
                    <td>
                        <%
                            /*ArrayList<Integer> allergies = (ArrayList<Integer>) request.getAttribute("allergies");
                            AllergyDAO allergyDAO = new AllergyDAO();
                            out.print("<ul>");
                            for (int aId : allergies) {

                                out.print("<li>" + allergyDAO.getAllergyNameByAllergyID(aId) + "</li>");

                            }
                            out.print("</ul>");*/
                        %>
                    </td>
                </tr>
                <tr>
                    <td>Visits</td>
                    <td>
                        <%
                            /*ArrayList<Visit> visits = (ArrayList<Visit>) request.getAttribute("visits");
                            VisitDAO visitDAO = new VisitDAO();
                            out.print("<ul>");
                            for (Visit v : visits) {

                                out.print("<li>" + v.getDate() + "</li>");

                            }
                            out.print("</ul>");*/
                        %>
                    </td>
                </tr>

            </tbody>
        </table>

    </body>
</html>
