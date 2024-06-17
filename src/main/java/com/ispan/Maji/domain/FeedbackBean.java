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
@Table(name = "Feedback")
public class FeedbackBean {
    @Id
    @Column(name = "feedbackID", columnDefinition = "int")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer feedbackID;

    @Column(name = "title", columnDefinition = "nvarchar", length = 100, nullable = false)
    private String title;

    @Column(name = "content", columnDefinition = "nvarchar", length = 1000, nullable = false)
    private String content;

    @Column(name = "fk_userID", columnDefinition = "int", nullable = false)
	private Integer userID;
}
