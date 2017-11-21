<%-- 
    Document   : new_patient
    Created on : 24 Nov, 2016, 2:26:14 PM
    Author     : tcw
--%>

<%@include file="header.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Sabai Biometrics System
            <!--<small>Optional description</small>-->
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
            <li class="active">Here</li>
        </ol>
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
                <div id="fg1_box" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Fingerprint 1</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row text-center">
                            <div class="btn-group">
                                <button type="button" class="btn btn-info">Left</button>
                                <button type="button" class="btn">Right</button>
                            </div>

                            <div class="btn-group">
                                <button type="button" class="btn btn-info">1</button>
                                <button type="button" class="btn">2</button>
                                <button type="button" class="btn">3</button>
                                <button type="button" class="btn">4</button>
                                <button type="button" class="btn">5</button>
                            </div>
                        </div>

                        <br/>

                        <div class="row text-center">
                            <div class="col-sm-12">
                                <img id="fgImage" class="img-responsive" src="dist/img/fingerprint.png" alt="Photo">
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
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>

            <div class="col-md-3">
                <div id="fg2_box" class="box box-info box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Fingerprint 2</h3>

                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row text-center">
                            <div class="btn-group">
                                <button type="button" class="btn btn-info">Left</button>
                                <button type="button" class="btn">Right</button>
                            </div>

                            <div class="btn-group">
                                <button type="button" class="btn btn-info">1</button>
                                <button type="button" class="btn">2</button>
                                <button type="button" class="btn">3</button>
                                <button type="button" class="btn">4</button>
                                <button type="button" class="btn">5</button>
                            </div>
                        </div>

                        <br/>

                        <div class="row text-center">
                            <div class="col-sm-12">
                                <img class="img-responsive" src="dist/img/fingerprint.png" alt="Photo">
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
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>

            <div class="col-md-6">
                <div class="box box-primary box-solid">
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
                            <label for="exampleInputEmail1">Patient ID</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter patient id">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Village</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter village">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Name</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter name">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Gender</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter gender">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Year of birth</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter year of birth">
                        </div>

                        <!--                        <div class="form-group">
                                                    <label for="exampleInputEmail1">Drug Allergy</label>
                                                    <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter drug allergy">
                                                </div>
                        
                                                <div class="form-group">
                                                    <label for="exampleInputEmail1">Parent</label>
                                                    <input type="email" class="form-control" id="exampleInputEmail1" name="" placeholder="Enter parent">
                                                </div>-->
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
        </div>
        <!-- /.row -->

        <div class="row text-right">
            <div class="col-md-12">
                <button class="btn btn-info btn-lg" id="btn-create-record">Create Record</button>
            </div>
        </div>
        
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script src='js/array.generics.min.js'></script>
<script src='js/jquery.min.js'></script>
<script src='js/new_patient.js'></script>

<%@include file="footer.jsp" %>
