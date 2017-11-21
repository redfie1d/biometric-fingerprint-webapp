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
import model.Visit;

public class VisitDAO {

    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public int countTotalVisits(){
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select count(id) from visits");
            rs = stmt.executeQuery();
            int numOfTotalVisits = rs.getInt(1);
            return numOfTotalVisits;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return 0;
    }
    
    
    
    public Visit getVisitByVisitID(int visitId) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from visits where visitId = ?");
            stmt.setInt(1, visitId);
            rs = stmt.executeQuery();
            
            if(rs.next()) {
                int patientId = rs.getInt(2);
                String date = rs.getString(3);
                return new Visit(visitId, patientId,date);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public boolean insertData(int visitId, int patientId, String date){
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO visits values(?,?,?)");
            
            
            stmt.setInt(1, visitId);
            stmt.setInt(2, patientId);
            stmt.setString(3, date);
            
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

