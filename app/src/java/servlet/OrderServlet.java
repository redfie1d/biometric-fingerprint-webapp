/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.InventoryDAO;
import dao.OrderDAO;
import dao.PatientDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Drug;
import model.Order;
import model.Visit;

/**
 *
 * @author Kwtam
 */
//@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

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
        
        OrderDAO orderDAO = new OrderDAO();

        String visitID = request.getParameter("visitId");
        
        String[] medicines = request.getParameterValues("medicine");
        String[] quantities = request.getParameterValues("quantity");
        String[] notes = request.getParameterValues("notes");
        String[] remarks = request.getParameterValues("remarks");
        
        int visitId = -1;
        String errorMsg = "";
        
        for(String quantity : quantities){
            if(quantity.trim().equals("")){
                System.out.println("Doctor Input Blank Quantity");
                errorMsg = "Invalid Quantity";
            }
        }
        
        if (visitID != null) {
            try {
                visitId = Integer.parseInt(visitID);
            } catch (Exception e) {
                System.out.println("Failed To Get VisitID");
                errorMsg = "Failed To Get VisitID";
            }
        }
        
        int orderID = orderDAO.getNextOrderID();
        orderDAO.placeOrder(visitId);
        for(int i=0; i<medicines.length; i++){
            Order order = new Order(0,"Dr Pris", 100, medicines[i], Integer.parseInt(quantities[i]), notes[i], remarks[i]);
            orderDAO.addOrders(orderID, order);
        }
        
        if(errorMsg.isEmpty()){
            Visit visit = VisitDAO.getVisitByVisitID(visitId);
            request.getSession().setAttribute("visitRecord", visit);
            request.getSession().setAttribute("patientRecord", PatientDAO.getPatientByPatientID(visit.getPatientId()));
            request.getSession().setAttribute("successmsg", "Successfully ordered medicine(s)");
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
