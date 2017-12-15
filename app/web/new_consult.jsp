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
<%@page import="model.Order"%>
<%@page import="model.Drug"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.InventoryDAO"%>
<%@page import="dao.ConsultDAO"%>
<%@page import="model.Consult"%>
<%@page import="dao.VisitDAO"%>
<%@page import="dao.PatientDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="model.Vitals"%>
<%@page import="model.Patient"%>
<%@page import="model.Visit"%>
<%@include file="header.jsp" %>
<%@ include file="protect.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="margin-left: 0 !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <%            String doctorName = user.getName();
        %>
        <h1>Doctor's Consultation (<%=doctorName%>)</h1>
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
            ConsultDAO consultDAO = new ConsultDAO();

            String displayState = "block";

            Object visitObject = session.getAttribute("visitRecord");
            Object patientObject = session.getAttribute("patientRecord");
            String[] savedDetails = (String[]) session.getAttribute("savedDetails");

            String consultDetails = "";
            String diagnosisDetails = "";
            String urineDetails = "";
            String hemocueDetails = "";
            String bloodDetails = "";
            String referralDetails = "";

            if (savedDetails != null) {
                System.out.println("SAVED DETAILS IS NOT NULL");
                consultDetails = savedDetails[0];
                diagnosisDetails = savedDetails[1];
                urineDetails = savedDetails[2];
                hemocueDetails = savedDetails[3];
                bloodDetails = savedDetails[4];
                referralDetails = savedDetails[5];
            }

            boolean viewPastConsultRecord = false;
            Object viewPastConsultRecordObject = session.getAttribute("viewPastConsultRecord");
            if (viewPastConsultRecordObject != null) {
                viewPastConsultRecord = (boolean) viewPastConsultRecordObject;
            }

            Visit visitRecord = visitObject == null ? null : (Visit) visitObject;
//            DateFormat df = new SimpleDateFormat("dd/mm/yyyy");
//            visitRecord = df.format(new Date()).equals(visitRecord.getDate()) ? visitRecord : null;

            Patient patientRecord = patientObject == null ? null : (Patient) patientObject;
            Vitals vitalsObject = visitRecord == null ? null : visitRecord.getVitals();

            String patientDetailsDisplayState = visitRecord != null && patientRecord != null ? "block" : "none";

            Visit[] pastVisits = null;

            String consultDisplayState = "none";
            if (visitRecord != null) {
                System.out.println(visitRecord.getId());

                consultDisplayState = consultDAO.getConsultByVisitID(visitRecord.getId()) == null || viewPastConsultRecord ? "block" : "none";

                //visitRecord = VisitDAO.getPatientLatestVisit(visitRecord.getPatientId());
                vitalsObject = visitRecord.getVitals();
                pastVisits = VisitDAO.getVisitByPatientID(visitRecord.getPatientId());
            }

            session.removeAttribute("viewPastConsultRecord");
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
                                            <%
                                                String dateOfBirth = patientRecord.getDateOfBirth();
                                                int yearOfBirth = Integer.parseInt(dateOfBirth.substring(0, 4));
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

                                    <%
                                        if (vitalsObject != null) {
                                    %>

                                    <div class="box-footer no-padding">
                                        <div class="row" style="padding-left:15px;">
                                            <div class="col-md-12">
                                                <h3><b>Current Vitals Record</b></h3>
                                            </div>
                                        </div>

                                        <div class="row" style="padding:15px;">
                                            <div class="col-md-3">
                                                <b>Height:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=vitalsObject.getHeight()%>
                                            </div>

                                            <div class="col-md-3">
                                                <b>Weight:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=vitalsObject.getWeight()%>
                                            </div>
                                        </div>
                                        <div class="row" style="padding:15px;">
                                            <div class="col-md-3">
                                                <b>BP:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=vitalsObject.getSystolic()%>/<%=vitalsObject.getDiastolic()%>
                                            </div>

                                            <div class="col-md-3">
                                                <b>Temp:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%=vitalsObject.getTemperature()%>
                                            </div>
                                        </div>

                                        <div class="row" style="padding:15px;">
                                            <div class="col-md-3">
                                                <b>HIV Positive:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%
                                                    if (vitalsObject.getHivPositive() == 1) {
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

                                            <div class="col-md-3">
                                                <b>PTB Positive:</b>
                                            </div>
                                            <div class="col-md-3">
                                                <%
                                                    if (vitalsObject.getPtbPositive() == 1) {
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
                        <table class="table" >
                            <tbody>
                                <tr>
                                    <th>#</th>
                                    <th>Date</th>
                                    <th>Doctor</th>
                                    <th>Action</th>
                                </tr>
                                <%
                                    int count = 1;
                                    for (Visit v : pastVisits) {
                                        String consultDate = "";
                                        String date = "";
                                        try {
                                            Consult pastConsult = ConsultDAO.getConsultByVisitID(v.getId());
                                            consultDate = pastConsult.getConsultDate();
                                            
                                            Date d = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy").parse(consultDate);
                                            date = new SimpleDateFormat("dd/MM/yyyy  HH:mm").format(d);
                                        } catch (Exception e) {
                                            Date d = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy").parse(v.getDate());
                                            date = new SimpleDateFormat("dd/MM/yyyy  HH:mm").format(d);
                                        }
                                        
                                        int visitID = v.getId();

                                        Consult consult = consultDAO.getConsultByVisitID(visitID);
                                        if (consult != null) {
                                            String doctor = consult.getDoctor();
                                %>
                                <tr>
                                    <td><%=count++%></td>
                                    <td><%=date%></td>
                                    <td><%=doctor%></td>
                                    <td>
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
                                    </td>
                                </tr>

                                <%
                                            }
                                        }
                                    }

                                %>
                            </tbody>
                        </table>  
                    </div>
                </div>

            </div>

            <div class="col-md-8">

                <div id="patientRecordsBox" class="box box-info box-solid" style="display:<%=consultDisplayState%>">
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

                        <form action="CreateConsultServlet" method="POST" class="row">

                            <input type="hidden" name="visitId" value="<%=visitRecord != null ? visitRecord.getId() : ""%>">
                            <input type="hidden" name="doctor" value="<%=doctorName != null && doctorName.length() > 0 ? doctorName : ""%>">

                            <div class="col-md-9">
                                <div class="form-group">
                                    <label>Consult Details</label>
                                    <%
                                        if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null) {
                                    %>
                                    <textarea class="form-control" name="consultDetails" id="consultDetails" rows="3" style="height:200px" disabled><%=visitRecord.getConsult().getNotes()%></textarea>

                                    <%
                                    } else {
                                    %>
                                    <textarea class="form-control" name="consultDetails" id="consultDetails" rows="3" placeholder="Enter here..." style="height:200px" onblur="saveTextBoxDetails()"><%=consultDetails%></textarea>

                                    <%
                                        }
                                    %>
                                </div>

                                <div class="form-group">
                                    <label>Diagnosis</label>
                                    <%
                                        if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null) {
                                    %>
                                    <textarea class="form-control" name="diagnosis" rows="3" style="height:80px" disabled><%=visitRecord.getConsult().getDiagnosis()%></textarea>

                                    <%
                                    } else {
                                    %>
                                    <textarea class="form-control" id="diagnosisDetails" name="diagnosis" rows="3" placeholder="Enter here..." style="height:200px" onBlur="saveTextBoxDetails()"><%=diagnosisDetails%></textarea>

                                    <%
                                        }
                                    %>                                
                                </div>

                                <div class="form-group">
                                    <label>STAT Investigations</label>
                                </div>

                                <div class ="col-md-6" style="padding:0">
                                    <div class="form-group">
                                        <label>Urine Dip Test</label>
                                        <%
                                            if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="urine" rows="3" style="height:100px" disabled><%=visitRecord.getConsult().getUrine_test()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="urine" id="urineDetails" rows="3" placeholder="Leave blank if NA..." style="height:200px" onBlur="saveTextBoxDetails()"><%=urineDetails%></textarea>

                                        <%
                                            }
                                        %>                                    
                                    </div>

                                    <div class="form-group">
                                        <label>Hemocue Hb Test</label>
                                        <%
                                            if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="hemocue" rows="3" style="height:100px" disabled><%=visitRecord.getConsult().getHemocue_count()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="hemocue" id="hemocueDetails" rows="3" placeholder="Leave blank if NA..." style="height:200px" onBlur="saveTextBoxDetails()"><%=hemocueDetails%></textarea>

                                        <%
                                            }
                                        %>      
                                    </div>

                                </div>  
                                <div class ="col-md-6">
                                    <div class="form-group">
                                        <label>Capillary Blood Glucose Test</label>
                                        <%
                                            if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="blood" rows="3" style="height:100px" disabled><%=visitRecord.getConsult().getBlood_glucose()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="blood" id="bloodDetails" rows="3" placeholder="Leave blank if NA..." style="height:200px" onBlur="saveTextBoxDetails()"><%=bloodDetails%></textarea>

                                        <%
                                            }
                                        %>      
                                    </div>
                                </div>
                                <div class="col-md-12" style="padding:0">
                                    <div class="form-group">
                                        <label>Referral Letter (if needed)</label>
                                        <%
                                            if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null) {
                                        %>
                                        <textarea class="form-control" name="referrals" rows="3" style="height:100px" disabled><%=visitRecord.getConsult().getReferrals()%></textarea>

                                        <%
                                        } else {
                                        %>
                                        <textarea class="form-control" name="referrals" id="referralDetails" rows="3" placeholder="Leave blank if NA..." style="height:200px" onBlur="saveTextBoxDetails()"><%=referralDetails%></textarea>

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
                                            String disable = "";
                                            if (viewPastConsultRecord && visitRecord != null && visitRecord.getConsult() != null && visitRecord.getConsult().getProblems() != null) {
                                                disable += "disabled";
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
                                            out.println("<input type=\"checkbox\" name=\"problems\" class='problemsCB' value='" + s + "' " + checked + " " + disable + ">");
                                            out.println(s);
                                            out.println("</label>");
                                            out.println("</div>");
                                        }

                                    %>
                                </div>
                            </div>
                            <%                                String chronicReferral = "";
                                String disable = "";

                                if (visitRecord != null && visitRecord.getConsult() != null && visitRecord.getConsult().isChronic_referral()) {
                                    chronicReferral = "checked";
                                }

                                if (viewPastConsultRecord) {
                                    disable = "disabled";
                                }
                            %>
                            <div class="col-md-12">
                                <div class="checkbox">
                                    <label>
                                        <%
                                            out.println("<input type='checkbox' name='chronicReferral' class='problemsCB' value='true' " + chronicReferral + " " + disable + ">");
                                        %>
                                        Chronic Referral
                                    </label>
                                </div>
                                <br>

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
                                        <table class="table" id="issueMedicine">
                                            <tbody>
                                                <tr>
                                                    <th>Medicine</th>
                                                    <th>Quantity</th>
                                                    <th>Regimen</th>
                                                    <th>Remarks</th>
                                                </tr>

                                                <%
                                                    String optionValues = "";
                                                    InventoryDAO inventoryDAO = new InventoryDAO();

                                                    if (viewPastConsultRecord) {
                                                        ArrayList<Order> orderList = inventoryDAO.getOrdersByVisitID(visitRecord.getId());

                                                        for (Order order : orderList) {
                                                            String selectTag = "<input name='medicine' class='form-control medicine' id='medicines' value='" + order.getMedicine() + "' disabled";
                                                            String quantityInputTag = "<input name='quantity' placeholder='Quantity' class='form-control quantity' type='number' value='" + order.getQuantity() + "' disabled";
                                                            String notesInputTag = "<input name='notes' placeholder='Regimen' class='form-control notes' type='text' value='" + order.getNotes() + "' disabled";
                                                            String remarksInputTag = "<input name='remarks' placeholder='Remarks' class='form-control remarks' type='text' value='" + order.getRemarks() + "' disabled";

                                                            out.println("<tr><td>");
                                                %>
                                                <%=selectTag%>
                                                </td>
                                            <td>
                                                <%=quantityInputTag%>
                                            </td>
                                            <td>
                                                <%=notesInputTag%>
                                            </td>
                                            <td>
                                                <%=remarksInputTag%>
                                            </td>
                                            </tr>
                                            <%
                                                }
                                            } else if (visitRecord != null) {
                                                String selectTag = "<select name='medicine' class='form-control medicine' id='medicines'>";
                                                String quantityInputTag = "<input name='quantity' placeholder='Quantity' class='form-control quantity' type='number'>";
                                                String notesInputTag = "<input name='notes' placeholder='Regimen' class='form-control notes' type='text'>";
                                                String remarksInputTag = "<input name='remarks' placeholder='Remarks' class='form-control remarks' type='text'>";

                                                out.println("<tr>");

                                                ArrayList<Drug> drugList = inventoryDAO.getInventory();

                                                Collections.sort(drugList, new Comparator<Drug>() {
                                                    @Override
                                                    public int compare(Drug drug1, Drug drug2) {
                                                        return Integer.parseInt(drug1.getMedicine_name().split("\\.")[0]) - Integer.parseInt(drug2.getMedicine_name().split("\\.")[0]);
                                                    }
                                                });

                                                optionValues = drugList.get(0).getMedicine_name() + "(" + drugList.get(0).getQuantity() + ")";

                                                for (int i = 1; i < drugList.size(); i++) {
                                                    optionValues += "_" + drugList.get(i).getMedicine_name() + " (" + drugList.get(i).getQuantity() + ")";
                                                }
                                            %>
                                            <input type="hidden" name="visitId" value=<%=visitRecord.getId()%>>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            </tbody>

                                        </table>
                                        <%
                                            if (!viewPastConsultRecord) {
                                        %>      
                                        <hr>
                                        <div style="float:left">
                                            <span class="input-group-btn" style="width:0;padding-right:10px">
                                                <button type="button" class="btn btn-info btn-flat" id="addMedicine" onClick="Add_Medicine('<%=optionValues%>')">Add Medicine</button>
                                            </span>

                                            <span class="input-group-btn" style="width:0; padding-right:10px">
                                                <button type="button" class="btn btn-info btn-flat" id="removeMedicine" onClick="Remove_Medicine()">Remove Medicine</button>
                                            </span>
                                        </div>
                                        <%
                                            }
                                        %>


                                    </div>

                                </div>
                                <%
                                    if (!viewPastConsultRecord && visitRecord != null) {
                                %>
                                <button class="btn btn-primary btn-lg" id="btn-create-record" type="submit">Create Consult Record</button>
                                <%
                                    }

                                    viewPastConsultRecord = false;
                                %>

                            </div> 
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
<script src='js/save_consult.js'></script>

<script>
//            .summaryProblemGroup
                                                    $(document).ready(function () {
                                                        var problems = ["Cardiovascular", "Dental", "Dermatology", "Endocrine", "ENT", "Eye",
                                                            "Gastrointestinal", "Gynaecology", "Hematology", "Infectious Diseases", "Musculo-skeletal", "Neurology",
                                                            "Oncology", "Psychology", "Renal", "Respiratory", "Urology", "Surgery"];


                                                    });
</script>

<%@include file="footer.jsp" %>
