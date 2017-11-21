/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import dao.PatientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Patient;
import util.FingerprintClass;

/**
 *
 * @author tcw
 */
public class IdentifyFingerprintServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        FingerprintClass.initalize();
        Patient patient = FingerprintClass.identify(Integer.parseInt(request.getParameter("fingerprintNumber")));

        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        if (patient != null) {
            patient = PatientDAO.getPatientByPatientID(patient.getPatientId());
//            patient.setFgImage(null);
//            patient.setFingerprint(new byte[0]);
//            patient.setFgImage(FingerprintClass.currentNewFingerImage);
            String jsonString = gson.toJson(patient);
            
//            System.out.println(jsonString);

            JsonObject sucObject = new JsonObject();
            sucObject.addProperty("status", "success");
            sucObject.addProperty("msg", jsonString);
            


//            ByteArrayOutputStream os = new ByteArrayOutputStream();
//            OutputStream b64 = new BASE64EncoderStream(os);
//            ImageIO.write(FingerprintClass.currentNewFingerImage, "bmp", b64);
//            String result = os.toString("UTF-8");
//            System.out.println(result);

//            String fgImageStr = Base64.getEncoder().encodeToString(FingerprintClass.fuck);
//            sucObject.addProperty("img", fgImageStr);
            
//            System.out.println(fgImageStr);
            
            try (PrintWriter out = response.getWriter()) {
                out.print(new Gson().toJson(sucObject));
            }

        } else {
            JsonObject errObject = new JsonObject();
            errObject.addProperty("status", "error");
            errObject.addProperty("msg", "no patient identified");
            
//            ByteArrayOutputStream os = new ByteArrayOutputStream();
//            OutputStream b64 = new BASE64EncoderStream(os);
//            ImageIO.write(FingerprintClass.currentNewFingerImage, "bmp", b64);
//            String result = os.toString("UTF-8");
//            System.out.println(result);
            
            
//            String fgImageStr = Base64.getEncoder().encodeToString(FingerprintClass.fuck);
//            errObject.addProperty("img", fgImageStr);
//            System.out.println(fgImageStr);

            try (PrintWriter out = response.getWriter()) {
                out.print(gson.toJson(errObject));
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
