package com.ispan.Maji.domain;

import java.util.Base64;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Data
@Entity
@Table(name = "News")
public class NewsBean {
    @Id
    @Column(name = "newsID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer newsID;

    @Column(name = "title", columnDefinition = "nvarchar", length = 100, nullable = false)
    private String title;

    @Lob
    @Column(name = "content", columnDefinition = "nvarchar", nullable = false)
    private String content;

    @Column(name = "picture", columnDefinition = "varbinary")
	private byte[] picture;

    @Column(name = "createdAt", columnDefinition = "datetime", nullable = false)
	private Date createdAt;

    @Column(name = "fk_adminID", columnDefinition = "int", nullable = false)
    private Integer adminID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fk_adminID", insertable = false, updatable = false)
    private AdminBean admin;
    
    @Transient
    private String pictureBase64;

    @PrePersist
    protected void onCreateDate() {
        createdAt = new Date();
    }

    public String getPictureBase64() {
         if (this.picture != null) {
            return Base64.getEncoder().encodeToString(this.picture);
        }
        return null;
    }

    public void setPictureBase64(String pictureBase64) {
        this.pictureBase64 = pictureBase64;
    }
}
