/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ConsultDAO;
import dao.PatientDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Consult;
import model.Visit;

/**
 *
 * @author tcw
 */
public class UpdateConsultServlet extends HttpServlet {

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
//            String visitID = request.getParameter("visitId");
//            String doctor = request.getParameter("doctor");
//            String notes = request.getParameter("notes");
//            String diagnosis = request.getParameter("diagnosis");
//            String [] problems = request.getParameterValues("problems");
//            
//            String urine = request.getParameter("urine");
//            String hemocue = request.getParameter("hemocue");
//            String blood = request.getParameter("blood");
//            String referrals = request.getParameter("referrals");
//            
//            String finalStringProblems = "";
//            
//            int visitId = 0;
//            String errorMsg = "";
//            
//            if (visitID != null) {
//                try {
//                    visitId = Integer.parseInt(visitID);
//                } catch (Exception e) {
//                    errorMsg = "Please enter valid visitId";
//                }
//            }
//            
//            if(errorMsg.isEmpty()){
//                if (problems != null && problems.length > 0){
//                    for (int i=0; i<problems.length;i++){
//                        finalStringProblems += problems[i];
//                        if (i < problems.length -1 ){
//                           finalStringProblems += ",";
//                        }
//                    }
//                }
//                int currentConsultID = ConsultDAO.getConsultByVisitID(visitId).getConsult_id();
//                Consult consult = new Consult(visitId, doctor, notes, diagnosis, finalStringProblems, urine, hemocue, blood, referrals);
//                Visit visit = VisitDAO.getVisitByVisitID(visitId);
//                visit.setConsult(consult);
//                ConsultDAO consultDAO = new ConsultDAO();
//                boolean successful = consultDAO.updateData(currentConsultID, visitId, doctor, notes, diagnosis, finalStringProblems, urine, hemocue, blood, referrals);
//                if(successful){
//                    request.getSession().setAttribute("visitRecord", visit);
//                    request.getSession().setAttribute("patientRecord", PatientDAO.getPatientByPatientID(visit.getPatientId()));
//                    request.getSession().setAttribute("successmsg", "Consult record has been updated");
////                    RequestDispatcher dispatcher = request.getRequestDispatcher("createTriage.jsp");
////                    dispatcher.forward(request, response);
//                    
//                    response.sendRedirect("new_consult.jsp");
//                }
//            }
        
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

