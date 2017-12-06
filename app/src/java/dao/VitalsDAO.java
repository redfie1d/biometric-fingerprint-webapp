/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Vitals;

/**
 *
 * @author yu.fu.2015
 */
public class VitalsDAO {

    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public boolean insertData(int visitId, double height, double weight, double systolic, double diastolic, double temperature, int hivPositive, int ptbPositive, int hepCPositive) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO vitals (visit_id, height, weight, systolic, diastolic, temperature, hiv_positive, ptb_positive, hepC_positive) values (?,?,?,?,?,?,?,?,?)");
            stmt.setInt(1, visitId);
            stmt.setDouble(2, height);
            stmt.setDouble(3, weight);
            stmt.setDouble(4, systolic);
            stmt.setDouble(5, diastolic);
            stmt.setDouble(6, temperature);
            stmt.setDouble(7, hivPositive);
            stmt.setDouble(8, ptbPositive);
            stmt.setDouble(9, hepCPositive);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }

    public static Vitals getDataByVisitID(int visitId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("SELECT * FROM vitals where visit_id=? and vitals_id = (SELECT max(vitals_id) FROM vitals where visit_id = ?)");
            stmt.setInt(1, visitId);
            stmt.setInt(2, visitId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                int visitID = rs.getInt("visit_id");
                double height = rs.getDouble("height");
                double weight = rs.getDouble("weight");
                double systolic = rs.getDouble("systolic");
                double diastolic = rs.getDouble("diastolic");
                double temperature = rs.getDouble("temperature");
                int hivPosititive = rs.getInt("hiv_positive");
                int ptbPosititive = rs.getInt("ptb_positive");
                int hepCPositive = rs.getInt("hepC_Positive");

                Vitals vitals = new Vitals(visitId, height, weight, systolic, diastolic, temperature, hivPosititive, ptbPosititive, hepCPositive);
                return vitals;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
}
