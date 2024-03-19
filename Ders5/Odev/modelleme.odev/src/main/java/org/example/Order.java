package org.example;

import java.time.LocalDate;
import java.util.Date;

public class Order {
    private int id;
    private int shipperId;
    private int userId;
    private int paymentTypeId;
    private LocalDate orderDate;
    private boolean isDelivered;
    private String cargoNo;
    private double totalPrice;

    public Order() {
    }

    public Order(int id, int shipperId, int userId, int paymentTypeId, LocalDate orderDate, boolean isDelivered, String cargoNo, double totalPrice) {
        this.id = id;
        this.shipperId = shipperId;
        this.userId = userId;
        this.paymentTypeId = paymentTypeId;
        this.orderDate = orderDate;
        this.isDelivered = isDelivered;
        this.cargoNo = cargoNo;
        this.totalPrice = totalPrice;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getShipperId() {
        return shipperId;
    }

    public void setShipperId(int shipperId) {
        this.shipperId = shipperId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPaymentTypeId() {
        return paymentTypeId;
    }

    public void setPaymentTypeId(int paymentTypeId) {
        this.paymentTypeId = paymentTypeId;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public boolean isDelivered() {
        return isDelivered;
    }

    public void setDelivered(boolean delivered) {
        isDelivered = delivered;
    }

    public String getCargoNo() {
        return cargoNo;
    }

    public void setCargoNo(String cargoNo) {
        this.cargoNo = cargoNo;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
