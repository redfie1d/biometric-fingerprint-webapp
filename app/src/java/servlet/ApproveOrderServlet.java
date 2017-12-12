/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.InventoryDAO;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Order;

/**
 *
 * @author Kwtam
 */
@WebServlet(name = "ApproveOrderServlet", urlPatterns = {"/ApproveOrderServlet"})
public class ApproveOrderServlet extends HttpServlet {

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
        
        InventoryDAO inventoryDAO = new InventoryDAO();
        OrderDAO orderDAO = new OrderDAO();
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        ArrayList<Order> orderList = orderDAO.getOrdersByOrderID(orderID);
        
        if (request.getParameter("approve") != null) {
            boolean status = true;
            System.out.println("Pharmacy Approved OrderID: " + orderID);
            
            for(Order order:orderList){
                if(inventoryDAO.getDrugQuantity(order.getMedicine()) < order.getQuantity()){
                    status = false;
                }
                
            }
            
            if(status){
                for(Order order:orderList){
                    inventoryDAO.updateInventory(order);
                }
                
                System.out.println("Sufficient Quantity For All Orders");
                inventoryDAO.updateInventoryStatus(orderList.get(0).getOrderID());
                request.getSession().setAttribute("successmsg", "Request Approved");
            } else {
                System.out.println("Insufficient Quantity For Some/All Orders");
                request.getSession().setAttribute("errormsg", "Insufficient Quantity");
            }
        }
        
        if (request.getParameter("reject") != null) {
            System.out.println("Pharmacy Rejected OrderID: " + orderID);
            inventoryDAO.rejectOrders(orderID);
            System.out.println("Pharmacy Successfully Removed OrderID: " + orderID);
            request.getSession().setAttribute("successmsg", "Request Rejected");
        }
        
        if(request.getParameter("hide") != null){
            System.out.println("Pharmacy Hides OrderID: " + orderID);
            inventoryDAO.hideOrders(orderID);
            System.out.println("Pharmacy Successfully Hidden OrderID: " + orderID);
            request.getSession().setAttribute("successmsg", "Order Hidden");
        }
        
//        response.sendRedirect("pharmacy.jsp");
        
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
