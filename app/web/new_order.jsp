<%-- 
    Document   : new_order
    Created on : 13 Dec, 2017, 3:05:36 AM
    Author     : JunMing
--%>

<%@page import="dao.UserDAO"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="model.Drug"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.InventoryDAO"%>
<%@include file="header.jsp" %>

<form action="AdditionalOrderServlet" method="post">
    <div class="box box-info box-solid">
        <div class="box-header with-border">
            <h3 class="box-title">Issue Medicine</h3>
            <!-- /.box-tools -->
        </div>

        <div>
            Village:
            <select>
                <option name="villageName" value="PCV">PCV</option>
                <option name="villageName" value="KSV">KSV</option>
            </select>

        </div>

        <div>
            Patient Number:
            <input type="text" name="patientNumber" placeholder="numbers only">
        </div>

        </br>

        <div>
            Doctor: 
            <%
                UserDAO userDao = new UserDAO();
                ArrayList<String> doctorList = UserDAO.retrieveAllDoctors();

                Collections.sort(doctorList, new Comparator<String>() {
                    @Override
                    public int compare(String doctor1, String doctor2) {
                        return doctor1.compareTo(doctor2);
                    }
                });
            %>
            <select>
                <%
                    for (int i = 0; i < doctorList.size(); i++) {
                %>
                <option name="doctorName" value= <%=doctorList.get(i)%>><%=doctorList.get(i)%></option> 
                <%
                    }
                %>
            </select>

        </div>

        <!-- /.box-header -->
        <div class="box-body">
            <table class="table" id="issueMedicine">
                <tbody>
                    <tr>
                        <th>Medicine</th>
                        <th>Quantity</th>
                        <th>Regimen</th>
                        <th>Remarks</th>
                    </tr>

                    <tr>
                        <td>
                            <%
                                String optionValues = "";
                                InventoryDAO inventoryDAO = new InventoryDAO();

                                ArrayList<Drug> drugList = inventoryDAO.getInventory();

                                Collections.sort(drugList, new Comparator<Drug>() {
                                    @Override
                                    public int compare(Drug drug1, Drug drug2) {
                                        return Integer.parseInt(drug1.getMedicine_name().split("\\.")[0]) - Integer.parseInt(drug2.getMedicine_name().split("\\.")[0]);
                                    }
                                });
                            %>
                            <select name="medicine" class="form-control">
                                <%
                                    for (int i = 0; i < drugList.size(); i++) {
                                %>
                                <option value= "<%=drugList.get(i).getMedicine_name()%>"> <%=drugList.get(i).getMedicine_name()%> (<%=drugList.get(i).getQuantity()%>)</option> 
                                <%
                                    }
                                %>
                            </select>
                        </td>
                        <td>
                            <input name="quantity" placeholder="Quantity" class="form-control" type="number" required/>
                        </td>
                        <td>
                            <input name="regimen" placeholder="Regimen" class="form-control" type="text">
                        </td>
                        <td>
                            <input name="remarks" placeholder="Remarks" class="form-control" type="text">
                        </td>
                    </tr>
                </tbody>

            </table>
            <hr>
            <div style="float:left">
                <span class="input-group-btn" style="width:0;padding-right:10px">
                    <button type="submit" class="btn btn-info btn-flat">Place Order</button>
                </span>
            </div>
        </div>
    </div>
</form>
<%@include file="footer.jsp" %>