/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.PatientDAO;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Base64;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Patient;

/**
 *
 * @author JunMing
 */
@WebServlet(name = "UpdatePatientServlet", urlPatterns = {"/UpdatePatientServlet"})
public class UpdatePatientServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            boolean patientCorrect = false;
            boolean photoCorrect = false;
            
            String village = request.getParameter("village");
            int patientId = Integer.parseInt(request.getParameter("patientId"));
            String name = request.getParameter("name");
            String contactNo = request.getParameter("contactNo");
            String dateOfBirth = request.getParameter("dateOfBirth");
            String travellingTimeToClinic = request.getParameter("travellingTimeToClinic");
            String photoImage = request.getParameter("photoImage");

            String imageString = village + patientId + ".png";
            
            System.out.println(village);
            System.out.println(patientId);
            System.out.println(name);
            System.out.println(contactNo);
            System.out.println(dateOfBirth);
            System.out.println(travellingTimeToClinic);
            System.out.println(photoImage);
            System.out.println(imageString);

            if (!photoImage.equals("default")) {

                byte[] photoImageByte = Base64.getDecoder().decode(photoImage.replace("data:image/jpeg;base64,", ""));

                ServletContext servletContext = this.getServletConfig().getServletContext();
                System.out.println("contextPath = " + servletContext.getContextPath());
                System.out.println("RealPath = " + servletContext.getRealPath("/"));
                System.out.println("user.dir = " + System.getProperty("user.dir"));

//                try (OutputStream stream = new FileOutputStream(new File(servletContext.getRealPath("/") + "../../web/patient-images/" + imageString), false)) {
//                    stream.write(photoImageByte);
//                    System.out.println("Write to patient-images successful");
//                }
                
                try (OutputStream stream = new FileOutputStream(new File("\\\\JM-ASUS-LAPTOP\\patient-images\\" + imageString), false)) {
                    stream.write(photoImageByte);
                    System.out.println("Write to patient-images successful");
                }
            }
            
            boolean updateSuccessful = PatientDAO.updatePatientDetails(patientId, village, name, imageString, contactNo, Integer.parseInt(travellingTimeToClinic), dateOfBirth);
            
            if (updateSuccessful) {
                System.out.println("successfully update patient details");
                Patient patientRecord = PatientDAO.getPatientByPatientID(village, patientId);
                session.setAttribute("patientRecord", patientRecord);
            } else {
                System.out.println("Patient details are not updated");
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
