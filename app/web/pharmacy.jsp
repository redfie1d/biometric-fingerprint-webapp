<%-- 
    Document   : pharmacy
    Created on : 22 Nov, 2017, 3:21:52 PM
    Author     : Kwtam
--%>
<%@include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    Object requestObject = session.getAttribute("requestedMedicine");
    session.removeAttribute("requestedMedicine");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="col-md-5">
            <div id="fg_box" class="box box-info box-solid">
                <div class="box-header with-border">
                    <h3 class="box-title">Requested Medicine</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                    </div>
                    <!-- /.box-tools -->
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                   <div class="content-wrapper" style="margin-left: 0 !important;">
                    <form action="OrderServlet" method="POST" id="newOrder">
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th>Doctor Name</th>
                                    <th>Medicine</th>
                                    <th>Quantity</th>
                                    <th>Action</th>
                                </tr>

                                <tr style="background:lightgreen">
                                    <td>Dr Pris</td>
                                    <td>Penicillin</td>
                                    <td>
                                        0.0
                                    </td>
                                    <td>
                                        <button class="btn btn-info" type="submit">Approve</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>

                </div>

                    <br>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
    </body>
</html>
