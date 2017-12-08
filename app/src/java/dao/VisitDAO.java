/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author yu.fu.2015
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import model.Consult;
import model.PostReferral;
import model.Vitals;
import model.Visit;

public class VisitDAO {

    public static Visit getPatientLatestVisit(int patientID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();

            stmt = conn.prepareStatement("SELECT * FROM visits WHERE patient_id = ? and id = (select max(id) from visits where patient_id = ?)");
            
//            stmt = conn.prepareStatement("Select * from visits where patient_id = ? and status = 'started'");
            stmt.setInt(1, patientID);
            stmt.setInt(2, patientID);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                
                int visitID = rs.getInt("id");
                String date = rs.getString("date");
                Vitals t = VitalsDAO.getDataByVisitID(visitID);
                Consult c = ConsultDAO.getConsultByVisitID(visitID);
                PostReferral r = null;
                return new Visit(visitID, patientID, date, t, c, r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }

    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public int countTotalVisits() {
        int numOfTotalVisits = 0;
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select max(id) from visits");
            rs = stmt.executeQuery();
            if (rs.next()) {
                numOfTotalVisits = rs.getInt(1);
            }

            return numOfTotalVisits;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return 0;
    }

    public static Visit getLatestVisitByPatientID(int patientID) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from visits where patient_id = ? and status = 'started'");
            stmt.setInt(1, patientID);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return new Visit(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }

    public static Visit getVisitByVisitID(int visitId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from visits v where v.id = ?");
            stmt.setInt(1, visitId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int visitID = rs.getInt("id");
                String date = rs.getString("date");
                int patientID = rs.getInt("patient_id");
                Vitals t = VitalsDAO.getDataByVisitID(visitID);
                Consult c = ConsultDAO.getConsultByVisitID(visitID);
                PostReferral r = null;
                return new Visit(visitID, patientID, date, t, c, r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }

    public static Visit[] getVisitByPatientID(int patientId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Visit> visitList = new ArrayList();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from visits where patient_id = ?");
            stmt.setInt(1, patientId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int visitId = rs.getInt("id");
                String date = rs.getString("date");
                String status = rs.getString("status");
                Vitals triage = VitalsDAO.getDataByVisitID(visitId);
                visitList.add(new Visit(visitId, patientId, date, triage, status));
            }
            //Returns the converted array to the caller of method
            return visitList.toArray(new Visit[0]);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }

    public boolean insertData(int visitId, int patientId, String date) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO visits values(?,?,?,?)");
            stmt.setInt(1, visitId);
            stmt.setInt(2, patientId);
            stmt.setString(3, date);
            stmt.setString(4, "started");

            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }
}
