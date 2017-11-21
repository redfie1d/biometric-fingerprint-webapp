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
public class ReferralDAO {

    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public boolean insertData(int visitId, String condition, String test, String parameters, String remarks) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO visits values(?,?,?,?,?)");

            stmt.setInt(1, visitId);
            stmt.setString(2, condition);
            stmt.setString(3, test);
            stmt.setString(4, parameters);
            stmt.setString(5, remarks);
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
