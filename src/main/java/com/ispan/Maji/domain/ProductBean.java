package com.ispan.Maji.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Data
@Entity
@Table(name = "Product")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class ProductBean {
    @Id
    @Column(name = "productID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer productID;

    @Column(name = "productName", columnDefinition = "nvarchar", length = 100)
    private String productName;

    @Column(name = "discription", columnDefinition = "nvarchar", length = 500)
    private String discription;

    @Column(name = "picture", columnDefinition = "varbinary")
	private byte[] picture;

    @Column(name = "price", columnDefinition = "int")
    private Integer price;

    @Column(name = "fk_tag", columnDefinition = "nvarchar", length = 20)
	private String tag;

    @Transient
    private String pictureBase64;

    public String getPictureBase64(){
        return pictureBase64;
    }
    public void setPictureBase64(String pictureBase64){
        this.pictureBase64 = pictureBase64;
    }

}
