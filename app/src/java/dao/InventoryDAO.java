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
import model.Drug;
import model.Order;

/**
 *
 * @author Kwtam
 */
public class InventoryDAO {
    public static ArrayList<Drug> getInventory(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Drug> drugList = new ArrayList();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from inventory");
            rs = stmt.executeQuery();

            while (rs.next()) {
                String medicine = rs.getString("medicine_name");
                int quantity = rs.getInt("quantity");
                
                drugList.add(new Drug(medicine, quantity));
            }
            //Returns the converted array to the caller of method
            return drugList;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static int getDrugQuantity(String name){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from inventory where medicine_name = ?");
            stmt.setString(1, name);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("quantity");
            }
            //Returns the converted array to the caller of method

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return 0;
    }
    
    public static boolean updateInventory(String medicine, int quantity){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("update inventory set quantity = ? where medicine_name = ?");
            stmt.setDouble(1, quantity);
            stmt.setString(2, medicine);
            stmt.executeUpdate();
            
            return true;
            //Returns the converted array to the caller of method

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }
}
