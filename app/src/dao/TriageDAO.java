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

/**
 *
 * @author yu.fu.2015
 */
public class TriageDAO {
    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;
    public boolean insertData(int visitId, double height, double weight, double systolic, double diastolic){
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO triages values(?,?,?,?,?)");
            stmt.setInt(1, visitId);
            stmt.setDouble(2, height);
            stmt.setDouble(3, weight);
            stmt.setDouble(4, systolic);
            stmt.setDouble(5, diastolic);
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
