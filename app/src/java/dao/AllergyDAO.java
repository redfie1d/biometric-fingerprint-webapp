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
import model.Allergy;

/**
 *
 * @author yu.fu.2015
 */
public class AllergyDAO {
    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public String getAllergyNameByAllergyID(int allergyID) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select allergyName from allergies where allergyId = ?");
            stmt.setInt(1, allergyID);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String allergyName = rs.getString(2);
                return allergyName;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
}
