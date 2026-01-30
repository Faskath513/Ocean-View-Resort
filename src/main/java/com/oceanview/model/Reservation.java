package com.oceanview.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;

public class Reservation implements Serializable {
    private int id;
    private String guestName;
    private String guestEmail;
    private String guestPhone;
    private String guestAddressStreet;
    private String guestAddressCity;
    private String guestAddressState;
    private String guestAddressZip;
    private String guestAddressCountry;
    private int roomId;
    private String roomType;
    private Date checkInDate;
    private Date checkOutDate;
    private BigDecimal totalAmount;
    private String status;
    private Room room; // For display purposes

    public Reservation() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getGuestEmail() {
        return guestEmail;
    }

    public void setGuestEmail(String guestEmail) {
        this.guestEmail = guestEmail;
    }

    public String getGuestPhone() {
        return guestPhone;
    }

    public void setGuestPhone(String guestPhone) {
        this.guestPhone = guestPhone;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGuestAddressStreet() {
        return guestAddressStreet;
    }

    public void setGuestAddressStreet(String guestAddressStreet) {
        this.guestAddressStreet = guestAddressStreet;
    }

    public String getGuestAddressCity() {
        return guestAddressCity;
    }

    public void setGuestAddressCity(String guestAddressCity) {
        this.guestAddressCity = guestAddressCity;
    }

    public String getGuestAddressState() {
        return guestAddressState;
    }

    public void setGuestAddressState(String guestAddressState) {
        this.guestAddressState = guestAddressState;
    }

    public String getGuestAddressZip() {
        return guestAddressZip;
    }

    public void setGuestAddressZip(String guestAddressZip) {
        this.guestAddressZip = guestAddressZip;
    }

    public String getGuestAddressCountry() {
        return guestAddressCountry;
    }

    public void setGuestAddressCountry(String guestAddressCountry) {
        this.guestAddressCountry = guestAddressCountry;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }
}
