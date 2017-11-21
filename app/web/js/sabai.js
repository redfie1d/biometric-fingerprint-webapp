function Init() {
    jQuery.ajax({
        type: "GET",
        url: "InitializeBioMiniServlet",
        dataType: "json",
        success: function (msg) {

            console.log(msg);
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
        dataType: "json",
        success: function (msg) {
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
        dataType: "json",
        success: function (msg) {
        },
        error: function (request, status, error) {
        }
    });
}