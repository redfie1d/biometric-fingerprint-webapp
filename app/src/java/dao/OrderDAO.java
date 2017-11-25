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
import model.Order;

/**
 *
 * @author Kwtam
 */
public class OrderDAO { 
    public static void updateInventory(String pVillage, int pNo) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from patients where id = ? and village_prefix = ?");
            stmt.setInt(1, pNo);
            stmt.setString(2, pVillage);
            rs = stmt.executeQuery();

            ArrayList<Integer> allergies = new ArrayList<>();
            if (rs.next()) {
                String village = rs.getString("village_prefix");
                int patientId = rs.getInt("id");
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                int birthYear = rs.getInt("year_of_birth");
                int parentId = rs.getInt("parent");
                String allergy = rs.getString("drug_allergy");

//                allergies.add(allergy);
//                while (rs.next()) {
//                    allergy = rs.getInt(7);
//                    allergies.add(allergy);
//                }
//                Patient p = new Patient(village, patientId, name, gender, birthYear, parentId, allergy);
//                p.setPhotoImage(rs.getString("image"));
//                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
//        return null;
    }
    
    public static boolean placeOrder(String doctor, String medicineName, int quantity) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("INSERT INTO orders values(NULL,?,?,?)");
            
            stmt.setString(1, doctor);
            stmt.setString(2, medicineName);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return false;
    }
    
    public static Order getOrder(int order){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from orders");
            rs = stmt.executeQuery();

            if (rs.next()) {
                int orderID = rs.getInt("order_id");
                String doctor = rs.getString("doctor");
                String medicine = rs.getString("medicine_name");
                int quantity = rs.getInt("quantity");
                
                return new Order(orderID, doctor, medicine, quantity);
            }
            //Returns the converted array to the caller of method
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static ArrayList<Order> getOrders(){
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Order> orderList = new ArrayList();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from orders");
            rs = stmt.executeQuery();

            while (rs.next()) {
                int orderID = rs.getInt("order_id");
                String doctor = rs.getString("doctor");
                String medicine = rs.getString("medicine_name");
                int quantity = rs.getInt("quantity");
                
                orderList.add(new Order(orderID, doctor, medicine, quantity));
            }
            //Returns the converted array to the caller of method
            return orderList;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
    
    public static void removeOrder(int orderID){
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("delete from orders where order_id = ?");
            stmt.setInt(1, orderID);
            stmt.executeUpdate();
        } catch(SQLException e){
            e.printStackTrace();
        }
    }
}
