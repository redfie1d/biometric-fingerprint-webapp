var fingerprint1Taken = false;
var fingerprint2Taken = false;
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
    
    $('#removeMedicine').hide();
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

//    var patientID = $("#patientID").val();
    var village = $("#village option:selected").text();
    var name = $("#name").val();
    var contactNo = $("#phoneNumber").val();
    var gender = $("input[name='gender']:checked").val();
    var dateOfBirth = $("#dateOfBirth").val();
    var travellingTimeToClinic = $("#travellingTimeToClinic").val();

//    console.log(patientID);
    console.log(village);
    console.log(name);
    console.log(contactNo);
    console.log(gender);
    console.log(dateOfBirth);
    console.log(travellingTimeToClinic);

    var villageFilled = village !== null && village.length > 0;
    var nameFilled = name !== null && name.length > 0;
    var contactNoFilled = contactNo !== null && contactNo.length > 0;
    var genderFilled = gender !== null && gender.length > 0;
    var dateOfBirthFilled = dateOfBirth !== null && dateOfBirth.length > 0;

    patientRecordsFilled = villageFilled && nameFilled && genderFilled && dateOfBirthFilled;

    if (fingerprint1Taken && fingerprint2Taken && photoTaken && patientRecordsFilled) {
        jQuery.ajax({
            type: "POST",
            url: "CreatePatientServlet",
            data: {
                village: village,
                name: name,
                contactNo: contactNo,
                gender: gender,
                dateOfBirth: dateOfBirth.trim(),
                travellingTimeToClinic: travellingTimeToClinic,
                photoImage: img1
            },
            success: function (msg) {
                console.log(msg);
                if (msg.status === "null") {
                    $("#alertPanel>div").css("display", "block").addClass("alert-warning").removeClass("alert-success");
                    $("#alertPanel>div>h4").html("Fingerprint recording failed, please scan fingerprint again");   
                    $("#fg_box").addClass("box-danger").removeClass("box-info").removeClass("box-success");
                    $("#fg1_tab").removeClass("bg-green");
                    $("#fg2_tab").removeClass("bg-green");
                } else {
                    $("#alertPanel>div").css("display", "block").addClass("alert-success").removeClass("alert-warning");
                    $("#alertPanel>div>h4").html("You have successfully created a new patient record");
//                $("#alertPanel>div").append('<a href="existing_patient.jsp" class="btn btn-lg pull-right" style="background:#763d3c;text-decoration:none;border: 1px solid #763d3c;box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);}">Back to Main Page</a>');
                    $("#alertPanel>div").append("<h1>ID: " + msg.newID + "</h1>");
                    $("#patientRecordsBox").addClass("box-success").removeClass("box-info");
                }

            },
            error: function (request, status, error) {
                console.log(request);
            }
        });
    } else {
        console.log("gg");
        var missingFields = [];

        if (!villageFilled) {
            missingFields.push("Please choose a village");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!nameFilled) {
            missingFields.push("Please enter the patient's name");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!genderFilled) {
            missingFields.push("Please specify gender");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!dateOfBirthFilled) {
            missingFields.push("Please enter the patient's date of birth");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!(fingerprint1Taken && fingerprint2Taken)) {
            missingFields.push("Please register two fingerprints for the patient");
            $("#fg_box").addClass("box-danger").removeClass("box-info");
        }

        if (!photoTaken) {
            missingFields.push("Please take photo of the patient");
            $("#photo_box").addClass("box-danger").removeClass("box-info");
        }
        
        if (missingFields.length > 0) {
            $("#alertPanel>div").css("display", "block").addClass("alert-danger").removeClass("alert-success");
        }

        var validationHtml = "";
        missingFields.forEach(function (missingField) {
            validationHtml += missingField + "<br/>";
        });

        $("#alertPanel>div>h4").html(validationHtml);
    }
}

function createPatientRecord2() {

//    var patientID = $("#patientID").val();
    var village = $("#village option:selected").text();
    var name = $("#name").val();
    var contactNo = $("#phoneNumber").val();
    var gender = $("input[name='gender']:checked").val();
    var dateOfBirth = $("#dateOfBirth").val();
    var travellingTimeToClinic = $("#travellingTimeToClinic").val();

//    console.log(patientID);
    console.log(village);
    console.log(name);
    console.log(contactNo);
    console.log(gender);
    console.log(dateOfBirth);
    console.log(travellingTimeToClinic);

    var villageFilled = village !== null && village.length > 0;
    var nameFilled = name !== null && name.length > 0;
    var contactNoFilled = contactNo !== null && contactNo.length > 0;
    var genderFilled = gender !== null && gender.length > 0;
    var dateOfBirthFilled = dateOfBirth !== null && dateOfBirth.length > 0;

    patientRecordsFilled = villageFilled && nameFilled && genderFilled && dateOfBirthFilled;

    if (fingerprint1Taken && fingerprint2Taken && photoTaken && patientRecordsFilled) {
        jQuery.ajax({
            type: "POST",
            url: "CreatePatientServlet2",
            data: {
                village: village,
                name: name,
                contactNo: contactNo,
                gender: gender,
                dateOfBirth: dateOfBirth.trim(),
                travellingTimeToClinic: travellingTimeToClinic,
                photoImage: img1
            },
            success: function (msg) {
                console.log(msg);
                if (msg.status === "null") {
                    $("#alertPanel>div").css("display", "block").addClass("alert-warning").removeClass("alert-success");
                    $("#alertPanel>div>h4").html("Fingerprint recording failed, please scan fingerprint again");   
                    $("#fg_box").addClass("box-danger").removeClass("box-info").removeClass("box-success");
                    $("#fg1_tab").removeClass("bg-green");
                    $("#fg2_tab").removeClass("bg-green");
                } else {
                    $("#alertPanel>div").css("display", "block").addClass("alert-success").removeClass("alert-warning");
                    $("#alertPanel>div>h4").html("You have successfully created a new patient record");
//                $("#alertPanel>div").append('<a href="existing_patient.jsp" class="btn btn-lg pull-right" style="background:#763d3c;text-decoration:none;border: 1px solid #763d3c;box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);}">Back to Main Page</a>');
                    $("#alertPanel>div").append("<h1>ID: " + msg.newID + "</h1>");
                    $("#patientRecordsBox").addClass("box-success").removeClass("box-info");
                }

            },
            error: function (request, status, error) {
                console.log(request);
            }
        });
    } else {
        console.log("gg");
        var missingFields = [];

        if (!villageFilled) {
            missingFields.push("Please choose a village");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!nameFilled) {
            missingFields.push("Please enter the patient's name");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!genderFilled) {
            missingFields.push("Please sepcify gender");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!dateOfBirthFilled) {
            missingFields.push("Please enter the patient's date of birth");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!(fingerprint1Taken && fingerprint2Taken)) {
            missingFields.push("Please register two fingerprints for the patient");
            $("#fg_box").addClass("box-danger").removeClass("box-info");
        }

        if (!photoTaken) {
            missingFields.push("Please take photo of the patient");
            $("#photo_box").addClass("box-danger").removeClass("box-info");
        }
        
        if (missingFields.length > 0) {
            $("#alertPanel>div").css("display", "block").addClass("alert-danger").removeClass("alert-success");
        }

        var validationHtml = "";
        missingFields.forEach(function (missingField) {
            validationHtml += missingField + "<br/>";
        });

        $("#alertPanel>div>h4").html(validationHtml);
    }
}



function clearNewRegistrationForm() {
    location.reload();
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


    $("#fg1_tab").removeClass("bg-green").removeClass("bg-red");

    jQuery.ajax({
        type: "POST",
        url: "IdentifyFingerprintServlet",
        data: {
            fingerprintNumber: 1
        },
        success: function (msg) {
//            msg = JSON.parse(msg);
            console.log(msg);

            $("#Bt_Identify_1").prop("disabled", false);

//            console.log(msg.img);

//            $("#fg1Image").attr("src", 'data:image/bmp;base64,' + msg.img);

            if (msg.msg === "no patient identified") {
//                $("#fg1_box").addClass("box-success").removeClass("box-info");
                $("#fg1_tab").addClass("bg-green");
                $("#fg1_msg").css("color", "green");
                $("#fg1_msg").html("Fingerprint Recorded");
                fingerprint1Taken = true;

            } else if (msg.status === "success") {
//                $("#fg1_box").addClass("box-danger").removeClass("box-info");
                $("#fg1_tab").addClass("bg-red");
                $("#fg1_msg").css("color", "red");
                $("#fg1_msg").html("Fingerprint Already Exists. Please Scan Again");
                fingerprint1Taken = false;
            }

            $("#fg1_msg").css("display", "initial");

            if (fingerprint1Taken && fingerprint2Taken) {
                console.log("123");
                $("#fg_box").addClass("box-success").removeClass("box-info");
            }
        },
        error: function (request, status, error) {
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


//            $("#fg2Image").attr("src", 'data:image/bmp;base64,' + msg.img);

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
                console.log("456");
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


function Add_Medicine(options){
    var table = document.getElementById("issueMedicine");
    var numRows = table.getElementsByTagName("tr").length;
    var row = table.insertRow(-1);
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    
    var medicine = options.split("_");
    var optionValues = "";
    for(var i in medicine){
        optionValues += "<option value='" + medicine[i].substring(0,medicine[i].lastIndexOf("(")).trim() + "' type=text>" + medicine[i] + "</option>";
        
    }
    
 
    cell1.innerHTML = `<select name="medicine" class="form-control">` + optionValues + `</select>`
    cell1.style.width ="25%";
    
    cell2.innerHTML = 
    `<td>
        <input name="quantity" placeholder="Quantity" class="form-control" type="number" required/>
    </td>`
    cell3.innerHTML = 
    `<td>
        <input name="notes" placeholder="Notes" class="form-control" type="text">
    </td>`
    cell4.innerHTML = 
    `<td>
        <input name="remarks" placeholder="Remarks" class="form-control" type="text">
    </td>`
    
    $('#removeMedicine').show();

}

function Remove_Medicine(){
    var table = document.getElementById("issueMedicine");
    table.deleteRow(-1);
    
    var numRows = table.getElementsByTagName("tr").length;
    if(numRows === 2){
        $('#removeMedicine').hide();
    }
}