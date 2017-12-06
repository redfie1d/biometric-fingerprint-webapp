/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.PatientDAO;
import dao.VisitDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Patient;
import model.Visit;

/**
 *
 * @author tcw
 */
public class SearchPatientServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String inputPatientID = request.getParameter("patientID");

        String pVillage;
        int pNo = -1;

        if (inputPatientID == null || inputPatientID.length() < 4) {
            session.setAttribute("searchError", "Patient not found!");
            response.sendRedirect("existing_patient.jsp");
            return;
        }

        pVillage = inputPatientID.substring(0, 3);
        try {
            pNo = Integer.parseInt(inputPatientID.substring(3));
        } catch (Exception e) {

        }

        if (pNo == -1) {
            session.setAttribute("searchError", "Patient not found!");
            response.sendRedirect("existing_patient.jsp");
            return;
        }

        Patient p = PatientDAO.getPatientByPatientID(pVillage, pNo);

        if (p == null) {
            session.setAttribute("searchError", "Patient not found!");
            response.sendRedirect("existing_patient.jsp");
            return;
        }

        Visit v = VisitDAO.getPatientLatestVisit(p.getPatientId());

        if (v != null) {

            session.setAttribute("visitRecord", v);
            session.setAttribute("patientRecord", p);

            Visit[] pastVisits = VisitDAO.getVisitByPatientID(p.getPatientId());
            session.setAttribute("pastVisits", pastVisits);

        } else {
            session.setAttribute("searchError", "Patient not found!");
            System.out.println("1235467870");
        }
        response.sendRedirect("existing_patient.jsp");
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
