package model;

import java.util.ArrayList;

public class Patient {
    private String village;
    private int patientId;
    private String name;
    private String gender;
    private int birthYear;
    private int parentId;
    private ArrayList<Integer> allergies;
    
    // attribute for image 
    // attribute for fingerprint
    
    private ArrayList<Visit> visits;

    public Patient(String village, int patientId, String name, String gender, int birthYear, int parentId, ArrayList<Integer> allergies, ArrayList<Visit> visits) {
        this(village,patientId,name,gender,birthYear,parentId,allergies);
        this.visits = visits;
    }

    public Patient(String village, int patientId, String name, String gender, int birthYear, int parentId, ArrayList<Integer> allergies) {
        this.village = village;
        this.patientId = patientId;
        this.name = name;
        this.gender = gender;
        this.birthYear = birthYear;
        this.parentId = parentId;
        this.allergies = allergies; 
    }

    public String getVillage() {
        return village;
    }

    public int getPatientId() {
        return patientId;
    }

    public String getName() {
        return name;
    }

    public String getGender() {
        return gender;
    }

    public int getBirthYear() {
        return birthYear;
    }

    public int getParentId() {
        return parentId;
    }

    public ArrayList<Visit> getVisits() {
        return visits;
    }

    public void setVillage(String village) {
        this.village = village;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setBirthYear(int birthYear) {
        this.birthYear = birthYear;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }
    
    public void addVisit(Visit v) {
        if(visits == null) { 
            visits = new ArrayList<Visit>();
        }
        
        visits.add(v);
    } 
}