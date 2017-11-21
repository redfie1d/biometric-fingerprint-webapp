package model;

public class Consult {
    private int visitId;
    private String doctor;
    private String notes;
    private String diagnosis;
    private String problems;

    public Consult(int visitId, String doctor, String notes, String diagnosis, String problems) {
        this(visitId, doctor);
        this.notes = notes;
        this.diagnosis = diagnosis;
        this.problems = problems;
    }

    public Consult(int visitId, String doctor) {
        this.visitId = visitId;
        this.doctor = doctor;
    }
    
    public int getVisitId() {
        return visitId;
    }

    public String getDoctor() {
        return doctor;
    }

    public String getNotes() {
        return notes;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public String getProblems() {
        return problems;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public void setDoctor(String doctor) {
        this.doctor = doctor;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public void setProblems(String problems) {
        this.problems = problems;
    } 
}