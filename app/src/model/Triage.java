package model;

public class Triage {
    private int visitId;
    private double height;
    private double weight;
    private double systolic;
    private double diastolic;

    public Triage(int visitId, double height, double weight, double systolic, double diastolic) {
        this.visitId = visitId;
        this.height = height;
        this.weight = weight;
        this.systolic = systolic;
        this.diastolic = diastolic;
    }

    public int getVisitId() {
        return visitId;
    }

    public double getHeight() {
        return height;
    }

    public double getWeight() {
        return weight;
    }

    public double getSystolic() {
        return systolic;
    }

    public double getDiastolic() {
        return diastolic;
    }

    public void setVisitId(int visitId) {
        this.visitId = visitId;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public void setSystolic(double systolic) {
        this.systolic = systolic;
    }

    public void setDiastolic(double diastolic) {
        this.diastolic = diastolic;
    }
}