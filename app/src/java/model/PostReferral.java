package model;

public class PostReferral {
    private int postReferralId;
    private int visitId;
    private String date;
    private String recorder;
    private String remarks;
    
    public PostReferral(int visitId, String date, String recorder, String remarks) {
        this.visitId = visitId;
        this.date = date;
        this.recorder = recorder;
        this.remarks = remarks;
    }

    public PostReferral(int postReferralId, int visitId, String date, String recorder, String remarks) {
        this.postReferralId = postReferralId;
        this.visitId = visitId;
        this.date = date;
        this.recorder = recorder;
        this.remarks = remarks;
    }
    
    public int getPostReferralId() {
        return postReferralId;
    }

    public int getVisitId() {
        return visitId;
    }
    
    public String getDate() {
        return date;
    }
    
    public String getRecorder() {
        return recorder;
    }
 
    public String getRemarks() {
        return remarks;
    }
    
    public void setPostReferralId(int postReferralIdId) {
        this.postReferralId = postReferralId;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }
    
    public void setDate(String date) {
        this.date = date;
    }
    
    public void setRecorder(String recorder) {
        this.recorder = recorder;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}