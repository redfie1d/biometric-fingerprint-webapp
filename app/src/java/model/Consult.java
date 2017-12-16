package model;

public class Consult {

    private int consult_id;
    private int visitId;
    private String date;
    private String doctor;
    private String notes;
    private String diagnosis;
    private String problems;
    private String urine_test;
    private String hemocue_count;
    private String blood_glucose;
    private String referrals;
    private boolean chronic_referral;

    public Consult(int consult_id, int visitId, String date, String doctor, String notes, String diagnosis, String problems) {
        this(visitId, doctor);
        this.date = date;
        this.notes = notes;
        this.diagnosis = diagnosis;
        this.problems = problems;
        this.consult_id = consult_id;
    }

    public Consult(int consult_id, int visitId, String date, String doctor, String notes, String diagnosis, String problems, String urine_test, String hemocue_count, String blood_glucose, String referrals, boolean chronic_referral) {
        this(visitId, doctor);
        this.consult_id = consult_id;
        this.date = date;
        this.notes = notes;
        this.diagnosis = diagnosis;
        this.problems = problems;
        this.urine_test = urine_test;
        this.hemocue_count = hemocue_count;
        this.blood_glucose = blood_glucose;
        this.referrals = referrals;
        this.chronic_referral = chronic_referral;
    }

    public Consult(int visitId, String date, String doctor, String notes, String diagnosis, String problems, String urine_test, String hemocue_count, String blood_glucose, String referrals, boolean chronic_referral) {
        this(visitId, doctor);
        this.date = date;
        this.notes = notes;
        this.diagnosis = diagnosis;
        this.problems = problems;
        this.urine_test = urine_test;
        this.hemocue_count = hemocue_count;
        this.blood_glucose = blood_glucose;
        this.referrals = referrals;
        this.chronic_referral = chronic_referral;
    }

    public Consult(int visitId, String doctor) {
        this.visitId = visitId;
        this.doctor = doctor;
    }

    public int getVisitId() {
        return visitId;
    }
    
    public String getConsultDate() {
        return date;
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

    public int getConsult_id() {
        return consult_id;
    }

    public void setConsult_id(int consult_id) {
        this.consult_id = consult_id;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }
    
    public void setConsultDate(String date) {
        this.date = date;
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

    public String getUrine_test() {
        return urine_test;
    }

    public String getHemocue_count() {
        return hemocue_count;
    }

    public String getBlood_glucose() {
        return blood_glucose;
    }

    public String getReferrals() {
        return referrals;
    }

    public void setUrine_test(String urine_test) {
        this.urine_test = urine_test;
    }

    public void setHemocue_count(String hemocue_count) {
        this.hemocue_count = hemocue_count;
    }

    public void setBlood_glucose(String blood_glucose) {
        this.blood_glucose = blood_glucose;
    }

    public void setReferrals(String referrals) {
        this.referrals = referrals;
    }

    public boolean isChronic_referral() {
        return chronic_referral;
    }

    public void setChronic_referral(boolean chronic_referral) {
        this.chronic_referral = chronic_referral;
    }
}
