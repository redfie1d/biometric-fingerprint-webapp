/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import model.Patient;

/**
 *
 * @author tcw
 */
public class FingerprintDAO {
    
    public static void addFingerprint(int patientID, byte [] fingerprint, int size, byte[] fgImage) {

        //Variables that are required are declared as null first
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //Creates a connection manager object 
        ConnectionManager cm = new ConnectionManager();

        try {
            //Opens a connection
            conn = ConnectionManager.getConnection();

            //Statement to insert information into the database: user_id, password, name, school, edollar
            pstmt = conn.prepareStatement("INSERT INTO fingerprint "
//                    + "(patient_id, fg_value, size, fg_image) VALUES(?, ?, ?, ?)");
                    + "(patient_id, fg_value, size) VALUES(?, ?, ?)");
            
//            System.out.println("imageLength" + fgImage.length);
            
            //Sets the objects retrieved from the getter methods into the variables
            pstmt.setInt(1, patientID);
            pstmt.setBlob(2, new javax.sql.rowset.serial.SerialBlob(fingerprint));
            pstmt.setInt(3, size);
//            pstmt.setBlob(4, new javax.sql.rowset.serial.SerialBlob(fgImage));
//            pstmt.setString(4, Base64.getEncoder().encodeToString(fgImage));

            //Executes the update and stores data into database
            pstmt.executeUpdate();

            //Catches any possible SQL exception
        } catch (SQLException e) {
            e.printStackTrace();

            //Closes connection
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
    }
    
    public static ArrayList<Patient> getFingerprints() {
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        ArrayList <Patient> patientList = new ArrayList<>();

        try {
            conn = ConnectionManager.getConnection();
            stmt = conn.prepareStatement("select * from fingerprint");
            rs = stmt.executeQuery();

            while (rs.next()) {
                String userID = rs.getString("id");
                int patientID = rs.getInt("patient_id");
                Blob fg = rs.getBlob("fg_value");
                int size = rs.getInt("size");
                Blob fgImageBlob = rs.getBlob("fg_image");
                
                byte [] fgValue = fg.getBytes(1, (int)fg.length());
                
                
                Patient patient = new Patient();
                
                patient.setPatientId(patientID);
                patient.setFingerprint(fgValue);
                patient.setFgSize(size);
                
                if (fgImageBlob != null){
                    byte [] fgImage = fgImageBlob.getBytes(1, (int)fgImageBlob.length());
                    patient.setFgImage(fgImage);
                    fgImageBlob.free();
                }
                
                patientList.add(patient);
                
                fg.free();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patientList;
    }
    
}
