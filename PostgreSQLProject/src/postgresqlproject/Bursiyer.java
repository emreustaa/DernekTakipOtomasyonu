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
public class Bursiyer {

    private int bursiyerId;
    private int bursiyerNo;
    private String ad;
    private String soyad;
    private String okul;
    private String bolum;
    private String telefon;
    private String mail;
    private String babaAdi;
    private String referans;
    private String iban;
    private String koy;
    private String il;
    private String ilce;

    public Bursiyer() {
    }

    public Bursiyer(int bursiyerId, int bursiyerNo, String ad, String soyad, String okul, String bolum, String telefon, String mail, String babaAdi, String referans, String iban, String koy, String il, String ilce) {
        this.bursiyerId = bursiyerId;
        this.bursiyerNo = bursiyerNo;
        this.ad = ad;
        this.soyad = soyad;
        this.okul = okul;
        this.bolum = bolum;
        this.telefon = telefon;
        this.mail = mail;
        this.babaAdi = babaAdi;
        this.referans = referans;
        this.iban = iban;
        this.koy = koy;
        this.il = il;
        this.ilce = ilce;
    }

    public int getBursiyerId() {
        return bursiyerId;
    }

    public void setBursiyerId(int bursiyerId) {
        this.bursiyerId = bursiyerId;
    }

    public int getBursiyerNo() {
        return bursiyerNo;
    }

    public void setBursiyerNo(int bursiyerNo) {
        this.bursiyerNo = bursiyerNo;
    }

    public String getAd() {
        return ad;
    }

    public void setAd(String ad) {
        this.ad = ad;
    }

    public String getSoyad() {
        return soyad;
    }

    public void setSoyad(String soyad) {
        this.soyad = soyad;
    }

    public String getOkul() {
        return okul;
    }

    public void setOkul(String okul) {
        this.okul = okul;
    }

    public String getBolum() {
        return bolum;
    }

    public void setBolum(String bolum) {
        this.bolum = bolum;
    }

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getBabaAdi() {
        return babaAdi;
    }

    public void setBabaAdi(String babaAdi) {
        this.babaAdi = babaAdi;
    }

    public String getReferans() {
        return referans;
    }

    public void setReferans(String referans) {
        this.referans = referans;
    }

    public String getIban() {
        return iban;
    }

    public void setIban(String iban) {
        this.iban = iban;
    }

    public String getKoy() {
        return koy;
    }

    public void setKoy(String koy) {
        this.koy = koy;
    }

    public String getIl() {
        return il;
    }

    public void setIl(String il) {
        this.il = il;
    }

    public String getIlce() {
        return ilce;
    }

    public void setIlce(String ilce) {
        this.ilce = ilce;
    }
    
    

}
