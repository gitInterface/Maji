package com.ispan.Maji.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "[Admin]")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class AdminBean {
    @Id
    @Column(name = "adminID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer adminID;

    @Column(name = "account", columnDefinition = "nvarchar", length = 20, unique = true, nullable = false)
    private String account;

    @Column(name = "password", columnDefinition = "varchar", length = 20, nullable = false)
    private String password;

    @Column(name = "createdAt", columnDefinition = "datetime", nullable = false)
	private Date createdAt;

    @PrePersist
    protected void onCreateDate() {
        createdAt = new Date();
    }
}
