<%-- 
    Document   : pharmacy
    Created on : 22 Nov, 2017, 3:21:52 PM
    Author     : Kwtam
--%>
<%@page import="model.Drug"%>
<%@page import="dao.InventoryDAO"%>
<%@page import="java.util.HashMap"%>
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
        <div class="col-md-8" style="left">
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
                                    <th>Order ID</th>
                                    <th>Doctor</th>
                                    <th>Patient ID</th>
                                    <th>Medicine</th>
                                    <th>Quantity</th>
                                    <th>Notes</th>
                                    <th>Remarks</th>
                                </tr>
                                <%
                                    OrderDAO orderDAO = new OrderDAO();
                                    ArrayList<Order> orderList = orderDAO.getOrders();
                                    
                                    HashMap<Integer, ArrayList<Order>> map = new HashMap<>();
                                    for(Order order:orderList){
                                        int orderID = order.getOrderID();
                                        ArrayList<Order> currentOrderList = map.get(orderID);
                                        if(currentOrderList==null){
                                            ArrayList<Order> temp = new ArrayList<Order>();
                                            temp.add(order);
                                            map.put(orderID, temp);
                                        } else{
                                            currentOrderList.add(order);
                                            map.put(orderID, currentOrderList);
                                        }
                                    }
                                    
                                    for (Integer key : map.keySet())
                                    {
                                        ArrayList<Order> orderIDList = map.get(key);
                                        Order firstOrder = orderIDList.get(0);
                                %>
                                        <tr>
                                            <td><%=firstOrder.getOrderID()%></td>
                                            <td><%=firstOrder.getDoctor()%></td>
                                            <td><%=firstOrder.getPatientID()%></td>
                                            <td><%=firstOrder.getMedicine()%></td>
                                            <td><%=firstOrder.getQuantity()%></td>
                                            <td><%=firstOrder.getNotes()%></td>
                                            <td><%=firstOrder.getRemarks()%></td>
                                        </tr>
                                <%
                                        for(int i=1; i<orderIDList.size(); i++){
                                            Order currentOrder = orderIDList.get(i);
                                %>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td><%=currentOrder.getMedicine()%></td>
                                                <td><%=currentOrder.getQuantity()%></td>
                                                <td><%=currentOrder.getNotes()%></td>
                                                <td><%=currentOrder.getRemarks()%></td>
                                            </tr>
                                <%
                                        }
                                %>

                                        <td>
                                            <form action="ApproveOrderServlet" method="POST">
                                                <input type="hidden" name="orderID" value=<%=firstOrder.getOrderID()%>>
                                                <button class="btn btn-info" type="submit">Approve</button>
                                            </form>
                                        </td>
<!--                                        <td>
                                            <form action="ApproveOrderServlet" method="POST">
                                                <button class="btn btn-info" type="button" onClick="">Edit Quantity</button>
                                            </form>
                                        </td>-->
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
        <div class="col-md-4" style="float:right">
            <div id="fg_box" class="box box-info box-solid" style="margin-bottom:0px">
                <div class="box-header with-border">
                    <h3 class="box-title">Inventory Stock</h3>

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
                                    <th>Drug</th>
                                    <th>Quantity</th>
                                </tr>
                                <%
                                    InventoryDAO inventoryDAO = new InventoryDAO();
                                    ArrayList<Drug> drugList = inventoryDAO.getInventory();
                                    for(Drug drug:drugList){
                                %>
                                        <tr>
                                            <td><%=drug.getMedicine_name()%></td>
                                            <td><%=drug.getQuantity()%></td>
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
        <div style="clear:both"></div>
</div>