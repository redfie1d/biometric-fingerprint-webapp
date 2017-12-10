package util;

import com.suprema.BioMiniSDK;
import dao.FingerprintDAO;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import model.Fingerprint;
import model.Patient;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author tcw
 */
public class FingerprintClass {

    public static Fingerprint fingerprintOne;
    public static Fingerprint fingerprintTwo;

    private static int nInitFlag = 0;

    private static int nCaptureFlag = 0;

    private static int nScannerNumber = 0;

    private static int nTemplateCnt = 0;

    private static byte[][] byteTemplateArray = null;

    private static int[] intTemplateSizeArray = null;

    private static int nSecurityLevel = 0;

    private static long[] hMatcher = new long[1];

    static BioMiniSDK p;
    private static final int MAX_TEMPLATE_SIZE = 1024;

    static {
        p = new BioMiniSDK();
    }

    public static void initArray(int nArrayCnt, int nMaxTemplateSize) {
        if (byteTemplateArray != null) {
            byteTemplateArray = null;

        }

        if (intTemplateSizeArray != null) {
            intTemplateSizeArray = null;

        }

        byteTemplateArray = new byte[nArrayCnt][MAX_TEMPLATE_SIZE];

        intTemplateSizeArray = new int[nArrayCnt];

    }

    public static int testCallScanProcCallback() {
        int nRes = 0;

        // Set the callback function name for getting Scanner Plug event.
        nRes = p.UFS_SetScannerCallback("scannerCallback");
        if (nRes == 0) {
            System.out.println("==>UFS_SetScannerCallback pScanProc ..." + "scannerCallback");

        }
        return nRes;
    }

    public static byte[] enroll(int fingerprintNumber, int fingerprintIndex) {

        long[] hScanner = new long[1];

        hScanner = GetCurrentScannerHandle();

        if (hScanner == null) {
            return null;
        }

        int nRes = 0;

        nRes = p.UFS_ClearCaptureImageBuffer(hScanner[0]);

        System.out.println("place a finger");

        nRes = p.UFS_CaptureSingleImage(hScanner[0]);

        System.out.println("capture single image");

        if (nRes == 0) {

            byte[] bTemplate = new byte[MAX_TEMPLATE_SIZE];

            int[] refTemplateSize = new int[1];

            int[] refTemplateQuality = new int[1];

            try {
                nRes = p.UFS_ExtractEx(hScanner[0], MAX_TEMPLATE_SIZE, bTemplate, refTemplateSize, refTemplateQuality);

                if (nRes == 0) {

                    Patient patient = checkFingerprintIfExist(nRes, bTemplate, refTemplateSize, fingerprintNumber);

                    if (patient != null) {
                        System.out.println("Patient Exists");
                        return null;
                    }

                    System.out.println("save template file template size:" + refTemplateSize[0] + " quality:" + refTemplateQuality[0]);

                    int nSelectedValue = Integer.parseInt((String) ("1"));

                    if (refTemplateQuality[0] < nSelectedValue) {
                        System.out.println("template quality < " + nSelectedValue);
                        return null;
                    }

                    if (nTemplateCnt > 99) {
                        System.out.println("template queue full!! limited 100 template, now " + nTemplateCnt);
                        return null;
                    }

                    int tempsize = refTemplateSize[0];

                    System.arraycopy(bTemplate, 0, byteTemplateArray[nTemplateCnt], 0, refTemplateSize[0]);//byte[][]

//                        try {
//                            System.out.println(new String(bTemplate, "UTF-8"));
//                        } catch (UnsupportedEncodingException ex) {
//                            Logger.getLogger(FingerprintClass.class.getName()).log(Level.SEVERE, null, ex);
//                        }
                    intTemplateSizeArray[nTemplateCnt] = refTemplateSize[0];

                    System.out.println("enroll template array idx:" + nTemplateCnt + " template size:" + intTemplateSizeArray[nTemplateCnt]);

                    nTemplateCnt++;

                    byte[] fgImage = drawCurrentFingerImage(fingerprintNumber);

                    Fingerprint fingerprint = new Fingerprint(bTemplate, refTemplateSize[0], fgImage, fingerprintIndex);

                    if (fingerprintNumber == 1) {
                        fingerprintOne = fingerprint;
                    } else if (fingerprintNumber == 2) {
                        fingerprintTwo = fingerprint;
                    }

//                    FingerprintDAO.addFingerprint(bTemplate, refTemplateSize[0], fgImage);
                    String szComboData = null;
                    szComboData = String.valueOf(nTemplateCnt);

                    System.out.println(szComboData + "asdsa");

                    nCaptureFlag = 1;

                    return fgImage;

                } else {

                }
            } catch (Exception ex) {

                //MsgBox("exception err:"+ex.getMessage());
            }
        }

        return null;
    }

    public static Object identify(int fingerprintNumber) {
        

        long[] hScanner = new long[1];

        hScanner = GetCurrentScannerHandle();

        if (hScanner == null) {
            System.out.println("Unable to get current scanner handle");
            return null;
        }

        p.UFS_ClearCaptureImageBuffer(hScanner[0]);

        System.out.println("Place a finger");

        int nRes = p.UFS_CaptureSingleImage(hScanner[0]);

        if (nRes != 0) {
            System.out.println("Unable to capture fingerprint image. Error status: " + nRes);
            return null;
        }

        byte[] bTemplate = new byte[1024];

        int[] refTemplateSize = new int[1];
        int[] refTemplateQuality = new int[1];

        nRes = p.UFS_ExtractEx(hScanner[0], MAX_TEMPLATE_SIZE, bTemplate, refTemplateSize, refTemplateQuality);

        if (nRes == 0) {

            byte[] fgImage = drawCurrentFingerImage(fingerprintNumber);

            Fingerprint fingerprint = new Fingerprint(bTemplate, refTemplateSize[0], fgImage, 0);

            if (fingerprintNumber == 1) {
                fingerprintOne = fingerprint;
            } else if (fingerprintNumber == 2) {
                fingerprintTwo = fingerprint;
            }

            Patient patient = checkFingerprintIfExist(nRes, bTemplate, refTemplateSize, fingerprintNumber);
            if(patient == null){
                return new Object();
            }
            return patient;

        } else {
            System.out.println("extract template fail!! " + nRes);
            return null;
        }
    }

    private static Patient checkFingerprintIfExist(int nRes, byte[] bTemplate, int[] refTemplateSize, int fingerprintNumber) {
        Patient patient = null;

        p.UFM_IdentifyInit(hMatcher[0], bTemplate, refTemplateSize[0]);

//            try {
//                System.out.println(new String(bTemplate, "UTF-8"));
//            } catch (UnsupportedEncodingException ex) {
//                Logger.getLogger(FingerprintClass.class.getName()).log(Level.SEVERE, null, ex);
//            }
        int nMatchResult = 0;
        int[] refIdentifyRes = new int[1];
        int i = 0;

        ArrayList<Patient> patientList = FingerprintDAO.getFingerprints();

//        System.out.println("fg count: " + patientList.size());

        if (fingerprintNumber == 1 && fingerprintTwo != null) {

            nRes = p.UFM_IdentifyNext(hMatcher[0], fingerprintTwo.getFingerprintValue(), fingerprintTwo.getFingerprintSize(), refIdentifyRes);

            if (nRes == 0 && refIdentifyRes[0] == 1) {
                System.out.println(123);
                return new Patient();
            }

        } else if (fingerprintNumber == 2 && fingerprintOne != null) {

            nRes = p.UFM_IdentifyNext(hMatcher[0], fingerprintOne.getFingerprintValue(), fingerprintOne.getFingerprintSize(), refIdentifyRes);

            if (nRes == 0 && refIdentifyRes[0] == 1) {
                System.out.println(456);
                return new Patient();
            }
            
            System.out.println(789);
        }

        for (i = 0; i < patientList.size(); i++) {

            System.out.println("fgs: " + patientList.get(i).getFgSize());

            nRes = p.UFM_IdentifyNext(hMatcher[0], patientList.get(i).getFingerprint(), patientList.get(i).getFgSize(), refIdentifyRes);

            if (nRes == 0) {
                if (refIdentifyRes[0] == 1) {
//                        System.out.println("Identfy success!!  match index number:" + (i + 1));
                    System.out.println("Identify success!!  match index number:" + patientList.get(i).getPatientId());
                    nMatchResult = 1;
                    patient = patientList.get(i);
                    break;
                } else {

                }
            }
        }

        if (nMatchResult != 1) {
            System.out.println("Identify fail!!");
        }

        return patient;
    }

    public static void initalize() {

        if (nInitFlag != 0) {

            System.out.println("already init..");

            return;
        }

        nCaptureFlag = 0;

        int nRes = 0;

//        p = new BioMiniSDK();

        nRes = p.UFS_Init();

        if (nRes == p.UFS_OK) {

            nInitFlag = 1;

            System.out.println("UFS_Init() success!!");

            p.UFS_SetClassName("util.FingerprintClass");

            nRes = p.UFS_SetScannerCallback("scannerCallback");

            if (nRes == p.UFS_OK) {

                System.out.println("==>UFS_SetScannerCallback pScanProc ...");

                int[] refNumber = new int[1];
                nRes = p.UFS_GetScannerNumber(refNumber);

                if (nRes == p.UFS_OK) {
                    nScannerNumber = refNumber[0];
                    System.out.println("UFS_GetScannerNumber() scanner number :" + nScannerNumber);

                    nRes = p.UFM_Create(hMatcher);

                    if (nRes == 0) {

                        initArray(100, 1024); //array size,template size

                        p.UFM_SetTemplateType(hMatcher[0], p.UFM_TEMPLATE_TYPE_SUPREMA);

                    } else {

                        System.out.println("UFM_Create fail!! code :" + nRes);
                        return;
                    }
                } else {
                    System.out.println("GetScannerNumber fail!! code :" + nRes);
                    return;

                }
            } else {
                System.out.println("UFS_SetScannerCallback() fail,code :" + nRes);
            }

        } else {
            // UFS_Init is failed
            // Use UFS_GetErrorString method to show error string
            System.out.println("Init() fail!!");
            System.out.println("Init fail!! return code:" + nRes);
        }
    }

    public static BufferedImage currentNewFingerImage = null;
    public static byte[] fuck = null;

    public static byte[] drawCurrentFingerImage(int fingerprintNumber) {
        /*test draw image*/
        int[] Resolution = new int[1];
        int[] Height = new int[1];
        int[] Width = new int[1];
        long[] hScanner = new long[1];

        hScanner = GetCurrentScannerHandle();

        p.UFS_GetCaptureImageBufferInfo(hScanner[0], Width, Height, Resolution);

        byte[] pImageData = new byte[Width[0] * Height[0]];

        p.UFS_GetCaptureImageBuffer(hScanner[0], pImageData);

        // convert byte array back to BufferedImage
        BufferedImage buffImage = null;
        buffImage = new BufferedImage(Width[0],Height[0], BufferedImage.TYPE_BYTE_GRAY);
        buffImage.getRaster().setDataElements(0, 0, Width[0],Height[0], pImageData);
        currentNewFingerImage = buffImage;
        fuck = pImageData;

//        try {
//            ImageIO.write(buffImage, "bmp", new File("d:/fg-image/f"+fingerprintNumber+".bmp"));
//        } catch (IOException ex) {
//            Logger.getLogger(FingerprintClass.class.getName()).log(Level.SEVERE, null, ex);
//        }

        return pImageData;
    }

    public static long[] GetCurrentScannerHandle() {
        long[] hScanner = new long[1];
        int nRes = 0;
        int[] nNumber = new int[1];
        
        for(long i:hScanner){
            System.out.println("long i= " + i);
        }

        nRes = p.UFS_GetScannerNumber(nNumber);

        if (nRes == 0) {
            System.out.println("Succeeded in getting number of scanners");
            if (nNumber[0] <= 0) {
                System.out.println("nNumber[0]="+nNumber[0]);
                return null;
            }

        } else {

            return null;
        }

        nRes = p.UFS_GetScannerHandle(0, hScanner);
        
        System.out.println("hScanner is now: " + hScanner);
        if (nRes == 0 && hScanner != null) {
            return hScanner;
        }
        return null;
    }

    public static void clearFingerprints() {
        fingerprintOne = null;
        fingerprintTwo = null;
    }

    // Define scanner procedure
    public void scannerCallback(char[] szScannerID, int bSensorOn) {
        // ...
        
        System.out.println(szScannerID[0] + " 1   23yuturew");
        System.out.println("1   23yuturew");
    }

    public static void uninitialize() {
        int res = p.UFS_Uninit();
        nInitFlag = 0;
        System.out.println(res + "ggg");
    }
}
