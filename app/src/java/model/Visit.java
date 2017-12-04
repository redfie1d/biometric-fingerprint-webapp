package model;

public class Visit {
    private int id;
    private int patientId;
    private String date;
    private String status;
    
    private Triage t;
    private Consult c;
    private PostReferral r;

    public Visit(int id, int patientId, String date, Triage t, Consult c, PostReferral r) {
        this(id, patientId, date);
        this.t = t;
        this.c = c;
        this.r = r;
    }

    public Visit(int id, int patientId, String date, Triage t, Consult c, PostReferral r, String status) {
        this(id, patientId, date);
        this.t = t;
        this.c = c;
        this.r = r;
        this.status = status;
    }
    
    public Visit(int id, int patientId, String date, Triage t, String status) {
        this.t = t;
        this.id = id;
        this.patientId = patientId;
        this.date = date;
        this.status = status;
    }
    
    public Visit(int id, int patientId, String date, Triage t) {
        this.t = t;
        this.id = id;
        this.patientId = patientId;
        this.date = date;
    }
    
    public Visit(int id, int patientId, String date) {
        this.id = id;
        this.patientId = patientId;
        this.date = date;
    }
    
    public Visit(int id, int patientId, String date, String status) {
        this.id = id;
        this.patientId = patientId;
        this.date = date;
        this.status = status;
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

    public PostReferral getPostReferral() {
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

    public void setPostReferral(PostReferral r) {
        this.r = r;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}