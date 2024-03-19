package org.example;

import java.time.LocalDate;
import java.util.Date;

public class User extends Person {
    private int addressId;
    private String email;
    private String passwordHash;
    private String tcNo;

    public User(int id, String firstName, String lastName, LocalDate birthdate) {
        super(id, firstName, lastName, birthdate);
    }

    public User(int id, String firstName, String lastName, LocalDate birthdate, int addressId, String email, String passwordHash, String tcNo) {
        super(id, firstName, lastName, birthdate);
        this.addressId = addressId;
        this.email = email;
        this.passwordHash = passwordHash;
        this.tcNo = tcNo;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getTcNo() {
        return tcNo;
    }

    public void setTcNo(String tcNo) {
        this.tcNo = tcNo;
    }
}
