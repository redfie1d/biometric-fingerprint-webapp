/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.VitalsDAO;
import dao.VisitDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Vitals;
import model.Visit;

/**
 *
 * @author tcw
 */
public class CreateVitalsServlet extends HttpServlet {

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
        int visitId = 0;
        double height = 0.0;
        double weight = 0.0;
        double systolic = 0.0;
        double diastolic = 0.0;
        double temperature = 0.0;
        int hivPositive = 0;
        int ptbPositive = 0;
        int hepCPositive = 0;

        VitalsDAO vitalsDao = new VitalsDAO();
        ArrayList<String> errors = new ArrayList<>();
        VisitDAO visitDAO = new VisitDAO();

        String visitID = request.getParameter("visitId");
        String heightS = request.getParameter("height");
        String weightS = request.getParameter("weight");
        String systolicS = request.getParameter("systolic");
        String diastolicS = request.getParameter("diastolic");
        String temperatureS = request.getParameter("temperature");
        String hivPositiveS = request.getParameter("hivPositive");
        String ptbPositiveS = request.getParameter("ptbPositive");
        String hepCPositiveS = request.getParameter("hepCPositive");

//        try (PrintWriter out = response.getWriter()) {
//            out.println(visitID);
//            out.println(heightS);
//            out.println(weightS);
//            out.println(systolicS);
//            out.println(diastolicS);
//            out.println(temperature);
//            out.println(hivPositive);
//            out.println(ptbPositive);
//        }
////
//        if (1 == 1) {
//            return;
//        }
//        visitID = "1";
//        heightS = "2";
//        weightS = "3";
//        systolicS = "4";
//        diastolicS = "5";
        if (visitID != null) {
            try {
                visitId = Integer.parseInt(visitID);
            } catch (Exception e) {
                errors.add("Something went wrong, pleas try again (invalid visitID)");
            }
        }

        if (heightS != null && heightS.length() != 0) {
            try {
                height = Double.parseDouble(heightS);
            } catch (Exception e) {
                errors.add("Please enter valid height");
            }
        } else {
            errors.add("Please enter a valid height");
        }

        if (weightS != null && weightS.length() != 0) {
            try {
                weight = Double.parseDouble(weightS);
            } catch (Exception e) {
                errors.add("Please enter valid weight");
            }
        } else {
            errors.add("Please enter a valid weight");
        }

        if (systolicS != null && systolicS.length() != 0) {
            try {
                systolic = Integer.parseInt(systolicS);
            } catch (Exception e) {
                errors.add("Please enter valid systolic");
            }
        } else {
            errors.add("Please enter a valid systolic");
        }

        if (diastolicS != null && diastolicS.length() != 0) {
            try {
                diastolic = Integer.parseInt(diastolicS);
            } catch (Exception e) {
                errors.add("Please enter valid diastolic");
            }
        } else {
            errors.add("Please enter a valid diastolic");
        }

        if (temperatureS != null && temperatureS.length() != 0) {
            try {
                temperature = Double.parseDouble(temperatureS);
            } catch (Exception e) {
                errors.add("Please enter valid temeperature");
            }
        } else {
            errors.add("Please enter a valid temeperature");
        }

        if (hivPositiveS != null) {
            hivPositive = 1;
        }
        if (ptbPositiveS != null) {
            ptbPositive = 1;
        }
        if (hepCPositiveS != null) {
            hepCPositive = 1;
        }

        HttpSession session = request.getSession();

        if (errors.isEmpty()) {
            Vitals vitals = new Vitals(visitId, height, weight, systolic, diastolic, temperature, hivPositive, ptbPositive, hepCPositive);
            Visit visit = VisitDAO.getVisitByVisitID(visitId);
            visit.setVitals(vitals);
            boolean successful = vitalsDao.insertData(visitId, height, weight, systolic, diastolic, temperature, hivPositive, ptbPositive, hepCPositive);
            int update = -1;
            try {
                update = Integer.parseInt(request.getParameter("update"));
            } catch (Exception e) {
            }

            if (successful) {
                if (update == 0) {
                    session.setAttribute("msg", "A new vitals is created");
                } else if (update == 1) {
                    session.setAttribute("msg", "Vitals record has been updated");

                }
//                if (session.getAttribute("visitRecord") != null){
//                  session.setAttribute("visitRecord", visit);
//                }
//                
//                if (session.getAttribute("patientRecord") != null){
//                  session.setAttribute("patientRecord", patient);
//                }
                response.sendRedirect("new_vitals.jsp");
            } else {
                session.setAttribute("errorMsg", errors);
                response.sendRedirect("new_vitals.jsp");
            }
        } else {
            session.setAttribute("errorMsg", errors);
            response.sendRedirect("new_vitals.jsp");
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
