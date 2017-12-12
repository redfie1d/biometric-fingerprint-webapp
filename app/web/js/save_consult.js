/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function saveTextBoxDetails() {
    var consultDetails = $("#consultDetails").val();
    var diagnosisDetails = $("#diagnosisDetails").val();
    var urineDetails = $("#urineDetails").val();
    var hemocueDetails = $("#hemocueDetails").val();
    var bloodDetails = $("#bloodDetails").val();
    var referralDetails = $("#referralDetails").val();
    
    console.log(consultDetails);
    console.log(diagnosisDetails);
    console.log(urineDetails);
    console.log(hemocueDetails);
    console.log(bloodDetails);
    console.log(referralDetails);
    
    jQuery.ajax({
            type: "POST",
            url: "SaveConsultServlet",
            data: {
               consultDetails: consultDetails,
               diagnosisDetails: diagnosisDetails,
               urineDetails: urineDetails,
               hemocueDetails: hemocueDetails,
               bloodDetails: bloodDetails,
               referralDetails: referralDetails
            },
            success: function (msg) {
             
            },
            error: function (request, status, error) {
                
            }
        });
    
}