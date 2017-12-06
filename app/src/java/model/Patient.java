package model;

import java.util.ArrayList;

public class Patient {
    private String village;
    private int patientId;
    private String name;
    private String gender;
    private String dateOfBirth;
    private int parentId;
    private String allergies;
    private String photoImage;
    private String contactNo;
    private int travellingTimeToClinic;
    
    // attribute for image 
    // attribute for fingerprint
    private byte[] fingerprint;
    private int fgSize;
    private byte[] fgImage;
    
    private Fingerprint fingerprintOne;
    private Fingerprint fingerprintTwo;
    
    private ArrayList<Visit> visits;

    public Patient(){}
    
    public Patient(String village, int patientId, String name, String gender, String dateOfBirth, int parentId, String allergies, ArrayList<Visit> visits) {
        this(village,patientId,name,gender,dateOfBirth,parentId,allergies);
        this.visits = visits;
    }

    public Patient(String village, int patientId, String name, String gender, String dateOfBirth, int parentId, String allergies) {
        this.village = village;
        this.patientId = patientId;
        this.name = name;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.parentId = parentId;
        this.allergies = allergies; 
    }
    
    public Patient(String village, int patientId, String name, String contactNo, String gender, String dateOfBirth, int travellingTimeToClinic, int parentId, String allergies) {
        this.village = village;
        this.patientId = patientId;
        this.name = name;
        this.contactNo = contactNo;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.parentId = parentId;
        this.travellingTimeToClinic = travellingTimeToClinic;
        this.allergies = allergies; 
    }

    public int getTravellingTimeToClinic() {
        return travellingTimeToClinic;
    }

    public void setTravellingTimeToClinic(int travellingTimeToClinic) {
        this.travellingTimeToClinic = travellingTimeToClinic;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }
    
    public String getAllergies() {
        return allergies;
    }

    public void setAllergies(String allergies) {
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

    public String getDateOfBirth() {
        return dateOfBirth;
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

    public void setBirthYear(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
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
    
    public byte[] getFingerprint() {
        return fingerprint;
    }

    public void setFingerprint(byte[] fingerprint) {
        this.fingerprint = fingerprint;
    }

    public int getFgSize() {
        return fgSize;
    }

    public void setFgSize(int fgSize) {
        this.fgSize = fgSize;
    }

    public byte[] getFgImage() {
        return fgImage;
    }

    public void setFgImage(byte[] fgImage) {
        this.fgImage = fgImage;
    }

    public String getPhotoImage() {
        return photoImage;
    }

    public void setPhotoImage(String photoImage) {
        this.photoImage = photoImage;
    }

    public Fingerprint getFingerprintOne() {
        return fingerprintOne;
    }

    public void setFingerprintOne(Fingerprint fingerprintOne) {
        this.fingerprintOne = fingerprintOne;
    }

    public Fingerprint getFingerprintTwo() {
        return fingerprintTwo;
    }

    public void setFingerprintTwo(Fingerprint fingerprintTwo) {
        this.fingerprintTwo = fingerprintTwo;
    }
    
    
}