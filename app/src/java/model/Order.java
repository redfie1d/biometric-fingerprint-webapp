/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author Kwtam
 */
public class Order {
    private int orderID;
    private String doctor;
    private int patientID;
    private String medicine;
    private int quantity;
    private String notes;
    private String remarks;

    public Order(int orderID, String doctor, int patientID, String medicine, int quantity, String notes, String remarks) {
        this.orderID = orderID;
        this.doctor = doctor;
        this.patientID = patientID;
        this.medicine = medicine;
        this.quantity = quantity;
        this.notes = notes;
        this.remarks = remarks;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getDoctor() {
        return doctor;
    }

    public void setDoctor(String doctor) {
        this.doctor = doctor;
    }

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public String getMedicine() {
        return medicine;
    }

    public void setMedicine(String medicine) {
        this.medicine = medicine;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    

    
    
}
