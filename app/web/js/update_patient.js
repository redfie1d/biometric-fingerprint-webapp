var photoTaken = false;
var patientRecordsFilled = false;
var img1 = "default";

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

function updatePatientRecord() {
    var patientId = $("#patientId").val();
    var village = $("#village").val();
    var name = $("#name").val();
    var contactNo = $("#phoneNumber").val();
    var dateOfBirth = $("#dateOfBirth").val();
    var travellingTimeToClinic = $("#travellingTimeToClinic").val();

    console.log(patientId);
    console.log(village);
    console.log(name);
    console.log(contactNo);
    console.log(dateOfBirth);
    console.log(travellingTimeToClinic);

    var patientIdFilled = patientId !== null && patientId.length > 0;
    var villageFilled = village !== null && village.length > 0;
    var nameFilled = name !== null && name.length > 0;
    var contactNoFilled = contactNo !== null && contactNo.length > 0;
    var dateOfBirthFilled = dateOfBirth !== null && dateOfBirth.length > 0;

    patientRecordsFilled = patientIdFilled && villageFilled && nameFilled && dateOfBirthFilled;

    if (patientRecordsFilled) {
        jQuery.ajax({
            type: "POST",
            url: "UpdatePatientServlet",
            data: {
                village: village,
                patientId: patientId,
                name: name,
                contactNo: contactNo,
                dateOfBirth: dateOfBirth.trim(),
                travellingTimeToClinic: travellingTimeToClinic,
                photoImage: img1
            },
            success: function (msg) {
                console.log(msg);
                if (msg.status === "null") {
                    $("#alertPanel>div").css("display", "block").addClass("alert-warning").removeClass("alert-success");
                    $("#alertPanel>div>h4").html("Update of patient details failed, please restart");
                    $("#fg_box").addClass("box-danger").removeClass("box-info").removeClass("box-success");
                    $("#fg1_tab").removeClass("bg-green");
                    $("#fg2_tab").removeClass("bg-green");
                } else {
                    $("#alertPanel>div").css("display", "block").addClass("alert-success").removeClass("alert-warning");
                    $("#alertPanel>div>h4").html("You have successfully updated an existing patient record");
                    $("#alertPanel>div").append('<a href="existing_patient.jsp" class="btn btn-lg pull-right" style="background:#763d3c;text-decoration:none;border: 1px solid #763d3c;box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);}">Back to Registration</a>');
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

        if (!nameFilled) {
            missingFields.push("Please enter the patient's name");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
        }

        if (!dateOfBirthFilled) {
            missingFields.push("Please enter the patient's date of birth");
            $("#patientRecordsBox").addClass("box-danger").removeClass("box-info");
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