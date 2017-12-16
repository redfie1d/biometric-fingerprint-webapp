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
<%@page import="dao.VisitDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Visit"%>
<%@page import="model.Patient"%>
<%@include file="header.jsp" %>
<%@include file="protect.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="margin-left: 0 !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>New Vitals</h1>
    </section>

    <!-- Main content -->
    <section class="content" style="padding-top:0;">
        <!-- Your Page Content Here -->
        <%

            String msgDisplayState = "none";
            String msgDisplayStatus = "success";

            ArrayList<String> errorList = new ArrayList<>();
            if (session.getAttribute("errorMsg") != null) {
                errorList = (ArrayList<String>) session.getAttribute("errorMsg");
                msgDisplayState = "block";
                msgDisplayStatus = "danger";

            }

            String msgDisplay = "";
            if (session.getAttribute("visitError") != null) {
                msgDisplay = session.getAttribute("visitError").toString();
                msgDisplayState = "block";
                msgDisplayStatus = "danger";
                session.removeAttribute("visitError");
                session.removeAttribute("visitRecord");
                session.removeAttribute("patientRecord");
            }

            if (session.getAttribute("msg") != null) {
                msgDisplay = session.getAttribute("msg").toString();
                msgDisplayState = "block";
                msgDisplayStatus = "success";
                session.removeAttribute("msg");
            }
        %>

        <div class="row">
            <div id="alertPanel" class="col-md-12">
                <div class="callout alert alert-<%=msgDisplayStatus%> alert-dismissible" style="display:<%=msgDisplayState%>">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4 style="margin-bottom:0;">
                        <%
                        if (errorList != null && msgDisplay.equals("")) {
                            for (String s : errorList) {
                                out.println(s + "<br/>");

                                session.removeAttribute("errorMsg");
                            }
                        } else {
                            out.print(msgDisplay);
                        }
                        %>
                    </h4>
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

        <%
            String displayState = "block";
//            if (doctorName == null || doctorName.length() <= 0) {
//                displayState = "none";
//            }

            Object visitObject = session.getAttribute("visitRecord");
            Object patientObject = session.getAttribute("patientRecord");
            
            Visit visitRecord = visitObject == null ? null : (Visit) visitObject;
            
            if (visitRecord != null){
                visitRecord = VisitDAO.getPatientLatestVisit(visitRecord.getPatientId());
            }
            
            Patient patientRecord = patientObject == null ? null : (Patient) patientObject;

            displayState = visitRecord != null && patientRecord != null ? "block" : "none";

//            if (visitRecord != null) {
//                out.println(visitRecord.getDate());
//            }
//
//            if (patientRecord != null) {
//                out.println(patientRecord.getName());
//            }
%>
        <div class="row">

            <div class="col-md-4">

                <div id="patientRecordsBox" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Patient's Record</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="box box-widget widget-user-2">
                            <!-- Add the bg color to the header using any of the bg-* classes -->
                            <form action="SearchPatientLatestVisitServlet" method="POST">
                                <input type="hidden" name="source" value="triage">
                                <div class="input-group">
                                    <input type="text" name="patientID" placeholder="Enter Patient ID" class="form-control">
                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-info btn-flat">Search</button>
                                    </span>
                                </div>
                            </form>

                            <br/>

                            <div style="display:<%=displayState%>">
                                <%
                                    if (patientRecord != null) {
                                %>
                                <div class="widget-user-header bg-aqua">
                                    <div class="widget-user-image">
                                        
                                        <%
                                            //write image
                                            String imgName = "";

                                            try {
                                                imgName = "\\\\JM-ASUS-LAPTOP\\patient-images\\" + patientRecord.getPhotoImage();
                                                BufferedImage bImage = ImageIO.read(new File(imgName));//give the path of an image
                                                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                                ImageIO.write(bImage, "png", baos);
                                                baos.flush();
                                                byte[] imageInByteArray = baos.toByteArray();
                                                baos.close();
                                                String b64 = DatatypeConverter.printBase64Binary(imageInByteArray);
                                        %>
                                        <img class="img-responsive" src="data:image/png;base64, <%=b64%>" alt="User Avatar" style="width:100px"/>                      
                                        <%
                                            } catch (IOException e) {
                                                System.out.println("Error: " + e);
                                            }
                                        %>
                                        
                                        <!--<img class="img" src="patient-images/<%=patientRecord.getPhotoImage()%>" alt="User Avatar" style="width:100px; margin-right:10px;">-->
                                    </div>
                                    <!-- /.widget-user-image -->
                                    <h3 class="widget-user-username">Name: <%=patientRecord.getName()%></h3>
                                    <h3 class="widget-user-desc">Patient ID: <%=patientRecord.getVillage() + patientRecord.getPatientId()%></h3>
                                </div>
                                <div class="box-footer no-padding">
                                    <div class="row" style="padding:15px;">
                                        <div class="col-md-3">
                                            <b>Village:</b>
                                        </div>
                                        <div class="col-md-9">
                                            <%=patientRecord.getVillage()%>
                                        </div>
                                    </div>

                                    <hr style="margin: 0 auto 0 auto"/>

                                    <div class="row" style="padding:15px;">
                                        <div class="col-md-3">
                                            <b>Gender:</b>
                                        </div>
                                        <div class="col-md-9">
                                            <%=patientRecord.getGender()%>
                                        </div>
                                    </div>

                                    <div class="row" style="padding:15px;">
                                        <div class="col-md-3">
                                            <b>Age:</b>
                                        </div>
                                        <div class="col-md-9">
                                            <%
                                                String dateOfBirth = patientRecord.getDateOfBirth();
                                                int yearOfBirth = Integer.parseInt(dateOfBirth.substring(0,4));
                                                int age = 2017 - yearOfBirth;
                                                out.println(age);
                                            %>
                                        </div>
                                    </div>

                                    <div class="row" style="padding:15px;">
                                        <div class="col-md-3">
                                            <b>Allergies:</b>
                                        </div>
                                        <div class="col-md-9">
                                            <%
                                                String output = "No allergies";
                                                String[] allergyList = null;
                                                if (patientRecord.getAllergies() != null) {
                                                    allergyList = patientRecord.getAllergies().split(",");
                                                    output = "";
                                                    for (String s : allergyList) {
                                                        output += s + "<br/>";
                                                    }
                                                }
                                            %>

                                            <%=output%>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">

                <div id="patientRecordsBox" class="box box-info box-solid" style="display: <%=displayState%>">
                    <div class="box-header with-border">
                        <h3 class="box-title">New Vitals Information</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <form action="CreateVitalsServlet" method="POST">
                            
                            <input type="hidden" name="update" value="<%=visitRecord != null && visitRecord.getVitals() != null ? 1 : 0 %>">
                            <input type="hidden" name="visitId" value="<%=visitRecord != null ? visitRecord.getId() : ""%>">

                            <div class="col-md-10 border-right">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="name">Height (cm)</label>
                                        <input type="number" step=0.1 class="form-control" id="name" name="height" value="<%=visitRecord != null && visitRecord.getVitals() != null ? visitRecord.getVitals().getHeight(): ""%>">
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="name">Weight (kg)</label>
                                        <input type="number" step=0.1 class="form-control" id="name" name="weight" value="<%=visitRecord != null && visitRecord.getVitals() != null ? visitRecord.getVitals().getWeight(): ""%>">
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="name">Blood Pressure</label><br/>
                                        <input type="number" class="form-control" id="name" name="systolic" value="<%=visitRecord != null && visitRecord.getVitals() != null ? (int)visitRecord.getVitals().getSystolic() : "0"%>" style="width: 44%; display:inline">&nbsp;/&nbsp;
                                        <input type="number" class="form-control" id="name" name="diastolic" value="<%=visitRecord != null && visitRecord.getVitals() != null ? (int)visitRecord.getVitals().getDiastolic() : "0"%>" style="width: 44%; display:inline">
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="name">Temperature (Celsius)</label>
                                        <input type="number" step=0.1 class="form-control" id="name" name="temperature" value="<%=visitRecord != null && visitRecord.getVitals() != null ? visitRecord.getVitals().getTemperature() : ""%>">
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-2">
                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="hivPositive" <%=visitRecord != null && visitRecord.getVitals() != null && visitRecord.getVitals().getHivPositive() != 0 ? "checked" : ""%>/>HIV
                                        </label>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="ptbPositive" <%=visitRecord != null && visitRecord.getVitals() != null && visitRecord.getVitals().getPtbPositive() != 0 ? "checked" : ""%>/>PTB
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button class="btn btn-info" id="btn-create-record"><%=visitRecord != null && visitRecord.getVitals() != null ? "Update Vitals Record" : "Create Vitals Record"%></button>
                            </div> 
                        </form>

                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

        </div>
        <!-- /.row -->

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

    input[type=number]::-webkit-inner-spin-button, 
    input[type=number]::-webkit-outer-spin-button { 
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0; 
    }
</style>

<script src='js/array.generics.min.js'></script>
<script src='js/jquery.min.js'></script>
<script src="js/webcam.js"></script>
<script src='js/new_patient.js'></script>

<%@include file="footer.jsp" %>
