<%-- 
    Document   : pharmacy
    Created on : 22 Nov, 2017, 3:21:52 PM
    Author     : Kwtam
--%>
<%@page import="model.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.OrderDAO"%>
<%@include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    Object requestObject = session.getAttribute("requestedMedicine");
    session.removeAttribute("requestedMedicine");
    
    String msgDisplayState = "none";
            String msgState = "success";
            String msg = "";
            if (session.getAttribute("successmsg") != null) {
                msg = session.getAttribute("successmsg").toString();
                session.removeAttribute("successmsg");
                msgDisplayState = "block";
                msgState = "success";
            }
    
    String errmsg = "";
            if (session.getAttribute("errormsg") != null) {
                errmsg = session.getAttribute("errormsg").toString();
                session.removeAttribute("errormsg");
                msgDisplayState = "block";
                msgState = "danger";
            }
        %>
        
<!DOCTYPE html>
<div class="content-wrapper" style="margin-left: 0 !important;">
        <div class="row">
            <div id="alertPanel" class="col-md-12">
                <div class="callout alert alert-<%=msgState%> alert-dismissible" style="display:<%=msgDisplayState%>">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4 style="margin-bottom:0;">

                        <%
                            if (msg.length() > 0) {
                                out.println(msg);
                            }

                            if (errmsg.length() > 0) {
                                out.println(errmsg);
                            }
                        %>

                        <!--<i class="icon fa fa-check"></i> Alert!-->

                    </h4>
                    <!--Success alert preview. This alert is dismissable.-->
                </div>
            </div>

        </div>
        <div class="col-md-5" style="float:none">
            <div id="fg_box" class="box box-info box-solid" style="margin-bottom:0px">
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
                        <table class="table">
                            <tbody>
                                <tr>
                                    <th>Doctor Name</th>
                                    <th>Medicine</th>
                                    <th>Quantity</th>
                                    <th>Action</th>
                                </tr>
                                <%
                                    OrderDAO orderDAO = new OrderDAO();
                                    ArrayList<Order> orderList = orderDAO.getOrders();
                                    for(Order order: orderList){

                                %>
                                <tr>
                                    <td><%=order.getDoctor()%></td>
                                    <td><%=order.getMedicine()%></td>
                                    <td>
                                        <%=order.getQuantity()%>
                                    </td>
                                    <td>
                                        <form action="OrderServlet" method="POST" id="newOrder">
                                            <input type="hidden" name="orderID" value="<%=order.getOrderID()%>">
                                            <input type="hidden" name="doctor" value="<%=order.getDoctor()%>">
                                            <input type="hidden" name="medicine" value="<%=order.getMedicine()%>">
                                            <input type="hidden" name="quantity" value="<%=order.getQuantity()%>">
                                            <button class="btn btn-info" type="submit">Approve</button>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                

                    <br>
                </div>
                <!-- /.box-body -->
            </div>
        </div>
</div>