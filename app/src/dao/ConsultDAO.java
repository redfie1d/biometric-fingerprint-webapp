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

/**
 *
 * @author yu.fu.2015
 */
public class ConsultDAO {
    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;
    
    public boolean insertData(int visitId, String doctor, String notes, String diagnosis, String problems){
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO visits values(?,?,?,?,?)");
            
            
            stmt.setInt(1, visitId);
            stmt.setString(2, doctor);
            stmt.setString(3, notes);
            stmt.setString(4, diagnosis);
            stmt.setString(5, problems);
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
