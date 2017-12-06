/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import dao.ConnectionManager;
import dao.FingerprintDAO;
import dao.PatientDAO;
import dao.VisitDAO;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdk.nashorn.internal.runtime.Context;
import model.Patient;
import model.Visit;
import util.FingerprintClass;
import java.net.*;

/**
 *
 * @author tcw
 */
public class CreatePatientServlet2 extends HttpServlet {

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
            System.out.println("Started processRequest method...");
//            int patientID = Integer.parseInt(request.getParameter("patientID"));
            String village = request.getParameter("village");
            String name = request.getParameter("name");
            String contactNo = request.getParameter("contactNo");
            String gender = request.getParameter("gender");
            String dateOfBirth = request.getParameter("dateOfBirth");
            System.out.println(dateOfBirth);
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

            if (nullFingerprintJsonObject.get("oneNull") != null || nullFingerprintJsonObject.get("twoNull") != null) {
                out.print(gs.toJson(nullFingerprintJsonObject));
                out.close();
                return;
            }

            System.out.println("Creating patient obj...");
            Patient p = new Patient(village, 0, name, contactNo, gender, dateOfBirth, Integer.parseInt(travellingTimeToClinic), 0, null);
            System.out.println("Adding patient via DAO...");
            PatientDAO.addPatient(p);
            System.out.println("Setting fingerprints...");
            p.setFingerprintOne(FingerprintClass.fingerprintOne);
            p.setFingerprintTwo(FingerprintClass.fingerprintTwo);

            System.out.println("Adding fingerprints via DAO...");
            try {
                FingerprintDAO.addFingerprint(p.getPatientId(), p.getFingerprintOne().getFingerprintValue(), p.getFingerprintOne().getFingerprintSize(), p.getFingerprintOne().getFingerprintImage());
                FingerprintDAO.addFingerprint(p.getPatientId(), p.getFingerprintTwo().getFingerprintValue(), p.getFingerprintTwo().getFingerprintSize(), p.getFingerprintTwo().getFingerprintImage());
            } catch (Exception e) {
                System.out.println("fg error");
            }
            System.out.println("Done adding");
            if (photoImage != null) {
                System.out.println("Creating base64 string...");
                String imgOutgoing = "imgIncoming=" + photoImage.replace("data:image/jpeg;base64,", "").replace("+", "@") + "&patientID=" + p.getPatientId();
                ConnectionManager.sendImage(imgOutgoing);
            }
            System.out.println("Setting photo string");
            p.setPhotoImage(p.getVillage() + p.getPatientId() + ".png");

            System.out.println("Updating via patientDAO");
            PatientDAO.updateImage(p);

            System.out.println(p.getPatientId());
            System.out.println(village);
            System.out.println(name);
            System.out.println(gender);
            System.out.println(dateOfBirth);
//            System.out.println(photoImage.replace("data:image/jpeg;base64,", ""));
            VisitDAO visitDAO = new VisitDAO();
            System.out.println("Counting total visits...");
            int visitId = visitDAO.countTotalVisits() + 1;

            Date date = new Date();
            String visitDate = date.toString();
            System.out.println("Creating new Visit obj...");

            Visit visit = new Visit(visitId, p.getPatientId(), visitDate);
            System.out.println("Inserting data via DAO...");

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
