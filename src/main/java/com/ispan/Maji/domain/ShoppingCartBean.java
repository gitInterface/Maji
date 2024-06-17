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
@Table(name = "ShoppingCart")
public class ShoppingCartBean {
    @Id
    @Column(name = "cartID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cartID;

    @Column(name = "fk_userID", columnDefinition = "int")
	private String userID;

    @Column(name = "fk_productID", columnDefinition = "int")
	private String productID;

    @Column(name = "numbers", columnDefinition = "int")
    private Integer numbers;
}
