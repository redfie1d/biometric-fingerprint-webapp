<%-- 
    Document   : new_patient
    Created on : 24 Nov, 2016, 2:26:14 PM
    Author     : tcw
--%>

<%@page import="java.io.IOException"%>
<%@page import="javax.xml.bind.DatatypeConverter"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Vitals"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dao.PatientDAO"%>
<%@page import="model.Patient"%>
<%@page import="model.Visit"%>
<%@page import="dao.VisitDAO"%>
<%@include file="header.jsp" %>
<%@ include file="protect.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="margin-left: 0 !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            View Patient's Information
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Your Page Content Here -->

        <%            String alertBarDisplayState = "none";
            String alertBarStatus = "warning";
            String alertMsg = "";

            if (session.getAttribute("searchError") != null) {
                alertMsg = session.getAttribute("searchError").toString();
                session.removeAttribute("searchError");
                alertBarDisplayState = "block";
                alertBarStatus = "warning";
            }

            if (session.getAttribute("successMsg") != null) {
                alertMsg = session.getAttribute("successMsg").toString();
                session.removeAttribute("successMsg");
                alertBarDisplayState = "block";
                alertBarStatus = "success";
            }
        %>

        <div class="row">
            <div id="alertPanel" class="col-md-12">
                <div class="callout alert alert-<%=alertBarStatus%> alert-dismissible" style="display:<%=alertBarDisplayState%>">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4 style="margin-bottom:0;"><%=alertMsg%> <a href="new_patient.jsp">Register for new Patient</a></h4>
                    <!--Success alert preview. This alert is dismissable.-->
                </div>
            </div>
        </div>

        <!--        <div class="row">
                    <div class="col-md-12">
                        <button class="btn btn-primary" id="Bt_Init" style="width:120px;height:30px;" onclick="Init()">Init</button>
                        <button class="btn btn-info" id="Bt_Enroll" onclick="Enroll()" style="width:150px;height:30px;">Enroll</button>
                        <button class="btn btn-primary" id="Bt_UnInit" style="width:120px;height:30px;" onclick="UnInit()">UnInit</button>
                    </div>
                </div>-->

        <br/>

        <div class="row">

            <div class="col-md-3">

                <div id="fg_box" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Search By Patient ID</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->

                    <form action="SearchPatientServlet" method="POST">
                        <div class="box-body">
                            <div class="form-group">
                                <!--<label for="patientID">Patient ID</label>-->
                                <input type="text" class="form-control" id="patientID" name="patientID" placeholder="Enter patient id"><br/>
                                <button class="btn btn-info" type="submit" style="width:100%">Search</button>
                            </div>
                        </div>


                    </form>

                    <!-- /.box-body -->
                </div>
                <!-- /.box -->




                <div id="fg_box" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Search By Fingerprint</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <!--    <div class="row text-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-info">Left</button>
                                            <button type="button" class="btn">Right</button>
                                        </div>-->

                        <div class="row text-center">
                            <div class="col-sm-12">
                                <!--<img id="fg1Image" class="img-responsive" src="dist/img/fingerprint.png" alt="Photo">-->
                            </div>
                        </div>

                        <br/>

                        <div class="row text-center">
                            <div class="col-sm-12">
                                <button class="btn btn-info" id="Bt_Identify_1" onclick="Identify_1();" style="width:100%;">Scan</button>
                                <p id="fg1_msg" style="display:none"></p>
                                <button class="btn btn-warning" id="registerBtn" onclick="window.location.href = 'new_patient.jsp'" style="width:100%; display:none;">Register</button>
                            </div>
                        </div>


                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>

            <%

                String patientDetailsDisplayState = "none";

                Object visitObject = session.getAttribute("visitRecord");
                Object patientObject = session.getAttribute("patientRecord");

                Visit visitRecord = visitObject == null ? null : (Visit) visitObject;
                Patient patientRecord = patientObject == null ? null : (Patient) patientObject;

                session.removeAttribute("visitRecord");
                session.removeAttribute("patientRecord");

                if (patientRecord != null) {
                    patientDetailsDisplayState = "block";
                    patientRecord = PatientDAO.getPatientByPatientID(patientRecord.getVillage(), patientRecord.getPatientId());
                    Visit[] visits = VisitDAO.getVisitByPatientID(patientRecord.getPatientId());
            %>



            <div class="col-md-9">
                <div class="box box-widget widget-user" style="display:<%=patientDetailsDisplayState%>">
                    <!-- Add the bg color to the header using any of the bg-* classes -->
                    <div class="widget-user-header bg-aqua text-center">
                        <span class="widget-user-username col-md-4">ID: <%=patientRecord.getVillage()%><%=patientRecord.getPatientId()%></span>
                        <span class="widget-user-username col-md-4">Name: <%=patientRecord.getName()%></span>
                        <span class="widget-user-username col-md-4">Date Of Birth: <%=patientRecord.getDateOfBirth()%></span>
                        <span class="widget-user-username col-md-4">Gender: <%=patientRecord.getGender()%></span>
                        <span class="widget-user-username col-md-4">0</span>
                        <span class="widget-user-username col-md-4">Contact No: <%=patientRecord.getContactNo()%></span>
                        <span class="box-tools pull-right">
                            <form action="update_patient.jsp" method="POST">
                                <input type="hidden" name="village" value=<%=patientRecord.getVillage()%> />
                                <input type="hidden" name="patientId" value=<%=patientRecord.getPatientId()%> />
                                <button type="submit" class="btn btn-warning btn-lg" title="Update Patient's Details">Update Patient's Details</button>
                            </form>
                        </span>
                    </div>

                    <div class="widget-user-image">
                        <%
                            //write image
                            String imgName = "";
                            
                            try {
                                imgName = "\\\\JM-ASUS-LAPTOP\\patient-images\\" + patientRecord.getPhotoImage();
                                BufferedImage bImage = ImageIO.read(new File(imgName));//give the path of an image
                                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                ImageIO.write(bImage, "jpg", baos);
                                baos.flush();
                                byte[] imageInByteArray = baos.toByteArray();
                                baos.close();
                                String b64 = DatatypeConverter.printBase64Binary(imageInByteArray);
                        %>
                        <img  class="img-circle" src="data:image/jpg;base64, <%=b64%>" alt="User Avatar" style="width:50%"/>         
                        <%
                            } catch (IOException e) {
                                System.out.println("Error: " + e);
                            }
                        %>

                        <!--<img class="img-circle" src="patient-images/<%=patientRecord.getPhotoImage()%>" alt="User Avatar" style="width:100px; margin-right:10px;">-->     
                    </div>

                    <div class="box-footer">

                        <div class="box-header with-border">
                            <h3 class="box-title">Visits</h3>

                            <div class="box-tools pull-right">
                                <form action="CreateVisitServlet" method="POST" id="createVisitForm">
                                    <input type="hidden" name="patientId" value=<%=patientRecord.getPatientId()%> />
                                    <button type="submit" class="btn btn-box-tool" data-toggle="tooltip" title="Add New Visit" data-widget="chat-pane-toggle" style="color: black; font-size: 1em;">
                                        <i class="fa fa-plus-circle"></i> Start New Visit
                                    </button>
                                </form>
                            </div>
                        </div>

                        <div class="box-body with-border">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th style="width: 10px">ID</th>
                                        <th>Date</th>
                                        <th>Height</th>
                                        <th>Weight</th>
                                        <th>Blood Pressure</th>
                                        <th>Temperature</th>
                                    </tr>

                                    <%
                                        ArrayList<Visit> visitsAL = new ArrayList<>(Arrays.asList(visits));

                                        Collections.sort(visitsAL, new Comparator<Visit>() {
                                            @Override
                                            public int compare(Visit o1, Visit o2) {
                                                return o2.getId()-o1.getId();
                                            }
                                        });

                                        for (int i = 0; i < visitsAL.size(); i++) {
                                            Visit visit = visitsAL.get(i);
                                            Vitals v = visit.getVitals();
                                    %>


                                    <tr <%=i == 0 ? "style='background:lightgreen'" : ""%>>
                                        <td><%=visit.getId()%></td>
                                        <td><%=visit.getDate()%></td>
                                        <td>
                                            <%=v == null ? "NA" : v.getHeight()%>
                                        </td>
                                        <td>
                                            <%=v == null ? "NA" : v.getWeight()%>
                                        </td>
                                        <td>
                                            <%=v == null ? "NA" : v.getSystolic()%>/<%=v == null ? "NA" : v.getDiastolic()%>
                                        </td>
                                        <td>
                                            <%=v == null ? "NA" : v.getTemperature()%>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>

                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>

                <!--                <div class="box box-info box-solid">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Past Records</h3>
                
                                        <div class="box-tools pull-right">
                                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                         /.box-tools 
                                    </div>
                                     /.box-header 
                                    <div class="box-body">
                                         Custom Tabs 
                                        <div class="nav-tabs-custom">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a href="#consult_tab" data-toggle="tab">Consultations</a></li>
                                                <li><a href="#referral_tab" data-toggle="tab">Referrals</a></li>
                                                <li><a href="#triage_tab" data-toggle="tab">Triages</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div class="tab-pane active" id="consult_tab">
                
                                                    <table class="table table-striped">
                                                        <tbody><tr>
                                                                <th style="width: 10px">#</th>
                                                                <th>Task</th>
                                                                <th>Progress</th>
                                                                <th style="width: 40px">Label</th>
                                                            </tr>
                                                            <tr>
                                                                <td>1.</td>
                                                                <td>Update software</td>
                                                                <td>
                                                                    <div class="progress progress-xs">
                                                                        <div class="progress-bar progress-bar-danger" style="width: 55%"></div>
                                                                    </div>
                                                                </td>
                                                                <td><span class="badge bg-red">55%</span></td>
                                                            </tr>
                                                            <tr>
                                                                <td>2.</td>
                                                                <td>Clean database</td>
                                                                <td>
                                                                    <div class="progress progress-xs">
                                                                        <div class="progress-bar progress-bar-yellow" style="width: 70%"></div>
                                                                    </div>
                                                                </td>
                                                                <td><span class="badge bg-yellow">70%</span></td>
                                                            </tr>
                                                            <tr>
                                                                <td>3.</td>
                                                                <td>Cron job running</td>
                                                                <td>
                                                                    <div class="progress progress-xs progress-striped active">
                                                                        <div class="progress-bar progress-bar-primary" style="width: 30%"></div>
                                                                    </div>
                                                                </td>
                                                                <td><span class="badge bg-light-blue">30%</span></td>
                                                            </tr>
                                                            <tr>
                                                                <td>4.</td>
                                                                <td>Fix and squish bugs</td>
                                                                <td>
                                                                    <div class="progress progress-xs progress-striped active">
                                                                        <div class="progress-bar progress-bar-success" style="width: 90%"></div>
                                                                    </div>
                                                                </td>
                                                                <td><span class="badge bg-green">90%</span></td>
                                                            </tr>
                                                        </tbody></table>
                
                                                    <div class="row text-center">
                <%                    /*ArrayList<Integer> allergies = (ArrayList<Integer>) request.getAttribute("allergies");
                    AllergyDAO allergyDAO = new AllergyDAO();
                    out.print("<ul>");
                    for (int aId : allergies) {

                        out.print("<li>" + allergyDAO.getAllergyNameByAllergyID(aId) + "</li>");

                    }
                    out.print("</ul>");*/
                %>
            </div>

        </div>

        <div class="tab-pane" id="referral_tab">

            <div class="row text-center">
                <% /*ArrayList<Integer> allergies = (ArrayList<Integer>) request.getAttribute("allergies");
                    AllergyDAO allergyDAO = new AllergyDAO();
                    out.print("<ul>");
                    for (int aId : allergies) {

                        out.print("<li>" + allergyDAO.getAllergyNameByAllergyID(aId) + "</li>");

                    }
                    out.print("</ul>");*/
                %>
            </div>

        </div>

        <div class="tab-pane" id="triage_tab">

            <div class="row text-center">
                <% /*ArrayList<Integer> allergies = (ArrayList<Integer>) request.getAttribute("allergies");
                    AllergyDAO allergyDAO = new AllergyDAO();
                    out.print("<ul>");
                    for (int aId : allergies) {

                        out.print("<li>" + allergyDAO.getAllergyNameByAllergyID(aId) + "</li>");

                    }
                    out.print("</ul>");*/
                %>
            </div>

        </div>
    </div>
     /.tab-content 
</div>
 nav-tabs-custom 

</div>

</div>-->



            </div>
            <!-- /.col (right) -->
            <%                }
            %>


        </div>
        <!-- /.row -->

        <div class="row">
            <div class="col-md-12">
                <!--<button class="btn btn-primary btn-lg" id="btn-create-record" onclick="createPatientRecord();">Create Record</button>-->
            </div>
        </div>

    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<style>
    .cameraPanelBtns{
        width:100%;
    }

    .nav-tabs-custom{
        margin-bottom: 0;
    }
</style>

<script src='js/array.generics.min.js'></script>
<script src='js/jquery.min.js'></script>
<script src="js/webcam.js"></script>
<script src='js/existing_patient.js'></script>

<%@include file="footer.jsp" %>
