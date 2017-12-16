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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author JunMing
 */
public class UserDAO {
    public static User retrieve(String username) {

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        User user = null;
        String sql = "SELECT name, password, account_type FROM users WHERE username = ?";

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);

            rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String password = rs.getString("password");
                String accountType = rs.getString("account_type");
                user = new User(name, username, password, accountType);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return user;
    }
    
    public static ArrayList<String> retrieveAllDoctors() {

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        ArrayList<String> userList = new ArrayList<>();
        String sql = "SELECT name FROM users where account_type = 'alumni' or account_type = 'acts' or account_type = 'm4'";

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement(sql);

            rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                userList.add(name);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return userList;
    }
}
