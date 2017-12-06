package model;

public class Visit {
    private int id;
    private int patientId;
    private String date;
    private String status;
    
    private Vitals v;
    private Consult c;
    private PostReferral r;

    public Visit(int id, int patientId, String date, Vitals v, Consult c, PostReferral r) {
        this(id, patientId, date);
        this.v = v;
        this.c = c;
        this.r = r;
    }

    public Visit(int id, int patientId, String date, Vitals v, Consult c, PostReferral r, String status) {
        this(id, patientId, date);
        this.v = v;
        this.c = c;
        this.r = r;
        this.status = status;
    }
    
    public Visit(int id, int patientId, String date, Vitals v, String status) {
        this.v = v;
        this.id = id;
        this.patientId = patientId;
        this.date = date;
        this.status = status;
    }
    
    public Visit(int id, int patientId, String date, Vitals v) {
        this.v = v;
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

    public Vitals getVitals() {
        return v;
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

    public void setVitals(Vitals v) {
        this.v = v;
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