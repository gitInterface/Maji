package com.ispan.Maji.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "Payment")
public class PaymentBean {
    @Id
    @Column(name = "paymentID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer paymentID;

    @Column(name = "fk_cartID", columnDefinition = "int")
	private String cartID;

    @Column(name = "isPaid", columnDefinition = "bit")
    private Boolean isPaid;
}
