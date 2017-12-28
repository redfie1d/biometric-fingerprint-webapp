var fingerprint1Taken = true;
var fingerprint2Taken = true;
var photoTaken = false;
var patientRecordsFilled = false;
var img1 = "";

$(document).ready(function () {
//    Identify();

    jQuery.ajax({
        type: "POST",
        url: "ClearFingerprint",
        success: function (msg) {
            console.log(msg);
        },
        error: function (request, status, error) {
            console.log(request);
        }
    });

    $("#closeCameraBtn").hide();
    $("#takePhotoBtn").hide();

    $("#openCameraBtn").click(function () {
        Webcam.attach('.my_camera');
        $(this).hide();
        $("#closeCameraBtn").show();
        $("#takePhotoBtn").show();
        $("#photo_box").removeClass("box-success").addClass("box-info");
    });

    $("#takePhotoBtn").click(function () {
        take_snapshot();
    });

    $("#closeCameraBtn").click(function () {
        Webcam.reset();
        $("#my_result").html('<img src="' + img1 + '"/>');
        $(this).hide();
        $("#openCameraBtn").show();
        $("#takePhotoBtn").hide();
        if (img1.length > 0) {
            $("#photo_box").removeClass("box-info").addClass("box-success");
        }
    });
});

function take_snapshot() {
    Webcam.snap(function (data_uri) {
        img1 = data_uri;
        Webcam.reset();
        $("#my_result").html('<img id="photoTaken" src="' + img1 + '"/>');
        $("#takePhotoBtn").hide();
        $("#closeCameraBtn").hide();
        $("#openCameraBtn").show();
        $("#photo_box").removeClass("box-info").addClass("box-success");
        photoTaken = true;
    });
}

function createPatientRecord() {

    var patientID = $("#patientID").val();
    var village = $("#village").val();
    var name = $("#name").val();
    var gender = $("#gender").val();
    var dateOfBirth = $("#dateOfBirth").val();

    console.log(patientID);
    console.log(village);
    console.log(name);
    console.log(gender);
    console.log(dateOfBirth);

    var patientIDFilled = patientID !== null && patientID.length > 0;
    var villageFilled = village !== null && village.length > 0;
    var nameFilled = name !== null && name.length > 0;
    var genderFilled = gender !== null && gender.length > 0;
    var dateOfBirthFilled = dateOfBirth !== null && dateOfBirth.length > 0;

    patientRecordsFilled = patientIDFilled && villageFilled && nameFilled && genderFilled && dateOfBirthFilled;

    if (fingerprint1Taken && fingerprint2Taken && photoTaken && patientRecordsFilled) {
        jQuery.ajax({
            type: "POST",
            url: "CreatePatientServlet",
            data: {
                patientID: patientID,
                village: village,
                name: name,
                gender: gender,
                dateOfBirth: dateOfBirth,
                photoImage: img1
            },
            success: function (msg) {
//                console.log(msg);
                $("#alertPanel>div").css("display", "block").addClass("alert-success").removeClass("alert-warning");
                $("#alertPanel>div>h4").html("You have successfully created a new patient record");
                $("#patientRecordsBox").addClass("box-success").removeClass("box-info");

            },
            error: function (request, status, error) {
                console.log(request);
            }
        });
    } else {
        console.log("gg");
        $("#alertPanel>div").css("display", "block").addClass("alert-danger").removeClass("alert-success");
        $("#alertPanel>div>h4").html("Fields missing");
        $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
    }
}

function Init() {
    jQuery.ajax({
        type: "GET",
        url: "InitializeBioMiniServlet",
        success: function (msg) {

            console.log(msg);

            Identify();


//				AppendLog("Init", msg.retString);
//				if(msg.retValue == 0) {
//					deviceInfos = msg.ScannerInfos;
//					AddScannerList(deviceInfos);
//                                        CheckStatusLoop();
//				}

        },
        error: function (request, status, error) {
            console.log(request);
        }
    });


}

function UnInit() {

    jQuery.ajax({
        type: "GET",
        url: "UninitializeBioMiniServlet",
        dataType: "json",
        success: function (msg) {

        },
        error: function (request, status, error) {

        }
    });
}



function Identify() {
    $("#Bt_Identify").attr("disabled", "true");
//		if( isExistScannerHandle() == false ){
//			Toast('Scanner Init First', gToastTimeout);
//			return ;
//		} 

//		if(numOfEnrolledUser == 0) {
//			AppendLogData("First, add User Data");
//			return;
//		}

    jQuery.ajax({
        type: "GET",
        url: "IdentifyFingerprintServlet",
        success: function (msg) {
            console.log(msg);
            $("#Bt_Identify").prop("disabled", false);
        },
        error: function (request, status, error) {
        }
    });
}

function Identify_1() {
    $("#Bt_Identify_1").attr("disabled", "true");
//		if( isExistScannerHandle() == false ){
//			Toast('Scanner Init First', gToastTimeout);
//			return ;
//		} 

//		if(numOfEnrolledUser == 0) {
//			AppendLogData("First, add User Data");
//			return;
//		}

    $("#registerBtn").css("display", "none");
    $("#fg1_msg").css("display", "none");
    
    $("#fg1_tab").removeClass("bg-green").removeClass("bg-red");
    console.log("identify 1");

    jQuery.ajax({
        type: "POST",
        url: "IdentifyFingerprintServlet",
        data: {
            fingerprintNumber: 1
        },
        success: function (msg) {
//            msg = JSON.parse(msg);
            console.log(msg);

            if (msg.status !== "error") {
                var pInfo = JSON.parse(msg.msg);
//                console.log(pInfo.patientId);
//                console.log(pInfo.village);

                window.location.href = "SearchPatientServlet?patientID=" + pInfo.village + pInfo.patientId;
            }
            else{
                $("#Bt_Identify_1").prop("disabled", false);
                $("#fg1_msg").css("display", "initial");
                $("#fg1_msg").css("color", "red");
                $("#fg1_msg").html("No patient identified, would you want to register this patient?");
                $("#registerBtn").css("display", "block");
            }


//            $("#Bt_Identify_1").prop("disabled", false);
//            
////            console.log(msg.img);
//
//            $("#fg1Image").attr("src", 'data:image/bmp;base64,' + msg.img);
//
//            if (msg.msg === "no patient identified") {
////                $("#fg1_box").addClass("box-success").removeClass("box-info");
//                $("#fg1_tab").addClass("bg-green");
//                $("#fg1_msg").css("color", "green");
//                $("#fg1_msg").html("Fingerprint Recorded");
//                fingerprint1Taken = true;
//
//            } else if (msg.status === "success") {
////                $("#fg1_box").addClass("box-danger").removeClass("box-info");
//                $("#fg1_tab").addClass("bg-red");
//                $("#fg1_msg").css("color", "red");
//                $("#fg1_msg").html("Fingerprint Already Exists. Please Scan Again");
//                fingerprint1Taken = false;
//            }
//
//            $("#fg1_msg").css("display", "initial");
//
//            if (fingerprint1Taken && fingerprint2Taken) {
//                $("#fg_box").addClass("box-success").removeClass("box-info");
//            }
        },
        error: function (request, status, error) {
            console.log(error);
        }
    });
}

function Identify_2() {
    $("#Bt_Identify_2").attr("disabled", "true");
//		if( isExistScannerHandle() == false ){
//			Toast('Scanner Init First', gToastTimeout);
//			return ;
//		} 

//		if(numOfEnrolledUser == 0) {
//			AppendLogData("First, add User Data");
//			return;
//		}


    $("#fg2_tab").removeClass("bg-green").removeClass("bg-red");

    jQuery.ajax({
        type: "GET",
        url: "IdentifyFingerprintServlet",
        data: {
            fingerprintNumber: 2
        },
        success: function (msg) {
            console.log(msg);
            $("#Bt_Identify_2").prop("disabled", false);


            $("#fg2Image").attr("src", 'data:image/bmp;base64,' + msg.img);

            if (msg.msg === "no patient identified") {
//                $("#fg2_box").addClass("box-success").removeClass("box-info");
                $("#fg2_tab").addClass("bg-green");
                $("#fg2_msg").css("color", "green");
                $("#fg2_msg").html("Fingerprint Recorded");
                fingerprint2Taken = true;
            } else if (msg.status === "success") {
//                $("#fg2_box").addClass("box-danger").removeClass("box-info");
                $("#fg2_tab").addClass("bg-red");
                $("#fg2_msg").css("color", "red");
                $("#fg2_msg").html("Fingerprint Already Exists. Please Scan Again");
                fingerprint2Taken = false;
            }

            $("#fg2_msg").css("display", "initial");

            if (fingerprint1Taken && fingerprint2Taken) {
                $("#fg_box").addClass("box-success").removeClass("box-info");
            }
        },
        error: function (request, status, error) {
        }
    });
}

function Enroll() {
//		if( isExistScannerHandle() == false ){
//			Toast('Scanner Init First', gToastTimeout);
//			return ;
//		} 
//		

    jQuery.ajax({
        type: "GET",
        url: "EnrollFingerprintServlet",
        success: function (msg) {

//            console.log(msg);

            var image = new Image();
            image.src = 'data:image/png;base64,' + msg;
//            console.log(image);
            $("#fgImage").attr("src", 'data:image/bmp;base64,' + msg);

        },
        error: function (request, status, error) {
        }
    });
}
