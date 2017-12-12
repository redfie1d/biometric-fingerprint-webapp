/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import dao.FingerprintDAO;
import dao.PatientDAO;
import dao.VisitDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Date;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Patient;
import model.Visit;
import util.FingerprintClass;

/**
 *
 * @author tcw
 */
public class CreatePatientServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {

            boolean patientCorrect = false;
            boolean fingerprintCorrect = false;
            boolean visitCorrect = false;
            boolean photoCorrect = false;

//            int patientID = Integer.parseInt(request.getParameter("patientID"));
            String village = request.getParameter("village");
            String name = request.getParameter("name");
            String contactNo = request.getParameter("contactNo");
            String gender = request.getParameter("gender");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String travellingTimeToClinic = request.getParameter("travellingTimeToClinic");
            String photoImage = request.getParameter("photoImage");

            Gson gs = new GsonBuilder().setPrettyPrinting().create();

            JsonObject nullFingerprintJsonObject = new JsonObject();
            nullFingerprintJsonObject.addProperty("status", "null");

            if (FingerprintClass.fingerprintOne == null) {
                nullFingerprintJsonObject.addProperty("oneNull", "fingerprint one is null");
            }

            if (FingerprintClass.fingerprintTwo == null) {
                nullFingerprintJsonObject.addProperty("twoNull", "fingerprint two is null");
            }

//                nullFingerprintJsonObject.addProperty("oneNull", "fingerprint one is null");
//                nullFingerprintJsonObject.addProperty("twoNull", "fingerprint two is null");
            if (nullFingerprintJsonObject.get("oneNull") != null || nullFingerprintJsonObject.get("twoNull") != null) {
                out.print(gs.toJson(nullFingerprintJsonObject));
                out.close();
                return;
            }

            Patient p = new Patient(village, 0, name, contactNo, gender, dateOfBirth, Integer.parseInt(travellingTimeToClinic), 0, null);

            PatientDAO.addPatient(p);

            patientCorrect = true;

            p.setFingerprintOne(FingerprintClass.fingerprintOne);
            p.setFingerprintTwo(FingerprintClass.fingerprintTwo);

            try {
                FingerprintDAO.addFingerprint(p.getPatientId(), p.getFingerprintOne().getFingerprintValue(), p.getFingerprintOne().getFingerprintSize(), p.getFingerprintOne().getFingerprintImage());
                FingerprintDAO.addFingerprint(p.getPatientId(), p.getFingerprintTwo().getFingerprintValue(), p.getFingerprintTwo().getFingerprintSize(), p.getFingerprintTwo().getFingerprintImage());
                fingerprintCorrect = true;
            } catch (Exception e) {
                System.out.println("fg error");
            }

            if (photoImage != null) {

                byte[] photoImageByte = Base64.getDecoder().decode(photoImage.replace("data:image/jpeg;base64,", ""));

                ServletContext servletContext = this.getServletConfig().getServletContext();
                System.out.println("contextPath = " + servletContext.getContextPath());
                System.out.println("RealPath = " + servletContext.getRealPath("/"));
                System.out.println("user.dir = " + System.getProperty("user.dir"));

//                try (OutputStream stream = new FileOutputStream(new File(servletContext.getRealPath("/") + "../../web/patient-images/" + p.getVillage() + p.getPatientId() + ".png"))) {
//                    stream.write(photoImageByte);
//                }

                try (OutputStream stream = new FileOutputStream(new File("\\\\JM-ASUS-LAPTOP\\patient-images\\" + p.getVillage() + p.getPatientId() + ".png"))) {
                    stream.write(photoImageByte);
                }
            }

            p.setPhotoImage(p.getVillage() + p.getPatientId() + ".png");

            PatientDAO.updateImage(p);

            photoCorrect = true;

            System.out.println(p.getPatientId());
            System.out.println(village);
            System.out.println(name);
            System.out.println(gender);
            System.out.println(dateOfBirth);
//            System.out.println(photoImage.replace("data:image/jpeg;base64,", ""));

            VisitDAO visitDAO = new VisitDAO();

            int visitId = visitDAO.countTotalVisits() + 1;
            System.out.println(visitId);
            Date date = new Date();
            String visitDate = date.toString();

            Visit visit = new Visit(visitId, p.getPatientId(), visitDate);
            boolean successful = visitDAO.insertData(visitId, p.getPatientId(), visitDate);
            if (successful) {
                System.out.println("successful registered patient and created a new visit");
            }

            JsonObject jo = new JsonObject();
            jo.addProperty("status", "success");
            jo.addProperty("newID", p.getVillage() + p.getPatientId());
            out.print(gs.toJson(jo));
            out.close();
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
