package model;

public class Triage {
    private int visitId;
    private double height;
    private double weight;
    private double systolic;
    private double diastolic;
    private double temperature;
    private int hivPositive;
    private int ptbPositive;

    private int hepCPositive;

    /**
     * Get the value of hepCPositive
     *
     * @return the value of hepCPositive
     */
    public int getHepCPositive() {
        return hepCPositive;
    }

    /**
     * Set the value of hepCPositive
     *
     * @param hepCPositive new value of hepCPositive
     */
    public void setHepCPositive(int hepCPositive) {
        this.hepCPositive = hepCPositive;
    }

    public Triage(int visitId, double height, double weight, double systolic, double diastolic, double temperature, int hivPositive, int ptbPositive, int hepCPositive) {
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
    
    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public int getHivPositive() {
        return hivPositive;
    }

    public void setHivPositive(int hivPositive) {
        this.hivPositive = hivPositive;
    }

    public int getPtbPositive() {
        return ptbPositive;
    }

    public void setPtbPositive(int ptbPositive) {
        this.ptbPositive = ptbPositive;
    }
    
    public Triage(int visitId, double height, double weight, double systolic, double diastolic, double temperature) {
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