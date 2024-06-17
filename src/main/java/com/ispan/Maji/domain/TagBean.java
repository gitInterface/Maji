package com.ispan.Maji.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "Tag")
public class TagBean {
    @Id
    @Column(name = "tag", columnDefinition = "nvarchar", length = 20)
    private String tag;
}
