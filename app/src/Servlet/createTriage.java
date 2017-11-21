/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import dao.TriageDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Triage;
import model.Visit;

/**
 *
 * @author yu.fu.2015
 */
@WebServlet(name = "createTriage", urlPatterns = {"/createTriage"})
public class createTriage extends HttpServlet {

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
            int visitId = 0;
            double height = 0.0;
            double weight = 0.0;
            double systolic = 0.0;
            double diastolic = 0.0;
            TriageDAO triageDAO = new TriageDAO();
            ArrayList<String> errors = new ArrayList<>();
            VisitDAO visitDAO = new VisitDAO();
            String visitID = request.getParameter("visitId");
            String heightS = request.getParameter("height");
            String weightS = request.getParameter("weight");
            String systolicS = request.getParameter("systolic");
            String diastolicS = request.getParameter("diastolic");
            if (visitID != null) {
                try {
                    visitId = Integer.parseInt(visitID);
                } catch (Exception e) {
                    errors.add("please enter valid visitId");
                }
            }
            if (heightS != null) {
                try {
                    height = Integer.parseInt(heightS);
                } catch (Exception e) {
                    errors.add("please enter valid height");
                }
            }
            if (weightS != null) {
                try {
                    weight = Integer.parseInt(weightS);
                } catch (Exception e) {
                    errors.add("please enter valid weight");
                }
            }
            if (systolicS != null) {
                try {
                    systolic = Integer.parseInt(systolicS);
                } catch (Exception e) {
                    errors.add("please enter valid systolic");
                }
            }
            if (diastolicS != null) {
                try {
                    diastolic = Integer.parseInt(diastolicS);
                } catch (Exception e) {
                    errors.add("please enter valid diastolic");
                }
            }
            if(errors.size()==0){
                Triage triage = new Triage(visitId,height,weight,systolic,diastolic);
                Visit visit = visitDAO.getVisitByVisitID(visitId);
                visit.setTriage(triage);
                boolean successful = triageDAO.insertData(visitId, height, weight, systolic, diastolic);
                if(successful){
                    request.setAttribute("successMsg", "A new triage is created");
                    response.sendRedirect("triage.jsp");
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
