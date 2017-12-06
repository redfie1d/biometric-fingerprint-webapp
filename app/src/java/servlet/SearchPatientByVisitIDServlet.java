/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.PatientDAO;
import dao.PostReferralDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Patient;
import model.PostReferral;
import model.Visit;

/**
 *
 * @author tcw
 */
public class SearchPatientByVisitIDServlet extends HttpServlet {

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

        /* TODO output your page here. You may use following sample code. */
        HttpSession session = request.getSession();
        
        // Request Parameters
        String source = request.getParameter("source");
        String patientIdInput = request.getParameter("patientID");
        int visitIdInput = 0;
        try {
            visitIdInput = Integer.parseInt(request.getParameter("visitID"));
        } catch (Exception e) {
        }

        
        String pVillage = "";
        int pNo = -1;
        
        // Check patientIdInput
        if (patientIdInput == null || patientIdInput.length() < 4) {
            session.setAttribute("visitError", "Patient/Visit not found!");
            if (source.equals("consult")) {
                response.sendRedirect("new_consult.jsp");
            } else if (source.equals("postreferral")) {
                response.sendRedirect("new_postreferral.jsp");
            } else {
                response.sendRedirect("new_vitals.jsp");
            }
            return;
        }

        pVillage = patientIdInput.substring(0, 3);
        try {
            pNo = Integer.parseInt(patientIdInput.substring(3));
        } catch (Exception e) {

        }

        if (pNo == -1) {
            session.setAttribute("visitError", "Patient/Visit not found!");
            if (source.equals("consult")) {
                response.sendRedirect("new_consult.jsp");
            } else if (source.equals("postreferral")) {
                response.sendRedirect("new_postreferral.jsp");
            } else {
                response.sendRedirect("new_vitals.jsp");
            }
            return;
        }

        Patient p = PatientDAO.getPatientByPatientID(pVillage, pNo);

        if (p == null) {
            session.setAttribute("visitError", "Patient/Visit not found!");
            if (source.equals("consult")) {
                response.sendRedirect("new_consult.jsp");
            } else if (source.equals("postreferral")) {
                response.sendRedirect("new_postreferral.jsp");
            } else {
                response.sendRedirect("new_vitals.jsp");
            }
            return;
        }
        
        Visit v = VisitDAO.getVisitByVisitID(visitIdInput);
        
        // If visit record exist
        if (v != null) {
            session.setAttribute("viewPastConsultRecord", true);
            
            if (request.getParameter("postReferralID") != null) {
                PostReferral postReferral = PostReferralDAO.getPostReferralByPostReferralId(Integer.parseInt(request.getParameter("postReferralID")));
                
                if (postReferral != null) {
                    v.setPostReferral(postReferral);
                }
                
                session.setAttribute("viewPastPostReferral", true);
            } else {
                session.setAttribute("viewPastPostReferral", false);
            }

            if (source.equals("consult")) {
                Visit[] pastVisits = VisitDAO.getVisitByPatientID(p.getPatientId());
                session.setAttribute("pastVisits", pastVisits);
                response.sendRedirect("new_consult.jsp");
            } else if (source.equals("postreferral")) {
                Visit[] pastVisits = VisitDAO.getVisitByPatientID(p.getPatientId());
                session.setAttribute("pastVisits", pastVisits);
                response.sendRedirect("new_postreferral.jsp");
            } else {
                response.sendRedirect("new_vitals.jsp");
            }
            
            session.setAttribute("visitRecord", v);
            session.setAttribute("patientRecord", p);

        } else {
            session.setAttribute("visitError", "Patient/Visit not found!");
            if (source.equals("consult")) {
                response.sendRedirect("new_consult.jsp");
            } else if (source.equals("postreferral")) {
                response.sendRedirect("new_postreferral.jsp");
            } else {
                response.sendRedirect("new_vitals.jsp");
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
