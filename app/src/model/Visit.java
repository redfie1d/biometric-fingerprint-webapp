package model;

public class Visit {
    private int id;
    private int patientId;
    private String date;
    
    private Triage t;
    private Consult c;
    private Referral r;

    public Visit(int id, int patientId, String date, Triage t, Consult c, Referral r) {
        this(id, patientId, date);
        this.t = t;
        this.c = c;
        this.r = r;
    }

    public Visit(int id, int patientId, String date) {
        this.id = id;
        this.patientId = patientId;
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public int getPatientId() {
        return patientId;
    }

    public String getDate() {
        return date;
    }

    public Triage getTriage() {
        return t;
    }

    public Consult getConsult() {
        return c;
    }

    public Referral getReferral() {
        return r;
    }
    
    public void setId(int id) {
        this.id = id;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setTriage(Triage t) {
        this.t = t;
    }

    public void setConsult(Consult c) {
        this.c = c;
    }   

    public void setReferral(Referral r) {
        this.r = r;
    }
}