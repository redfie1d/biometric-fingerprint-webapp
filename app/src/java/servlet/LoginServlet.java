/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author JunMing
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
        
        //Retrieve values from LoginUI
        String enteredUsername = request.getParameter("username");
        //String enteredUsername = "admin";
        String enteredPassword = request.getParameter("password");
        //String enteredPassword = "sabaisuper";
        HttpSession session = request.getSession();
        
        // Checking if username field is null or empty
        if (enteredUsername == null || enteredUsername.trim().equals("")) {
            request.setAttribute("errorMessage", "Please enter a username");
            RequestDispatcher view = request.getRequestDispatcher("LoginUI.jsp");
            view.forward(request, response);
        }

        // Checking if password field is null or empty
        if (enteredPassword == null || enteredPassword.trim().equals("")) {
            request.setAttribute("errorMessage", "Please enter a password");
            RequestDispatcher view = request.getRequestDispatcher("LoginUI.jsp");
            view.forward(request, response);
        }
        
        // Retrieve user object from userDAO given string enteredUsername
        UserDAO userDao = new UserDAO();
        User user = userDao.retrieve(enteredUsername);
        
        // user will be null if username is invalid
        if (user == null || !user.validateUser(enteredPassword)) {
            request.setAttribute("errorMessage", "Invalid username/password");
            RequestDispatcher view = request.getRequestDispatcher("LoginUI.jsp");
            view.forward(request, response);
        } else { // authentication success! Redirect to Home.jsp
            session.setAttribute("user", user);
            response.sendRedirect("index.jsp");
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
