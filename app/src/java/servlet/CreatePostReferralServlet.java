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
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.PostReferral;
import model.Visit;

/**
 *
 * @author JunMing
 */
public class CreatePostReferralServlet extends HttpServlet {

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
        String visitID = request.getParameter("visitId");
        String postReferralDate = new Date().toString();
        String recorder = request.getParameter("recorder");
        String remarks = request.getParameter("remarks");

        int visitId = 0;
        String errorMsg = "";

        if (visitID != null) {
            try {
                visitId = Integer.parseInt(visitID);
            } catch (Exception e) {
                errorMsg = "Please select valid visitId";
            }
        }

        if (errorMsg.isEmpty()) {
            VisitDAO visitDAO = new VisitDAO();
            Visit visit = visitDAO.getVisitByVisitID(visitId);
            PostReferralDAO postReferralDao = new PostReferralDAO();
            boolean successful = postReferralDao.insertData(visitId, postReferralDate, recorder, remarks);
            System.out.println(successful);
            if (successful) {
                PostReferral postReferral = PostReferralDAO.getLatestPostReferralByVisitId(visitId);
                visit.setPostReferral(postReferral);
                request.getSession().setAttribute("visitRecord", visit);
                request.getSession().setAttribute("patientRecord", PatientDAO.getPatientByPatientID(visit.getPatientId()));
                request.getSession().setAttribute("successmsg", "A new post referral record is created");
                response.sendRedirect("new_postreferral.jsp");
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