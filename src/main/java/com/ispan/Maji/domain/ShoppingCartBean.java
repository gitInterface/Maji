package com.ispan.Maji.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
	private Integer userID;

    @Column(name = "fk_productID", columnDefinition = "int")
	private Integer productID;

    @Column(name = "numbers", columnDefinition = "int")
    private Integer numbers;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_productID", insertable = false, updatable = false)
    private ProductBean product;
}
