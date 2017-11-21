/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author tcw
 */
public class Fingerprint {
    
    private byte[] fingerprintValue;
    private int fingerprintSize;
    private byte[] fingerprintImage;
    private int fingerprintIndex;

    public Fingerprint(byte[] fingerprintValue, int fingerprintSize, byte[] fingerprintImage, int fingerprintIndex) {
        this.fingerprintValue = fingerprintValue;
        this.fingerprintSize = fingerprintSize;
        this.fingerprintImage = fingerprintImage;
        this.fingerprintIndex = fingerprintIndex;
    }

    public byte[] getFingerprintValue() {
        return fingerprintValue;
    }

    public void setFingerprintValue(byte[] fingerprintValue) {
        this.fingerprintValue = fingerprintValue;
    }

    public int getFingerprintSize() {
        return fingerprintSize;
    }

    public void setFingerprintSize(int fingerprintSize) {
        this.fingerprintSize = fingerprintSize;
    }

    public byte[] getFingerprintImage() {
        return fingerprintImage;
    }

    public void setFingerprintImage(byte[] fingerprintImage) {
        this.fingerprintImage = fingerprintImage;
    }

    public int getFingerprintIndex() {
        return fingerprintIndex;
    }

    public void setFingerprintIndex(int fingerprintIndex) {
        this.fingerprintIndex = fingerprintIndex;
    }

}
