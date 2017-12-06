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
import java.util.ArrayList;
import model.PostReferral;
import model.Vitals;
import model.Visit;

/**
 *
 * @author JunMing
 */
public class PostReferralDAO {

    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public boolean insertData(int visitId, String date, String recorder, String remarks) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO postreferrals values(NULL,?,?,?,?)");

            stmt.setInt(1, visitId);
            stmt.setString(2, date);
            stmt.setString(3, recorder);
            stmt.setString(4, remarks);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }
    
    public static PostReferral[] getPostReferralsByPatientId(int patientId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<PostReferral> postReferralList = new ArrayList();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM postreferrals p inner join visits v on p.visit_id = v.id and patient_id = ?");
            stmt.setInt(1, patientId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int postReferralId = rs.getInt("postreferral_id");
                int visitId = rs.getInt("visit_id");
                String date = rs.getString("date");
                String recorder = rs.getString("recorder");
                String remarks = rs.getString("remarks");
                postReferralList.add(new PostReferral(postReferralId, visitId, date, recorder, remarks));
            }
            //Returns the converted array to the caller of method
            return postReferralList.toArray(new PostReferral[0]);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static PostReferral getPostReferralByPostReferralId(int postReferralId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM postreferrals where postreferral_id = ?");
            stmt.setInt(1, postReferralId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int visitId = rs.getInt("visit_id");
                String date = rs.getString("date");
                String recorder = rs.getString("recorder");
                String remarks = rs.getString("remarks");
                return new PostReferral(postReferralId, visitId, date, recorder, remarks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static ArrayList<PostReferral> getPostReferralsByVisitId(int visitId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<PostReferral> postReferralList = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from postreferrals where visit_id = ?");
            stmt.setInt(1, visitId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int postReferralId = rs.getInt("postreferral_id");
                String date = rs.getString("date");
                String recorder = rs.getString("recorder");
                String remarks = rs.getString("remarks");
                postReferralList.add(new PostReferral(postReferralId, visitId, date, recorder, remarks));
            }
            return postReferralList;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static PostReferral getLatestPostReferralByVisitId(int visitId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from postreferrals where visit_id = ?\n" +
"order by date DESC \n" +
"limit 1;");
            stmt.setInt(1, visitId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                int postReferralId = rs.getInt("postreferral_id");
                String date = rs.getString("date");
                String recorder = rs.getString("recorder");
                String remarks = rs.getString("remarks");
                return new PostReferral(postReferralId, visitId, date, recorder, remarks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
}
