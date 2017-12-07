<%-- 
    Document   : update_patient
    Created on : 7 Dec, 2017, 2:58:58 PM
    Author     : JunMing
--%>

<%@page import="dao.PatientDAO"%>
<%@page import="model.Patient"%>
<%@include file="header.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="margin-left: 0 !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            <%
                String village = request.getParameter("village");
                Integer patientId = Integer.parseInt(request.getParameter("patientId"));
                Patient patientRecord = PatientDAO.getPatientByPatientID(village, patientId);

            %>
            Update Patient (<%=village + patientId%>)

            <!--<small>Optional description</small>-->
        </h1>
        <!--        <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                    <li class="active">Here</li>
                </ol>-->
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- Your Page Content Here -->
        <div class="row">
            <div id="alertPanel" class="col-md-12">
                <div class="callout alert alert-warning alert-dismissible" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                    <h4 style="margin-bottom:0;"><i class="icon fa fa-check"></i> Alert!</h4>
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

                <!-- /.box -->
            </div>


            <div class="col-md-6">
                <div id="patientRecordsBox" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Update Patient Records</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <input type="hidden" id="village" value="<%=village%>">
                        <input type="hidden" id="patientId" value="<%=patientId%>">

                        <div class="form-group">
                            <label for="name">Update Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="<%=patientRecord.getName()%>">
                        </div>

                        <div class="form-group">
                            <label for="name">Update Contact No.</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="<%=patientRecord.getContactNo()%>">
                        </div>

                        <div class="form-group">
                            <label for="dateOfBirth">Update Date of Birth</label>
                            <input class="form-control" type="date" name="dateOfBirth" id="dateOfBirth" value="<%=patientRecord.getDateOfBirth()%>">
                        </div>

                        <div class = "row">
                            <div class ="form-group col-md-6">
                                <label for="travellingTimeToClinic">Update Travelling Time (mins)</label>
                                <input type="number" class="form-control" id="travellingTimeToClinic" name="travellingTimeToClinic" value="<%=patientRecord.getTravellingTimeToClinic()%>">
                            </div>
                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-3">
                <div id="photo_box" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Photo</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="row">
                            <div class="col-md-12 text-center">
                                <div id="my_result" class="my_camera" style="width:300px; height:240px;"></div>
                            </div>
                        </div>

                        <br/>

                        <div class="row">
                            <div class="col-md-6">
                                <button id="openCameraBtn" type="button" class="btn btn-info cameraPanelBtns">Open Camera</button>
                                <button id="takePhotoBtn" type="button" class="btn btn-info cameraPanelBtns">Take Photo</button>
                            </div>
                            <div class="col-md-6">
                                <button id="closeCameraBtn" type="button" class="btn btn-warning cameraPanelBtns">Close Camera</button>
                            </div>
                        </div>

                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->

                <div class="row pull-right">
                    <div class="col-md-12">
                        <button class="btn btn-primary btn-lg" id="btn-create-record" onclick="updatePatientRecord();">Update Record</button>
                        <button class="btn btn-warning btn-lg" id="btn-create-record" onclick="clearNewRegistrationForm();">Clear</button>
                    </div>
                </div>
            </div>


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
<script src='js/update_patient.js'></script>

<%@include file="footer.jsp" %>
