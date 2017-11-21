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
import model.Patient;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class PatientDAO {

    Connection conn;
    ResultSet rs;
    PreparedStatement stmt;

    public Patient getPatientByPatientID(int patientID) {
        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("Select * from patients where patientId = ?");
            stmt.setInt(1, patientID);
            rs = stmt.executeQuery();

            ArrayList<Integer> allergies = new ArrayList<>();
            if (rs.next()) {
                String village = rs.getString(1);
                int patientId = rs.getInt(2);
                String name = rs.getString(3);
                String gender = rs.getString(4);
                int birthYear = rs.getInt(5);
                int parentId = rs.getInt(6);
                int allergy = rs.getInt(7);

                allergies.add(allergy);

                while (rs.next()) {
                    allergy = rs.getInt(7);
                    allergies.add(allergy);
                }
                return new Patient(village, patientId, name, gender, birthYear, parentId, allergies);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConnectionManager.close(conn, stmt, rs);
        }
        return null;
    }
}
