package model;

public class Vitals {
    private int visitId;
    private double height;
    private double weight;
    private double systolic;
    private double diastolic;
    private double temperature;
    private int hivPositive;
    private int ptbPositive;
    private int hepCPositive;

    public Vitals(int visitId, double height, double weight, double systolic, double diastolic, double temperature, int hivPositive, int ptbPositive, int hepCPositive) {
        this.visitId = visitId;
        this.height = height;
        this.weight = weight;
        this.systolic = systolic;
        this.diastolic = diastolic;
        this.temperature = temperature;
        this.hivPositive = hivPositive;
        this.ptbPositive = ptbPositive;
        this.hepCPositive = hepCPositive;
    }
    
    public Vitals(int visitId, double height, double weight, double systolic, double diastolic, double temperature) {
        this.visitId = visitId;
        this.height = height;
        this.weight = weight;
        this.systolic = systolic;
        this.diastolic = diastolic;
        this.temperature = temperature;
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
    
    public double getTemperature() {
        return temperature;
    }
    
    public int getHivPositive() {
        return hivPositive;
    }
    
    public int getPtbPositive() {
        return ptbPositive;
    }
    
    public int getHepCPositive() {
        return hepCPositive;
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

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public void setHivPositive(int hivPositive) {
        this.hivPositive = hivPositive;
    }

    public void setPtbPositive(int ptbPositive) {
        this.ptbPositive = ptbPositive;
    }
    
    public void setHepCPositive(int hepCPositive) {
        this.hepCPositive = hepCPositive;
    }
}