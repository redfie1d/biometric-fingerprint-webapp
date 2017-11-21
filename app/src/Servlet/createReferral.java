/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import dao.ReferralDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Referral;
import model.Visit;

/**
 *
 * @author yu.fu.2015
 */
@WebServlet(name = "createReferral", urlPatterns = {"/createReferral"})
public class createReferral extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String visitID = request.getParameter("visitId");
            String condition = request.getParameter("condition");
            String test = request.getParameter("test");
            String parameters = request.getParameter("parameters");
            String remarks = request.getParameter("remarks");
            int visitId = 0;
            String errorMsg = "";
            if (visitID != null) {
                try {
                    visitId = Integer.parseInt(visitID);
                } catch (Exception e) {
                    errorMsg = "please enter valid visitId";
                }
            }
            if(errorMsg.isEmpty()){
                Referral referral = new Referral(visitId, condition, test, parameters, remarks);
                VisitDAO visitDAO = new VisitDAO();
                Visit visit = visitDAO.getVisitByVisitID(visitId);
                visit.setReferral(referral);
                ReferralDAO referralDAO = new ReferralDAO();
                boolean successful = referralDAO.insertData(visitId, condition, test, parameters, remarks);
                if(successful){
                    request.setAttribute("successMsg", "A new referral is created");
                    response.sendRedirect("referral.jsp");
                }
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
