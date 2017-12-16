/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import model.Consult;
import model.Vitals;
import model.Visit;

/**
 *
 * @author yu.fu.2015
 */
public class ConsultDAO {
    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;
    
    public boolean insertData(int visitId, String doctor, String notes, String diagnosis, String problems, String urine_test, String hemocue_count, String blood_glucose, String referrals, boolean chronic_referral){
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO consults(visit_id, date, doctor, notes, diagnosis, problems, urine_test, "
                    + "hemocue_count, blood_glucose, referrals, chronic_referral) values(?,?,?,?,?,?,?,?,?,?,?)");
            
            Date d = new Date();            
            
            stmt.setInt(1, visitId);
            stmt.setString(2, d.toString());
            stmt.setString(3, doctor);
            stmt.setString(4, notes);
            stmt.setString(5, diagnosis);
            stmt.setString(6, problems);
            stmt.setString(7, urine_test);
            stmt.setString(8, hemocue_count);
            stmt.setString(9, blood_glucose);
            stmt.setString(10, referrals);
            stmt.setBoolean(11, chronic_referral);
            stmt.executeUpdate();
            
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }
    
    public boolean updateData(int consultId, int visitId, String doctor, String notes, String diagnosis, String problems, String urine_test, String hemocue_count, String blood_glucose, String referrals){
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("UPDATE consults SET visit_id = ?, date = ?, doctor = ?, notes = ?, diagnosis = ?, problems = ?, urine_test = ?, "
                    + "hemocue_count = ?, blood_glucose = ?, referrals = ? WHERE consult_id = ?");
            
            Date d = new Date();            
            
            stmt.setInt(1, visitId);
            //stmt.setString(2, new SimpleDateFormat("dd/mm/yyyy").format(d));
            stmt.setString(2, d.toString());
            stmt.setString(3, doctor);
            stmt.setString(4, notes);
            stmt.setString(5, diagnosis);
            stmt.setString(6, problems);
            stmt.setString(7, urine_test);
            stmt.setString(8, hemocue_count);
            stmt.setString(9, blood_glucose);
            stmt.setString(10, referrals);
            stmt.setInt(11, consultId);
            stmt.executeUpdate();
            
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }
    
    public static Consult getConsultByVisitID(int visitId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from consults where visit_id = ?");
            stmt.setInt(1, visitId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int consultId = rs.getInt("consult_id");
                String date = rs.getString("date");
                String doctor = rs.getString("doctor");
                String notes = rs.getString("notes");
                String diagnosis = rs.getString("diagnosis");
                String problems = rs.getString("problems");
                String urine_test = rs.getString("urine_test");
                String hemocue_count = rs.getString("hemocue_count");
                String blood_glucose = rs.getString("blood_glucose");
                String referrals = rs.getString("referrals");
                boolean chronic_referral = rs.getBoolean("chronic_referral");
                
                return new Consult(consultId, visitId, date, doctor, notes, diagnosis, problems, urine_test, hemocue_count, blood_glucose, referrals, chronic_referral);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static ArrayList<String> getSummaryOfProblems() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<String> problems = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select problems from consults");
            rs = stmt.executeQuery();

            while (rs.next()) {
                String problemString = rs.getString("problems");
                problems.add(problemString);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return problems;
    }
}
