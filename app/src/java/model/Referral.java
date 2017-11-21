package model;

public class Referral {
    private int visitId;
    private String condition;
    private String test;
    private String parameters;
    private String remarks;

    public Referral(int visitId, String condition, String test, String parameters, String remarks) {
        this.visitId = visitId;
        this.condition = condition;
        this.test = test;
        this.parameters = parameters;
        this.remarks = remarks;
    }

    public int getVisitId() {
        return visitId;
    }

    public String getCondition() {
        return condition;
    }

    public String getTest() {
        return test;
    }

    public String getParameters() {
        return parameters;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public void setTest(String test) {
        this.test = test;
    }

    public void setParameters(String parameters) {
        this.parameters = parameters;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}