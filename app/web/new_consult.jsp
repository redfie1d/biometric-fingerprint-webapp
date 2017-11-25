<%-- 
    Document   : new_patient
    Created on : 24 Nov, 2016, 2:26:14 PM
    Author     : tcw
--%>

<%@page import="model.Drug"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.InventoryDAO"%>
<%@page import="dao.ConsultDAO"%>
<%@page import="model.Consult"%>
<%@page import="dao.VisitDAO"%>
<%@page import="dao.PatientDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="model.Triage"%>
<%@page import="model.Patient"%>
<%@page import="model.Visit"%>
<%@include file="header.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="margin-left: 0 !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>Doctor's Consultation
            <form action="SetDoctorNameServlet" method="POST">         
                <div class="input-group col-md-12 row">
                    <%
                        String doctorName = session.getAttribute("docName") == null ? "" : session.getAttribute("docName").toString();
                    %>

                    <div class="col-md-8">
                        <input type="text" id="docName" placeholder="Enter your name here" name="docName" class="form-control" style="width:80%" value="<%=doctorName%>">
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-info btn-flat">Set</button>
                        </span>
                    </div>

                </div>
            </form>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content" style="padding-top:0;">
        <!-- Your Page Content Here -->
        <%
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
            if (session.getAttribute("visitError") != null) {
                errmsg = session.getAttribute("visitError").toString();
                session.removeAttribute("visitError");
                msgDisplayState = "block";
                msgState = "danger";
                session.removeAttribute("visitRecord");
                session.removeAttribute("patientRecord");
            }
        %>
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
            if (doctorName == null || doctorName.length() <= 0) {
                displayState = "none";
            }

            Object visitObject = session.getAttribute("visitRecord");
            Object patientObject = session.getAttribute("patientRecord");

            Visit visitRecord = visitObject == null ? null : (Visit) visitObject;
//            DateFormat df = new SimpleDateFormat("dd/mm/yyyy");
//            visitRecord = df.format(new Date()).equals(visitRecord.getDate()) ? visitRecord : null;

            Patient patientRecord = patientObject == null ? null : (Patient) patientObject;
            Triage triageObject = visitRecord == null ? null : visitRecord.getTriage();

            String patientDetailsDisplayState = visitRecord != null && patientRecord != null ? "block" : "none";
            String consultActionPage = visitRecord != null && patientRecord != null && visitRecord.getConsult() != null ? "UpdateConsultServlet" : "CreateConsultServlet";

            Visit[] pastVisits = null;

            if (visitRecord != null) {
                //visitRecord = VisitDAO.getPatientLatestVisit(visitRecord.getPatientId());
                triageObject = visitRecord.getTriage();
                pastVisits = VisitDAO.getVisitByPatientID(visitRecord.getPatientId());
            }

            session.removeAttribute("visitRecord");
            session.removeAttribute("patientRecord");
            session.removeAttribute("pastVisits");
        %>

        <div class="row" style="display:<%=displayState%>">

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
                                <input type="hidden" name="source" value="consult">
                                <div class="input-group">
                                    <input type="text" name="patientID" placeholder="Enter Patient ID" class="form-control">
                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-info btn-flat">Search</button>
                                    </span>
                                </div>
                            </form>

                            <br/>

                            <div style="display:<%=patientDetailsDisplayState%>">
                                <%
                                    if (patientRecord != null) {
                                        patientRecord = PatientDAO.getPatientByPatientID(patientRecord.getVillage(), patientRecord.getPatientId());
                                %>
                                <div class="widget-user-header bg-aqua">
                                    <div class="widget-user-image">
                                        <img class="img" src="patient-images/<%=patientRecord.getPhotoImage()%>" alt="User Avatar" style="width:100px; margin-right:10px;">
                                    </div>
                                    <!-- /.widget-user-image -->
                                    <h3 class="widget-user-username">Name: <%=patientRecord.getName()%></h3>
                                    <h3 class="widget-user-desc">Patient ID: <%=patientRecord.getVillage()%><%=patientRecord.getPatientId()%></h3>
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

                                    <!--<hr style="margin: 0 auto 0 auto"/>-->

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
                                            <%=patientRecord.getBirthYear()%>
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

                                    <%
                                        if (triageObject != null) {
                                    %>

                                    <div class="box-footer no-padding">
                                        <div class="row" style="padding-left:15px;">
                                            <div class="col-md-12">
                                                <h3><b>Current Triage Record</b></h3>
                                            </div>
                                        </div>

                                        <div class="row" style="padding:15px;">
                                            <div class="col-md-3">
                                                <b>Height:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=triageObject.getHeight()%>
                                            </div>

                                            <div class="col-md-3">
                                                <b>Weight:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=triageObject.getWeight()%>
                                            </div>
                                        </div>
                                        <div class="row" style="padding:15px;">
                                            <div class="col-md-3">
                                                <b>BP:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=triageObject.getSystolic()%>/<%=triageObject.getDiastolic()%>
                                            </div>

                                            <div class="col-md-3">
                                                <b>Temp:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=triageObject.getTemperature()%>
                                            </div>
                                        </div>

                                        <div class="row" style="padding:15px;">
                                            <div class="col-md-2">
                                                <b>HIV Positive:</b>
                                            </div>
                                            <div class="col-md-2">
                                                <%
                                                    if (triageObject.getHivPositive() == 1) {
                                                %>
                                                Yes
                                                <%
                                                } else {
                                                %>
                                                No
                                                <%
                                                    }
                                                %>
                                            </div>

                                            <div class="col-md-2">
                                                <b>PTB Positive:</b>
                                            </div>
                                            <div class="col-md-2">
                                                <%
                                                    if (triageObject.getPtbPositive() == 1) {
                                                %>
                                                Yes
                                                <%
                                                } else {
                                                %>
                                                No
                                                <%
                                                    }
                                                %>
                                            </div>

                                            <div class="col-md-2">
                                                <b>Hepatitis C Positive:</b>
                                            </div>
                                            <div class="col-md-2">
                                                <%
                                                    if (triageObject.getHepCPositive() == 1) {
                                                %>
                                                Yes
                                                <%
                                                } else {
                                                %>
                                                No
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="patientRecordsBox" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Patient's Visits</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>

                    <div style="font-family: Verdana" class="box-body">
                        <%
                            if (pastVisits != null) {
                        %>
                        <div class="col-md-4">#</div>
                        <div class="col-md-4" >Date & Time</div>
                        <div class="col-md-4">Doctor</div>
                        <div class="col-md-4">Action</div>

                        <%
                            int count = 1;
                            for (Visit v : pastVisits) {
                                Date d = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy").parse(v.getDate());
                                String date = new SimpleDateFormat("dd/MM/yyyy  HH:mm").format(d);
                                int visitID = v.getId();
                                ConsultDAO consultDAO = new ConsultDAO();
                                Consult consult = consultDAO.getConsultByVisitID(visitID);
                                if (consult != null) {
                                    String doctor = consult.getDoctor();
                        %>
                        <div class="col-md-4"><%=count++%></a></div>
                        <div class="col-md-4"><%=date%></div>
                        <div class="col-md-4"><%=doctor%></div>
                        <div class="col-md-4">
                            <form action="SearchPatientByVisitIDServlet" method="POST">
                                <input type="hidden" name="source" value="consult">
                                <input type="hidden" name="patientID" value=<%=patientRecord.getVillage()%><%=patientRecord.getPatientId()%>>
                                <input type="hidden" name="visitID" value=<%=v.getId()%>>
                                <div class="input-group">
                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-info btn-flat">View</button>
                                    </span>
                                </div>
                            </form>
                        </div>
                        <%
                                    }
                                }
                            }
                        %>
                    </div>
                </div>

            </div>

            <div class="col-md-8">

                <div id="patientRecordsBox" class="box box-info box-solid" style="display:<%=visitRecord != null ? "block" : "none"%>">
                    <div class="box-header with-border">
                        <h3 class="box-title">Doctor's Consultation</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <form action="<%=consultActionPage%>" method="POST" class="row">

                            <input type="hidden" name="visitId" value="<%=visitRecord != null ? visitRecord.getId() : ""%>">
                            <input type="hidden" name="doctor" value="<%=doctorName != null && doctorName.length() > 0 ? doctorName : ""%>">

                            <div class="col-md-9">
                                <div class="form-group">
                                    <label>Consult Details</label>
                                    <%
                                        if (visitRecord != null && visitRecord.getConsult() != null) {
                                    %>
                                    <textarea class="form-control" name="notes" rows="3" style="height:200px"><%=visitRecord.getConsult().getNotes()%></textarea>

                                    <%
                                    } else {
                                    %>
                                    <textarea class="form-control" name="notes" rows="3" placeholder="Enter here..." style="height:200px"></textarea>

                                    <%
                                        }
                                    %>
                                </div>

                                <div class="form-group">
                                    <label>Diagnosis</label>
                                    <%
                                        if (visitRecord != null && visitRecord.getConsult() != null) {
                                    %>
                                    <textarea class="form-control" name="diagnosis" rows="3" style="height:80px"><%=visitRecord.getConsult().getDiagnosis()%></textarea>

                                    <%
                                    } else {
                                    %>
                                    <textarea class="form-control" name="diagnosis" rows="3" placeholder="Enter here..." style="height:200px"></textarea>

                                    <%
                                        }
                                    %>                                
                                </div>

                                <div class ="col-md-9">
                                    <div class="form-group">
                                        <label>STAT Investigations</label>
                                    </div>
                                </div>

                                <div class ="col-md-6">
                                    <div class="form-group">
                                        <label>Urine Dip Test</label>
                                        <%
                                            if (visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="urine" rows="3" style="height:100px"><%=visitRecord.getConsult().getUrine_test()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="urine" rows="3" placeholder="Leave blank if NA..." style="height:200px"></textarea>

                                        <%
                                            }
                                        %>                                    
                                    </div>

                                    <div class="form-group">
                                        <label>Hemocue Hb Test</label>
                                        <%
                                            if (visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="hemocue" rows="3" style="height:100px"><%=visitRecord.getConsult().getHemocue_count()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="hemocue" rows="3" placeholder="Leave blank if NA..." style="height:200px"></textarea>

                                        <%
                                            }
                                        %>      
                                    </div>

                                </div>  
                                <div class ="col-md-6">
                                    <div class="form-group">
                                        <label>Capillary Blood Glucose Test</label>
                                        <%
                                            if (visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="blood" rows="3" style="height:100px"><%=visitRecord.getConsult().getBlood_glucose()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="blood" rows="3" placeholder="Leave blank if NA..." style="height:200px"></textarea>

                                        <%
                                            }
                                        %>      
                                    </div>

                                    <div class="form-group">
                                        <label>Referral: Investigations/External Care</label>
                                        <%
                                            if (visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="referrals" rows="3" style="height:100px"><%=visitRecord.getConsult().getReferrals()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="referrals" rows="3" placeholder="Leave blank if NA..." style="height:200px"></textarea>

                                        <%
                                            }
                                        %>      
                                    </div>
                                </div>  
                            </div>

                            <div class="col-md-3">
                                <h4>Summary of Problems</h4>
                                <div class="form-group summaryProblemGroup">
                                    <%
                                        String[] problems = new String[]{"Cardiovascular", "Dental", "Dermatology", "Endocrine", "ENT", "Eye",
                                            "Gastrointestinal", "Gynaecology", "Hematology", "Infectious Diseases", "Musculo-skeletal", "Neurology",
                                            "Oncology", "Psychology", "Renal", "Respiratory", "Urology", "Surgery"};

                                        for (String s : problems) {

                                            String checked = "";

                                            if (visitRecord != null && visitRecord.getConsult() != null && visitRecord.getConsult().getProblems() != null) {

                                                for (String p : visitRecord.getConsult().getProblems().split(",")) {
                                                    //out.println(p);
                                                    if (p.equals(s)) {
                                                        checked = "checked";
                                                        break;
                                                    }
                                                }
                                            }

                                            out.println("<div class=\"checkbox\">");
                                            out.println("<label>");
                                            out.println("<input type=\"checkbox\" name=\"problems\" class='problemsCB' value='" + s + "' " + checked + ">");
                                            out.println(s);
                                            out.println("</label>");
                                            out.println("</div>");
                                        }

                                    %>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <%                                    if (visitRecord != null && visitRecord.getConsult() != null) {
                                %>
                                <button class="btn btn-primary btn-lg" id="btn-create-record" type="submit">Update Consult Record</button>
                                <%
                                } else {
                                %>
                                <button class="btn btn-primary btn-lg" id="btn-create-record" type="submit">Create Consult Record</button>
                                <%
                                    }
                                %>
                            </div> 
                        </form>
                    </div>

                </div>
                            
                <div class="box box-info box-solid" style="display:<%=visitRecord != null ? "block" : "none"%>">
                    <div class="box-header with-border">
                        <h3 class="box-title">Issue Medicine</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <form action="OrderServlet" method="POST">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th>Doctor</th>
                                        <th>Medicine</th>
                                        <th>Quantity</th>
                                        <th>Status</th>
                                    </tr>

                                    <tr>
                                        <td>
                                            <input name="doctor" placeholder="Reviewing Doctor" class="form-control" type="text">
                                        </td>
                                        <td>
                                            <select name="medicine" class="form-control">
                                            <%
                                                InventoryDAO inventoryDAO = new InventoryDAO();
                                                ArrayList<Drug> drugList = inventoryDAO.getInventory();                              
                                                for(Drug drug:drugList){
                                            %>
                                                <option value="<%=drug.getMedicine_name()%>" type="text"><%=drug.getMedicine_name()%></option>
                                            <%
                                                }
                                            %>
                                            </select>
                                        </td>
                                        <td>
                                            <input name="quantity" placeholder="Quantity" class="form-control" type="number">
                                        </td>
                                        <td>
                                            <span class="input-group-btn">
                                                <button type="submit" class="btn btn-info btn-flat">Place Order</button>
                                            </span>
                                        </td>
                                    </tr>
                                    

                                </tbody>
                            </table>
                        </form>
                    </div>
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
</style>

<script src='js/array.generics.min.js'></script>
<script src='js/jquery.min.js'></script>
<script src="js/webcam.js"></script>
<script src='js/new_patient.js'></script>

<script>
//            .summaryProblemGroup
    $(document).ready(function () {
        var problems = ["Cardiovascular", "Dental", "Dermatology", "Endocrine", "ENT", "Eye",
            "Gastrointestinal", "Gynaecology", "Hematology", "Infectious Diseases", "Musculo-skeletal", "Neurology",
            "Oncology", "Psychology", "Renal", "Respiratory", "Urology", "Surgery"];


    });
</script>

<%@include file="footer.jsp" %>
