<%-- 
    Document   : starter
    Created on : 24 Nov, 2016, 1:19:04 PM
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

        <button id="Bt_Init" style="width:120px;height:30px;" onclick="Init()">Init</button>

        <button id="Bt_Identify" onclick="Identify();" style="width:140px;height:30px;">Identify</button>

        <button id="Bt_Enroll" onclick="Enroll()" style="width:140px;height:30px;">Enroll</button>

        <button id="Bt_UnInit" style="width:120px;height:30px;" onclick="UnInit()">UnInit</button>

        <!-- Your Page Content Here -->
        <div class="row">
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-green">
                    <div class="inner">
                        <h3>New</h3>

                        <p>Patient Registration</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-person-add"></i>
                    </div>
                    <a href="new_patient.jsp" class="small-box-footer">Enter <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-aqua">
                    <div class="inner">
                        <h3>65</h3>

                        <p>Patient Details</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-pie-graph"></i>
                    </div>
                    <a href="#" class="small-box-footer">Enter <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
        </div>
        <!-- /.row -->

    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->


<script src='js/array.generics.min.js'></script>
<script src='js/jquery.min.js'></script>
<!--<script src='js/biominiWebAgent.js'></script>-->
<script src='js/sabai.js'></script>

<%@include file="footer.jsp" %>