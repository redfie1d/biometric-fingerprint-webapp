/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author JunMing
 */
public class Doctor {
    private int doctorId;
    private String name;
    private String username;
    private String password;
    
    public Doctor(int doctorId, String name, String username, String password) {
        this.doctorId = doctorId;
        this.name = name;
        this.username = username;
        this.password = password;
    }
    
    public int getDoctorId() {
        return doctorId;
    }
    
    public String getName() {
        return name;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
}
