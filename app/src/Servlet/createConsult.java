/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import dao.ConsultDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Consult;
import model.Visit;

/**
 *
 * @author yu.fu.2015
 */
@WebServlet(name = "createConsult", urlPatterns = {"/createConsult"})
public class createConsult extends HttpServlet {

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
            String doctor = request.getParameter("doctor");
            String notes = request.getParameter("notes");
            String diagnosis = request.getParameter("diagnosis");
            String problems = request.getParameter("problems");
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
                Consult consult = new Consult(visitId, doctor, notes, diagnosis, problems);
                VisitDAO visitDAO = new VisitDAO();
                Visit visit = visitDAO.getVisitByVisitID(visitId);
                visit.setConsult(consult);
                ConsultDAO consultDAO = new ConsultDAO();
                boolean successful = consultDAO.insertData(visitId, doctor, notes, diagnosis, problems);
                if(successful){
                    request.setAttribute("successMsg", "A new consult record is created");
                    response.sendRedirect("consult.jsp");
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
