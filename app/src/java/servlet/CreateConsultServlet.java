/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.ConsultDAO;
import dao.OrderDAO;
import dao.PatientDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Consult;
import model.Order;
import model.Visit;

/**
 *
 * @author tcw
 */
public class CreateConsultServlet extends HttpServlet {

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
        request.getSession().removeAttribute("savedDetails");
        if (request.getSession().getAttribute("savedDetails") == null) {
            System.out.println("IT IS WORKING");
        }

        OrderDAO orderDAO = new OrderDAO();

        String visitID = request.getParameter("visitId");
        String doctor = request.getParameter("doctor");
        String consultDetails = request.getParameter("consultDetails");
        String diagnosis = request.getParameter("diagnosis");
        String[] problems = request.getParameterValues("problems");

        String urine = request.getParameter("urine");
        String hemocue = request.getParameter("hemocue");
        String blood = request.getParameter("blood");
        String referrals = request.getParameter("referrals");
        String chronicReferral = request.getParameter("chronicReferral");

        String finalStringProblems = "";

        String[] medicines = request.getParameterValues("medicine");
        String[] quantities = request.getParameterValues("quantity");
        String[] notes = request.getParameterValues("notes");
        String[] remarks = request.getParameterValues("remarks");

        int visitId = 0;
        String errorMsg = "";

//            for(String quantity : quantities){
//                if(quantity.trim().equals("")){
//                    System.out.println("Doctor Input Blank Quantity");
//                    errorMsg = "Invalid Quantity";
//                }
//            }
        if (visitID != null) {
            try {
                visitId = Integer.parseInt(visitID);
            } catch (Exception e) {
                errorMsg = "Please enter valid visitId";
            }
        }

        if (errorMsg.isEmpty()) {
            if (problems != null && problems.length > 0) {
                for (int i = 0; i < problems.length; i++) {
                    finalStringProblems += problems[i];
                    if (i < problems.length - 1) {
                        finalStringProblems += ",";
                    }
                }

            }

            ConsultDAO consultDAO = new ConsultDAO();
            Consult consult = consultDAO.getConsultByVisitID(visitId);

            boolean successful = false;

            if (consult == null) {
                System.out.println("No Consult Record Found For Visit. Creating Consult Record...");
                boolean cRef = false;

                if (chronicReferral != null) {
                    cRef = true;
                }

                consult = new Consult(visitId, new Date().toString(), doctor, consultDetails, diagnosis, finalStringProblems, urine, hemocue, blood, referrals, cRef);

                VisitDAO visitDAO = new VisitDAO();
                Visit visit = visitDAO.getVisitByVisitID(visitId);
                visit.setConsult(consult);

                if (medicines != null) {
                    System.out.println("Placing Order For Medicines");
                    int orderID = orderDAO.getNextOrderID();
                    orderDAO.placeOrder(visitId);
                    for (int i = 0; i < medicines.length; i++) {
                        Order order = new Order(0, "Dr Pris", 100, medicines[i], Integer.parseInt(quantities[i]), notes[i], remarks[i]);
                        orderDAO.addOrders(orderID, order);
                    }
                    System.out.println("Successfully Ordered Medicines");
                }

                successful = consultDAO.insertData(visitId, doctor, consultDetails, diagnosis, finalStringProblems, urine, hemocue, blood, referrals, cRef);

                if (successful) {
                    System.out.println("New Consult Record Added");
                    request.getSession().setAttribute("visitRecord", visit);
                    request.getSession().setAttribute("patientRecord", PatientDAO.getPatientByPatientID(visit.getPatientId()));
                    request.getSession().setAttribute("successmsg", "A new consult record is created");
                }

            } else {
                System.out.println("Consult Record Already Exists");
                request.getSession().setAttribute("visitError", "Consult record already exists");
            }

            response.sendRedirect("new_consult.jsp");

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
