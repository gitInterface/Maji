package com.ispan.Maji.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "[User]")
public class UserBean {
    @Id
    @Column(name = "userID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userID;

    @Column(name = "email", columnDefinition = "varchar", length = 100, unique = true, nullable = false)
    private String email;

    @Column(name = "password", columnDefinition = "varchar", length = 20, nullable = false)
    private String password;

    @Column(name = "isAdmin", columnDefinition = "bit")
    private Boolean isAdmin;

    @Column(name = "name", columnDefinition = "nvarchar", length = 10)
	private String name;

    @Column(name = "gender", columnDefinition = "varchar", length = 10)
	private String gender;

    @Column(name = "phone", columnDefinition = "varchar", length = 20)
	private String phone;

    @Column(name = "image", columnDefinition = "varbinary")
	private byte[] image;

    @Column(name = "birth", columnDefinition = "datetime")
	private Date birth;

    @Column(name = "createdAt", columnDefinition = "datetime", nullable = false)
	private Date createdAt;

    @PrePersist
    protected void onCreateDate() {
        createdAt = new Date();
    }
}
