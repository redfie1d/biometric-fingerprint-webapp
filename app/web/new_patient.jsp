<%-- 
    Document   : new_patient
    Created on : 24 Nov, 2016, 2:26:14 PM
    Author     : tcw
--%>

<%@include file="header.jsp" %>
<%@include file="protect.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper" style="margin-left: 0 !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Register New Patient
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

        <br/>

        <div class="row">

            <div class="col-md-3">
                <div id="fg_box" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Fingerprints</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body" style="padding:0;">

                        <!-- Custom Tabs -->
                        <div class="nav-tabs-custom">
                            <ul class="nav nav-tabs">
                                <li class="active"><a id="fg1_tab" href="#tab_1" data-toggle="tab">Fingerprint 1</a></li>
                                <li><a id="fg2_tab" href="#tab_2" data-toggle="tab">Fingerprint 2</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab_1">

                                    <div class="row text-center">
                                        <div class="col-sm-12">
                                            <img id="fg1Image" class="img-responsive" src="dist/img/fingerprint.png" alt="Photo">
                                        </div>
                                    </div>

                                    <br/>

                                    <div class="row text-center">
                                        <div class="col-sm-12">
                                            <button class="btn btn-info" id="Bt_Identify_1" onclick="Identify_1();" style="width:100%;">Scan</button>
                                            <p id="fg1_msg" style="display:none"></p>
                                        </div>
                                    </div>


                                </div>

                                <div class="tab-pane" id="tab_2">

                                    <div class="row text-center">
                                        <div class="col-sm-12">
                                            <img id="fg2Image" class="img-responsive" src="dist/img/fingerprint.png" alt="Photo">
                                        </div>
                                    </div>

                                    <br/>

                                    <div class="row text-center">
                                        <div class="col-sm-12">
                                            <button class="btn btn-info" id="Bt_Identify_2" onclick="Identify_2();" style="width:100%;">Scan</button>
                                            <p id="fg2_msg" style="display:none"></p>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <!-- /.tab-content -->
                        </div>
                        <!-- nav-tabs-custom -->

                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>


            <div class="col-md-6">
                <div id="patientRecordsBox" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Patient Records</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="form-group">
                            <label for="village">Village</label>
                            <!--<input type="text" class="form-control" id="village" name="village" placeholder="Enter village">-->
                            <select name="village" id="village" class="form-control">
                                <option value="PCV" selected>PCV</option>
                                <option value="KSV">KSV</option>

                            </select>
                        </div>

                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter name">
                        </div>

                        <div class="form-group">
                            <label for="name">Contact No.</label>
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Enter contact no.">
                        </div>

                        <div class="form-group">
                            <label for="dateOfBirth">Date of Birth</label>
                            <input class="form-control" type="date" name="dateOfBirth" id="dateOfBirth">
                        </div>

                        <div class = "row">
                            <div class="form-group col-md-6">
                                <label for="gender">Gender</label>
                                <div class="form-group row">
                                    <div class="radio col-md-4" style="margin-top:5px">
                                        <label>
                                            <input type="radio" name="gender" id="optionsRadios1" value="Male" checked="">Male
                                        </label>
                                    </div>
                                    <div class="radio col-md-4" style="margin-top:5px">
                                        <label>
                                            <input type="radio" name="gender" id="optionsRadios2" value="Female">Female
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class ="form-group col-md-6">
                                <label for="travellingTimeToClinic">Travelling Time (mins)</label>
                                <input type="number" class="form-control" id="travellingTimeToClinic" name="travellingTimeToClinic" placeholder="Minutes">
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
                        <button class="btn btn-primary btn-lg" id="btn-create-record" onclick="createPatientRecord();">Create Record</button>
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
<script src='js/new_patient.js'></script>

<%@include file="footer.jsp" %>
