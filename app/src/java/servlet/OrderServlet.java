/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.InventoryDAO;
import dao.OrderDAO;
import dao.PatientDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Order;

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
        
//        HttpSession session = request.getSession();
        OrderDAO orderDAO = new OrderDAO();
        InventoryDAO inventoryDAO = new InventoryDAO();
        ArrayList<String> errors = new ArrayList<>();

        String orderID = request.getParameter("orderID");
        String doctor = request.getParameter("doctor");
        String medicine = request.getParameter("medicine");
        String qty = request.getParameter("quantity");
        
        int quantity = 0;
        
        if(qty != null){
            quantity = Integer.parseInt(qty);
        }
        
        System.out.println("orderid"+orderID);

        if(orderID == null){
            orderDAO.placeOrder(doctor, medicine, quantity);

            response.sendRedirect("new_consult.jsp");
        } else {
            int orderNo = Integer.parseInt(orderID);
            int currentQty = inventoryDAO.getDrugQuantity(medicine);
            System.out.println("Current"+currentQty);
            System.out.println("Requested"+quantity);
            if(currentQty < quantity){
                errors.add("Insufficient Quantity");
                request.getSession().setAttribute("errormsg", "Insufficient Quantity");
            } else {
                orderDAO.removeOrder(orderNo);
                boolean status = inventoryDAO.updateInventory(medicine, currentQty - quantity);
                System.out.println(status);
                request.getSession().setAttribute("successmsg", "Order has been approved");
            }
            
            
            response.sendRedirect("pharmacy.jsp");
        }
        
        

        
//        request.getSession().setAttribute("visitRecord", visit);
//                    request.getSession().setAttribute("patientRecord", PatientDAO.getPatientByPatientID(visit.getPatientId()));
//                    request.getSession().setAttribute("successmsg", "Consult record has been updated");
        
        
        
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet OrderServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//            
////            session.setAttribute("", );
////            session.setAttribute("patientRecord", p);
//            System.out.println("helloehheloo");
//        }
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
        System.out.println("doingpost");
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
