package com.ispan.Maji.domain;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "ResetPasswordToken")
public class ResetPasswordTokenBean {
    @Id
    @Column(name = "tokenID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer tokenID;

    @Column(name = "token", columnDefinition = "varchar", nullable = false)
    private String token;

    @Column(name = "expiryDate", columnDefinition = "datetime", nullable = false)
    private Date expiryDate;

    @Column(name = "fk_userID", columnDefinition = "int", nullable = false)
    private Integer userID;
}