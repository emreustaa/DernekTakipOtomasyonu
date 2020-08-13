/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package postgresqlproject;

/**
 *
 * @author emreu
 */
public class Burs {
    
    private int bursId;
    private int tutar;
    private String verilmeTarihi;
    private String baslangicTarihi;
    private String bitisTarihi;
    private String bursiyer;

    public Burs() {
    }

    public Burs(int bursId, int tutar, String verilmeTarihi, String baslangicTarihi, String bitisTarihi, String bursiyer) {
        this.bursId = bursId;
        this.tutar = tutar;
        this.verilmeTarihi = verilmeTarihi;
        this.baslangicTarihi = baslangicTarihi;
        this.bitisTarihi = bitisTarihi;
        this.bursiyer = bursiyer;
    }

    public int getBursId() {
        return bursId;
    }

    public void setBursId(int bursId) {
        this.bursId = bursId;
    }

    public int getTutar() {
        return tutar;
    }

    public void setTutar(int tutar) {
        this.tutar = tutar;
    }

    public String getVerilmeTarihi() {
        return verilmeTarihi;
    }

    public void setVerilmeTarihi(String verilmeTarihi) {
        this.verilmeTarihi = verilmeTarihi;
    }

    public String getBaslangicTarihi() {
        return baslangicTarihi;
    }

    public void setBaslangicTarihi(String baslangicTarihi) {
        this.baslangicTarihi = baslangicTarihi;
    }

    public String getBitisTarihi() {
        return bitisTarihi;
    }

    public void setBitisTarihi(String bitisTarihi) {
        this.bitisTarihi = bitisTarihi;
    }

    public String getBursiyer() {
        return bursiyer;
    }

    public void setBursiyer(String bursiyer) {
        this.bursiyer = bursiyer;
    }
    
    
}
